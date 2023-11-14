import 'package:database_flutter/add_to_cart.dart';
import 'package:database_flutter/global/common/toast.dart';
import 'package:database_flutter/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:database_flutter/user_auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  final firebaseAuthService _authService = firebaseAuthService();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final CartModel cart = CartModel();
  Map<String, dynamic> finalResult = {}; // Store the result from the API
  bool isLoading = true;

  File? _image;

  @override
  void initState() {
    super.initState();
    _loadImage(); // Load the saved image path when the page opens
  }

  Future<void> _loadImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('imagePath');

    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _saveImage(); // Save the selected image path
      });
    }
  }

  Future<void> _saveImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('imagePath', _image?.path ?? '');
  }

  // Function to take a photo using the device's camera
  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _saveImage(); // Save the taken photo path
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _pickImage(); // Call the function to choose from the gallery
                      },
                      child: Text('Choose from Gallery'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // Remove background color
                        onPrimary: Colors.white, // Text color
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black), // Add border
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        _takePhoto(); // Call the function to take a photo
                      },
                      child: Text('Take Photo'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // Remove background color
                        onPrimary: Colors.white, // Text color
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black), // Add border
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () async {
                // Call the signOut method from AuthService
                await widget._authService.signOut();
                // You can add a toast message to indicate successful sign-out
                showToast(message: 'Logged out successfully');
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);
                // ignore: use_build_context_synchronously
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: Text('Sign Out'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Remove background color
                onPrimary: Colors.white, // Text color
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black), // Add border
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
