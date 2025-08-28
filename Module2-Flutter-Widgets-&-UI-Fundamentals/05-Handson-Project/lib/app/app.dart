import 'package:flutter/material.dart';
import 'theme.dart';
import '../features/profile/profile_page.dart';
import '../models/profile.dart';

/// Main app widget with Material 3 configuration
class MyProfileApp extends StatelessWidget {
  const MyProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Profile App',
      debugShowCheckedModeBanner: false,
      
      // Material 3 theme configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Follows system theme
      
      // Error handling
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: MediaQuery.of(context).textScaler.clamp(
              minScaleFactor: 0.8,
              maxScaleFactor: 1.4,
            ),
          ),
          child: child!,
        );
      },
      
      // Routes
      home: ProfilePage(profile: Profile.sample()),
      
      // Error widget for better debugging
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
      },
    );
  }
}
