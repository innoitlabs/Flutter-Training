import 'package:flutter/material.dart';
import 'theme.dart';
import '../features/implicit/implicit_page.dart';
import '../features/explicit/explicit_page.dart';
import '../features/hero/hero_grid_page.dart';
import '../features/custom/custom_page.dart';
import '../features/routes/transitions_page.dart';

class AnimLabApp extends StatefulWidget {
  const AnimLabApp({super.key});

  @override
  State<AnimLabApp> createState() => _AnimLabAppState();
}

class _AnimLabAppState extends State<AnimLabApp> {
  int _currentIndex = 0;

  // List of pages to demonstrate different animation types
  final List<Widget> _pages = [
    const ImplicitPage(),
    const ExplicitPage(),
    const HeroGridPage(),
    const CustomPage(),
    const TransitionsPage(),
  ];

  final List<String> _pageTitles = [
    'Implicit',
    'Explicit',
    'Hero',
    'Custom',
    'Transitions',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnimLab - Flutter Animations',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: _HomePage(
        currentIndex: _currentIndex,
        pages: _pages,
        pageTitles: _pageTitles,
        onIndexChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  final int currentIndex;
  final List<Widget> pages;
  final List<String> pageTitles;
  final ValueChanged<int> onIndexChanged;

  const _HomePage({
    required this.currentIndex,
    required this.pages,
    required this.pageTitles,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimLab: ${pageTitles[currentIndex]}'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onIndexChanged,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.auto_awesome),
            label: 'Implicit',
          ),
          NavigationDestination(
            icon: Icon(Icons.tune),
            label: 'Explicit',
          ),
          NavigationDestination(
            icon: Icon(Icons.flight),
            label: 'Hero',
          ),
          NavigationDestination(
            icon: Icon(Icons.brush),
            label: 'Custom',
          ),
          NavigationDestination(
            icon: Icon(Icons.swap_horiz),
            label: 'Transitions',
          ),
        ],
      ),
    );
  }
}
