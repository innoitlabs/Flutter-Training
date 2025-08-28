import 'package:flutter/material.dart';

class StatePreservationExample extends StatefulWidget {
  const StatePreservationExample({super.key});

  @override
  State<StatePreservationExample> createState() => _StatePreservationExampleState();
}

class _StatePreservationExampleState extends State<StatePreservationExample> {
  int _selectedIndex = 0;

  // Screens with PageStorageKey for state preservation
  static const List<Widget> _screens = [
    _HomeScreenWithState(),
    _SearchScreenWithState(),
    _ProfileScreenWithState(),
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
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _HomeScreenWithState extends StatefulWidget {
  const _HomeScreenWithState();

  @override
  State<_HomeScreenWithState> createState() => _HomeScreenWithStateState();
}

class _HomeScreenWithStateState extends State<_HomeScreenWithState> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home (State Preserved)'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        key: const PageStorageKey('home_screen'),
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            key: const PageStorageKey('home_text_field'),
            controller: _textController,
            decoration: const InputDecoration(
              labelText: 'Enter text (state will be preserved)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Scroll down and switch tabs. When you return, your scroll position and text will be preserved.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 32),
          // Add content to demonstrate scroll preservation
          ...List.generate(50, (index) => ListTile(
            title: Text('Item ${index + 1}'),
            subtitle: Text('This is item number ${index + 1}'),
            leading: CircleAvatar(child: Text('${index + 1}')),
          )),
        ],
      ),
    );
  }
}

class _SearchScreenWithState extends StatefulWidget {
  const _SearchScreenWithState();

  @override
  State<_SearchScreenWithState> createState() => _SearchScreenWithStateState();
}

class _SearchScreenWithStateState extends State<_SearchScreenWithState> {
  final TextEditingController _searchController = TextEditingController();
  String _lastSearchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search (State Preserved)'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              key: const PageStorageKey('search_text_field'),
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search query (state will be preserved)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _lastSearchQuery = _searchController.text;
                });
              },
              child: const Text('Search'),
            ),
            const SizedBox(height: 16),
            if (_lastSearchQuery.isNotEmpty)
              Text('Last search: $_lastSearchQuery'),
            const SizedBox(height: 16),
            const Text(
              'Enter a search query and switch tabs. When you return, your query will be preserved.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileScreenWithState extends StatefulWidget {
  const _ProfileScreenWithState();

  @override
  State<_ProfileScreenWithState> createState() => _ProfileScreenWithStateState();
}

class _ProfileScreenWithStateState extends State<_ProfileScreenWithState> {
  bool _isDarkMode = false;
  double _sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile (State Preserved)'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Dark Mode'),
              subtitle: const Text('Toggle dark/light theme'),
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text('Volume Level'),
            Slider(
              key: const PageStorageKey('profile_slider'),
              value: _sliderValue,
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
            Text('Value: ${_sliderValue.toStringAsFixed(2)}'),
            const SizedBox(height: 16),
            const Text(
              'Adjust the switch and slider, then switch tabs. When you return, your settings will be preserved.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
