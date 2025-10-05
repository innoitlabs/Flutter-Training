import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show loading screen while checking auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        }
        
        // If user is logged in, show home screen
        if (snapshot.hasData && snapshot.data != null) {
          return HomeScreen();
        }
        
        // If user is not logged in, show login screen
        return LoginScreen();
      },
    );
  }
}
