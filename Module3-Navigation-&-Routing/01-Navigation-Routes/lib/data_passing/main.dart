import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const DataPassingApp());
}

class DataPassingApp extends StatelessWidget {
  const DataPassingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Passing',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const HomePage(),
    );
  }
}
