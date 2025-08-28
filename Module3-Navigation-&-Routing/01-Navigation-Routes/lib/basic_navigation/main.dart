import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const BasicNavigationApp());
}

class BasicNavigationApp extends StatelessWidget {
  const BasicNavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Navigation',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const HomePage(),
    );
  }
}
