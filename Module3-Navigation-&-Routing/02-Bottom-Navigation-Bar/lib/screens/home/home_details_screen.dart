import 'package:flutter/material.dart';

class HomeDetailsScreen extends StatelessWidget {
  const HomeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Details'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info, size: 64, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              'Home Details Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('This is a nested screen within the Home tab'),
            SizedBox(height: 16),
            Text(
              'Notice that the back button works correctly\nand preserves the Home tab state',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
