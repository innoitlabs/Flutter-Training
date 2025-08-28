import 'package:flutter/material.dart';

// Legacy BottomNavigationBar example - prefer NavigationBar for Material 3
class LegacyBottomNavigationExample extends StatefulWidget {
  const LegacyBottomNavigationExample({super.key});

  @override
  State<LegacyBottomNavigationExample> createState() => _LegacyBottomNavigationExampleState();
}

class _LegacyBottomNavigationExampleState extends State<LegacyBottomNavigationExample> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    Center(child: Text('Home Screen')),
    Center(child: Text('Search Screen')),
    Center(child: Text('Profile Screen')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
