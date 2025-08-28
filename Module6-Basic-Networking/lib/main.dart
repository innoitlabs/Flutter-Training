import 'package:flutter/material.dart';
import 'app/theme.dart';
import 'features/posts/posts_page.dart';

void main() {
  runApp(const MyApp());
}

/// Main app widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Networking Module',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Automatically use light/dark theme
      home: const PostsPage(),
    );
  }
}
