import 'package:database_flutter/bottomnavigation.dart';
import 'package:database_flutter/global/common/toast.dart';
import 'package:database_flutter/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:database_flutter/user_auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  final firebaseAuthService _authService = firebaseAuthService();
  final GlobalKey<MyBottomNavigationBarState> bottomNavigationKey;
  ProfilePage({required this.bottomNavigationKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('This is the Profile Page'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              // Call the signOut method from AuthService
              await _authService.signOut();
              // You can add a toast message to indicate successful sign-out
              showToast(message: 'Logged out successfully');
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false);
              // ignore: use_build_context_synchronously
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
