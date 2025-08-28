import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme/app_theme.dart';
import 'theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load saved theme preference
  final prefs = await SharedPreferences.getInstance();
  final themeModeIndex = prefs.getInt('themeMode') ?? 0;
  final themeMode = ThemeMode.values[themeModeIndex];
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(themeMode),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Flutter Styling & Theming Demo',
          
          // Theme Configuration
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          
          // App Configuration
          debugShowCheckedModeBanner: false,
          home: const TestScreen(),
        );
      },
    );
  }
}

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Styling & Theming Demo'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Theme System Working!',
              style: theme.textTheme.headlineLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Current Theme: ${theme.brightness == Brightness.dark ? 'Dark' : 'Light'}',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // This will be implemented when we fix the theme switcher
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Theme switching will be available soon!')),
                );
              },
              child: const Text('Test Theme Button'),
            ),
          ],
        ),
      ),
    );
  }
}
