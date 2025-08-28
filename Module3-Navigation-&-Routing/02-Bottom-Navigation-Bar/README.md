# Flutter Bottom Navigation (Material 3) — Step by Step

## Learning Objectives

By the end of this module, you will be able to:

1. **Understand Navigation Patterns**: Know when to use bottom navigation vs other navigation patterns
2. **Implement Material 3 Navigation**: Build bottom navigation using NavigationBar and NavigationDestination
3. **Manage State Effectively**: Preserve screen state across tabs using IndexedStack or nested Navigators
4. **Handle Navigation Properly**: Integrate with named routes and manage back button behavior
5. **Create Accessible UI**: Add badges, theming, and ensure responsiveness across devices

## Concepts & Best Practices

### When to Use Bottom Navigation

- **Bottom Navigation**: For 3-5 primary destinations that users access frequently
- **Tabs**: For related content within the same context
- **Navigation Rail**: For larger screens (tablets, desktop)
- **Drawer**: For secondary navigation or settings

### Material 3 Component Choice

- **NavigationBar**: Modern Material 3 component (preferred)
- **NavigationDestination**: Individual destination items
- **Legacy BottomNavigationBar**: Still works but not Material 3 compliant

### State Management Strategies

1. **Simple Apps**: `currentIndex + IndexedStack`
   - Easy to implement
   - All screens stay in memory
   - Good for small apps

2. **Intermediate Apps**: Nested Navigators (one per tab)
   - Preserves navigation stacks per tab
   - Better memory management
   - More complex but more flexible

3. **Lightweight Persistence**: PageStorageKey
   - Preserves scroll positions and form data
   - Automatic state restoration

### Back Button Behavior

- **Android**: System back button should navigate within the current tab first
- **iOS**: Swipe gestures work naturally with nested navigators
- **Cross-tab**: Back button should not switch tabs

## Quick Start Example (Basic NavigationBar)

This example demonstrates the simplest implementation using NavigationBar with IndexedStack.

```dart
// main.dart - Basic NavigationBar Example
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const BottomNavigationExample(),
    );
  }
}

class BottomNavigationExample extends StatefulWidget {
  const BottomNavigationExample({super.key});

  @override
  State<BottomNavigationExample> createState() => _BottomNavigationExampleState();
}

class _BottomNavigationExampleState extends State<BottomNavigationExample> {
  int _selectedIndex = 0;

  // Simple placeholder screens
  static const List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    ProfileScreen(),
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

// Placeholder screen widgets
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 64, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              'Home Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('This is the home tab content'),
          ],
        ),
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: Colors.green),
            SizedBox(height: 16),
            Text(
              'Search Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('This is the search tab content'),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 64, color: Colors.orange),
            SizedBox(height: 16),
            Text(
              'Profile Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('This is the profile tab content'),
          ],
        ),
      ),
    );
  }
}
```

## Intermediate Example (Nested Navigators)

This example shows how to implement nested navigators for each tab, preserving navigation stacks and handling back button behavior properly.

### Project Structure

```
lib/
├── main.dart
├── screens/
│   ├── home/
│   │   ├── home_screen.dart
│   │   └── home_details_screen.dart
│   ├── search/
│   │   ├── search_screen.dart
│   │   └── search_results_screen.dart
│   └── profile/
│       ├── profile_screen.dart
│       └── profile_settings_screen.dart
├── widgets/
│   └── bottom_navigation_wrapper.dart
└── routes/
    └── route_generator.dart
```

### Main App with Nested Navigators

```dart
// main.dart - Advanced NavigationBar with Nested Navigators
import 'package:flutter/material.dart';
import 'widgets/bottom_navigation_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Bottom Navigation Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        navigationBarTheme: NavigationBarThemeData(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      home: const BottomNavigationWrapper(),
    );
  }
}
```

### Bottom Navigation Wrapper

