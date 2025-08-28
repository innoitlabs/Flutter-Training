import 'package:flutter/material.dart';
import 'app/app.dart';

void main() {
  runApp(const UIPlaygroundApp());
}

/// Main application widget
/// Demonstrates Material 3 theming with custom theme extensions
class UIPlaygroundApp extends StatelessWidget {
  const UIPlaygroundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI Playground',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const HomePage(),
    );
  }
}
