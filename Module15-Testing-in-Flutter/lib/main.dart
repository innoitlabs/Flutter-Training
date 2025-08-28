import 'package:flutter/material.dart';
import 'app/app.dart';
import 'app/theme.dart';

void main() {
  runApp(const TestLabApp());
}

class TestLabApp extends StatelessWidget {
  const TestLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TestLab',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const App(),
      debugShowCheckedModeBanner: false,
    );
  }
}