```dart
// widgets/bottom_navigation_wrapper.dart
import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/profile/profile_screen.dart';

class BottomNavigationWrapper extends StatefulWidget {
  const BottomNavigationWrapper({super.key});

  @override
  State<BottomNavigationWrapper> createState() => _BottomNavigationWrapperState();
}

class _BottomNavigationWrapperState extends State<BottomNavigationWrapper> {
  int _selectedIndex = 0;
  
  // Global keys for each navigator to preserve state
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  // Notification count for badge demonstration
  int _notificationCount = 3;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Check if the current navigator can pop
        final NavigatorState? navigator = _navigatorKeys[_selectedIndex].currentState;
        if (navigator != null && navigator.canPop()) {
          navigator.pop();
          return false; // Don't exit the app
        }
        return true; // Exit the app
      },
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            Navigator(
              key: _navigatorKeys[0],
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => const HomeScreen(),
                settings: settings,
              ),
            ),
            Navigator(
              key: _navigatorKeys[1],
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => const SearchScreen(),
                settings: settings,
              ),
            ),
            Navigator(
              key: _navigatorKeys[2],
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
                settings: settings,
              ),
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            const NavigationDestination(
              icon: Icon(Icons.search_outlined),
              selectedIcon: Icon(Icons.search),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Badge(
                label: Text(_notificationCount.toString()),
                child: const Icon(Icons.person_outline),
              ),
              selectedIcon: Badge(
                label: Text(_notificationCount.toString()),
                child: const Icon(Icons.person),
              ),
              label: 'Profile',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _notificationCount++;
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
```

### Home Tab with Nested Navigation

```dart
// screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'home_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        children: [
          const Icon(Icons.home, size: 64, color: Colors.blue),
          const SizedBox(height: 16),
          const Text(
            'Home Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _textController,
            decoration: const InputDecoration(
              labelText: 'Enter some text (state will be preserved)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HomeDetailsScreen(),
                ),
              );
            },
            child: const Text('Go to Details'),
          ),
          const SizedBox(height: 32),
          // Add some content to demonstrate scroll position preservation
          ...List.generate(20, (index) => ListTile(
            title: Text('Item ${index + 1}'),
            subtitle: Text('This is item number ${index + 1}'),
            leading: CircleAvatar(child: Text('${index + 1}')),
          )),
        ],
      ),
    );
  }
}
```

```dart
// screens/home/home_details_screen.dart
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
```

### Search Tab with Nested Navigation

```dart
// screens/search/search_screen.dart
import 'package:flutter/material.dart';
import 'search_results_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search, size: 64, color: Colors.green),
            const SizedBox(height: 16),
            const Text(
              'Search Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search query',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_searchController.text.isNotEmpty) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SearchResultsScreen(
                        query: _searchController.text,
                      ),
                    ),
                  );
                }
              },
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
```

```dart
// screens/search/search_results_screen.dart
import 'package:flutter/material.dart';

class SearchResultsScreen extends StatelessWidget {
  final String query;

  const SearchResultsScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results for "$query"'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('Result ${index + 1} for "$query"'),
              subtitle: Text('This is a search result item'),
              leading: CircleAvatar(child: Text('${index + 1}')),
            ),
          );
        },
      ),
    );
  }
}
```

### Profile Tab with Settings

```dart
// screens/profile/profile_screen.dart
import 'package:flutter/material.dart';
import 'profile_settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfileSettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.orange,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('john.doe@example.com'),
            const SizedBox(height: 32),
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
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfileSettingsScreen(),
                  ),
                );
              },
              child: const Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
```

```dart
// screens/profile/profile_settings_screen.dart
import 'package:flutter/material.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            subtitle: const Text('Manage notification preferences'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Handle notifications settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Privacy'),
            subtitle: const Text('Privacy and security settings'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Handle privacy settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & Support'),
            subtitle: const Text('Get help and contact support'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Handle help and support
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            subtitle: const Text('App version and information'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Handle about
            },
          ),
        ],
      ),
    );
  }
}
```

## Named Routes & RouteGenerator

For more complex apps, you can centralize route management:

```dart
// routes/route_generator.dart
import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/home/home_details_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/search/search_results_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/profile/profile_settings_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/home/details':
        return MaterialPageRoute(builder: (_) => const HomeDetailsScreen());
      case '/search':
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case '/search/results':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => SearchResultsScreen(query: args['query']),
        );
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case '/profile/settings':
        return MaterialPageRoute(builder: (_) => const ProfileSettingsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
```

