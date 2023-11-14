import 'package:database_flutter/TabScreen.dart';
import 'package:database_flutter/app/splash_screen/splash_screen.dart';
import 'package:database_flutter/user_auth/presentation/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'add_to_cart.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
      apiKey: "AIzaSyDK8i4efMiZM59gOYpvjLcjlD2Aer7t984",
      appId: "1:321803692958:web:c52343de3282945cbb848f",
      messagingSenderId: "321803692958",
      projectId: "new-flutter-fire-bd19e",
    ));
  }
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(), // Create CartModel instance
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "firebase auth",
      home: FutureBuilder(
        // Check the user's authentication status
        future: LoginPage().getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              // User is logged in, show the main activity
              return TabScreen();
            } else {
              // User is not logged in, show the login page
              return SplashScreen(child: LoginPage());
            }
          } else {
            // While checking the user's authentication status, display a loading screen
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
