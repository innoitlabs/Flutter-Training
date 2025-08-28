import 'package:flutter/material.dart';
import 'theme.dart';
import '../features/settings/settings_page.dart';
import '../features/tasks/ui/tasks_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;
  bool _isDarkMode = false;

  // List of pages for navigation
  final List<Widget> _pages = [
    const TasksPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LocalBox',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.task_alt),
              label: 'Tasks',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  // Method to update theme (called from settings)
  void updateTheme(bool isDarkMode) {
    setState(() {
      _isDarkMode = isDarkMode;
    });
  }
}
