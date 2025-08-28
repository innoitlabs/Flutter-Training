import 'package:flutter/material.dart';
import '../../features/counter/counter_page.dart';
import '../../features/todos/ui/todos_page.dart';
import '../../features/auth/login_page.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    CounterPage(),
    TodosPage(),
    LoginPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: 'Counter',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_outlined),
            selectedIcon: Icon(Icons.list),
            label: 'Todos',
          ),
          NavigationDestination(
            icon: Icon(Icons.login_outlined),
            selectedIcon: Icon(Icons.login),
            label: 'Login',
          ),
        ],
      ),
    );
  }
}

