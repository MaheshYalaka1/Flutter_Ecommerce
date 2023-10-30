import 'package:database_flutter/firebase.dart';
import 'package:database_flutter/homepage.dart';
import 'package:database_flutter/user_auth/presentation/pages/singup_page.dart';
import 'package:database_flutter/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginPage();
}

class _LoginPage extends State<Login> {
  bool isSigning = false;
  final firebaseAuthService _auth = firebaseAuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "login",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                controller: _emailController,
                hintText: "email",
                isPasswordField: false,
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "password",
                isPasswordField: true,
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: _singIn,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: isSigning
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                ),
              ),
              SizedBox(
                height: 30,
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
                          MaterialPageRoute(builder: (context) => signUpPage()),
                          (Route) => false);
                    },
                    child: Text(
                      "sign in",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _singIn() async {
    setState(() {
      isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      isSigning = false;
    });

    if (user != null) {
      print(" user was successfully sign in");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    } else {
      print("some error hapend");
    }
  }
}
