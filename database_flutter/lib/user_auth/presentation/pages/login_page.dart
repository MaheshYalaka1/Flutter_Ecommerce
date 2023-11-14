import 'package:database_flutter/TabScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'singup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPage();

  getCurrentUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return _auth.currentUser;
  }
}

class _LoginPage extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  final ForceRecaptchaFlow = true;

  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  double screenHeight = 0;
  double screenWidth = 0;
  double bottom = 0;

  String otpPin = "";
  String countryDial = "+1";
  String verificationId = ""; // Initialize verification ID for OTP

  int screenState = 0; // 0 for registration, 1 for OTP
  Color primaryColor = const Color(0xff0074E4); // Primary color
  @override
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      // The user is already logged in, navigate to the main screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TabScreen()),
      );
    }
  }

  // Function to verify the user's phone number using Firebase Authentication

  Future<void> verifyPhone(String number) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: number,
      timeout: const Duration(seconds: 30),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-verification if code is detected automatically by Firebase
        showSnackBarText("Authentication complete");
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
      },
      verificationFailed: (e) {
        if (e.code == "invalid-phone-number") {
          showSnackBarText('Error: Provided phone number is not valid.');
        } else {
          showSnackBarText('Error: Something went wrong. Try again.');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        // OTP code is sent, transition to OTP screen
        showSnackBarText("OTP sent !");
        this.verificationId = verificationId; // Save the verificationId
        setState(() {
          screenState = 1;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        showSnackBarText("TimeOut!");
      },
    );
  }

  // Function to verify the OTP entered by the user
  Future<void> verifyOTP() async {
    try {
      await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: otpPin,
        ),
      );

      // If verification is successful, set 'isLoggedIn' to true in SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      // Redirect to the home page upon successful verification
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => TabScreen(),
        ),
      );
    } catch (e) {
      // Handle authentication error, which likely means the OTP is incorrect
      showSnackBarText("Error: Incorrect OTP. Please try again.");
    }
  }

  void showSnackBarText(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void _setLoggedIn(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  @override
  void dispose() {
    // Clean up text controller resources when the widget is disposed
    usernameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve screen dimensions
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    bottom = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App logo or header image
              SizedBox(height: 20),
              // Sign-up form section
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Display registration or OTP form based on screenState
                    screenState == 0 ? stateRegister() : stateOTP(),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Handle the "Continue" button action
                        if (screenState == 0) {
                          if (phoneController.text.isEmpty) {
                            showSnackBarText("Phone number is still empty!");
                          } else {
                            verifyPhone(countryDial + phoneController.text);
                          }
                        } else {
                          if (otpPin.length >= 6) {
                            verifyOTP();
                          } else {
                            showSnackBarText("Enter OTP correctly");
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                      ),
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(" don't have an account?"),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()),
                                (Route) => false);
                          },
                          child: Text(
                            "sign in",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget stateRegister() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 16,
        ),
        Text(
          "Phone Number",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        IntlPhoneField(
          controller: phoneController,
          showCountryFlag: false,
          showDropdownIcon: false,
          initialValue: countryDial,
          onCountryChanged: (Country) {
            setState(() {
              countryDial = "+" + Country.dialCode;
            });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ],
    );
  }

  Widget stateOTP() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Enter OTP",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "We just sent a code to",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
              TextSpan(
                text: countryDial + phoneController.text,
                style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              TextSpan(
                text: "\nEnter the code here to continue",
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        PinCodeTextField(
          appContext: context,
          length: 6,
          onChanged: (value) {
            setState(() {
              otpPin = value;
            });
          },
          pinTheme: PinTheme(
            activeColor: primaryColor,
            selectedColor: primaryColor,
            inactiveColor: Colors.black,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: "Didn't receive the code?",
              style: TextStyle(
                color: Colors.black38,
                fontSize: 12,
              ),
            ),
            WidgetSpan(
              child: GestureDetector(
                onTap: () {
                  // Allow the user to resend the code
                  setState(() {
                    screenState = 0;
                  });
                },
                child: Text(
                  'Resend',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