## Styling & Theming (Material 3)

### Custom Theme Configuration

```dart
// Example of custom NavigationBar theming
NavigationBar(
  selectedIndex: _selectedIndex,
  onDestinationSelected: _onItemTapped,
  backgroundColor: Theme.of(context).colorScheme.surface,
  elevation: 8,
  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
  destinations: const [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Home',
    ),
    // ... other destinations
  ],
)
```

### Light/Dark Theme Toggle

```dart
// Add this to your main app for theme switching
class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
```

## Accessibility & Responsiveness

### Adding Semantics and Tooltips

```dart
NavigationDestination(
  icon: Tooltip(
    message: 'Navigate to home screen',
    child: const Icon(Icons.home_outlined),
  ),
  selectedIcon: Tooltip(
    message: 'You are on the home screen',
    child: const Icon(Icons.home),
  ),
  label: 'Home',
)
```

### Safe Areas and Responsive Design

```dart
// Wrap your Scaffold body with SafeArea
body: SafeArea(
  child: IndexedStack(
    index: _selectedIndex,
    children: _screens,
  ),
),

// For larger screens, consider NavigationRail
@override
Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  
  if (screenWidth > 600) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: Text('Home'),
              ),
              // ... other destinations
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: _screens[_selectedIndex]),
        ],
      ),
    );
  }
  
  // Return regular bottom navigation for smaller screens
  return Scaffold(
    body: _screens[_selectedIndex],
    bottomNavigationBar: NavigationBar(
      // ... navigation bar configuration
    ),
  );
}
```

## Testing Tips

### Widget Tests

```dart
// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/main.dart';

void main() {
  group('Bottom Navigation Tests', () {
    testWidgets('Default selected index is 0', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      
      // Verify home tab is selected by default
      expect(find.text('Home Screen'), findsOneWidget);
      expect(find.text('Search Screen'), findsNothing);
    });

    testWidgets('Tapping destination updates content', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      
      // Tap on search tab
      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();
      
      // Verify search screen is shown
      expect(find.text('Search Screen'), findsOneWidget);
      expect(find.text('Home Screen'), findsNothing);
    });

    testWidgets('Nested navigation works within tabs', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      
      // Navigate to home details
      await tester.tap(find.text('Go to Details'));
      await tester.pumpAndSettle();
      
      // Verify details screen is shown
      expect(find.text('Home Details Screen'), findsOneWidget);
      
      // Go back
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      
      // Verify we're back to home screen
      expect(find.text('Home Screen'), findsOneWidget);
    });
  });
}
```

## Exercises

### Easy Exercise: Add a 4th Tab
Add a "Settings" tab to the bottom navigation and create a basic settings screen.

### Intermediate Exercise: Add Details Screen
Implement a "Details" screen within the Home tab using the nested navigator pattern.

### Advanced Exercise: Badge Count and State Preservation
1. Show a badge count on the Profile tab that updates from app state
2. Preserve scroll positions per tab using PageStorageKey
3. Implement a global state management solution (Provider/Riverpod)

## Legacy BottomNavigationBar (Reference)

```dart
// Legacy approach - prefer NavigationBar for Material 3
BottomNavigationBar(
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
)
```

## Summary

### Key Takeaways

- **NavigationBar vs BottomNavigationBar**: Use NavigationBar for Material 3 apps
- **IndexedStack vs Nested Navigator**: 
  - IndexedStack: Simple apps, all screens in memory
  - Nested Navigator: Complex apps, preserves navigation stacks
- **State Preservation**: Use PageStorageKey for lightweight persistence
- **Back Button Handling**: Implement WillPopScope for proper navigation
- **Theming**: Use ColorScheme.fromSeed and NavigationBarThemeData
- **Accessibility**: Add Semantics labels and Tooltips
- **Responsiveness**: Consider NavigationRail for larger screens

### Best Practices

1. Always use Material 3 components when possible
2. Implement proper back button handling with nested navigators
3. Preserve state appropriately for your app's complexity
4. Test on different screen sizes and orientations
5. Add accessibility features for better user experience
6. Use const constructors and null safety throughout

This module provides a solid foundation for implementing bottom navigation in Flutter applications using Material 3 design principles.
