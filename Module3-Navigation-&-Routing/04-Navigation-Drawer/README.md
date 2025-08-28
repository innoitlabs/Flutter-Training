# Flutter Navigation Drawer (Material 3) - Complete Learning Module

## 📚 Learning Objectives

By the end of this module, you will be able to:

1. **Understand when to use navigation drawers** vs other navigation patterns (bottom nav, tabs, rail)
2. **Implement classic modal drawers** using `Scaffold.drawer` with `ListTile` items
3. **Build named routes with selected state** highlighting for better UX
4. **Create Material 3 NavigationDrawer** with modern styling and adaptive NavigationRail
5. **Apply responsive design** principles with breakpoint-based layout switching
6. **Ensure accessibility** with proper semantics, focus management, and keyboard navigation

## 🎯 Concepts & Best Practices

### When to Use Navigation Drawers

Navigation drawers are ideal for:
- **Many destinations** (5+ navigation items)
- **Secondary/tertiary navigation** (settings, help, about)
- **Complex app hierarchies** with deep navigation structures
- **Desktop/tablet applications** where screen real estate allows for persistent navigation

**Avoid drawers for:**
- Primary navigation with 3-4 items (use bottom navigation instead)
- Single-purpose apps with minimal navigation
- Mobile-first apps where thumb reach is important

### Drawer Types & APIs

#### Classic Modal Drawer (`Scaffold.drawer`)
- **Pros:** Simple implementation, familiar pattern, good for mobile
- **Cons:** Takes up full screen, modal behavior, less modern styling
- **Use when:** Quick implementation, mobile-focused apps

#### Material 3 NavigationDrawer
- **Pros:** Modern styling, better accessibility, consistent with M3 design
- **Cons:** More complex setup, requires state management
- **Use when:** Modern apps, desktop support, better UX requirements

#### NavigationRail (for wide screens)
- **Pros:** Persistent navigation, better for desktop, more screen space
- **Cons:** Requires responsive design, more complex state management
- **Use when:** Desktop apps, wide screen layouts

## 🚀 Quick Start - Classic Drawer

The simplest way to add a navigation drawer:

```dart
Scaffold(
  appBar: AppBar(title: Text('My App')),
  drawer: Drawer(
    child: ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text('John Doe'),
          accountEmail: Text('john@example.com'),
          currentAccountPicture: CircleAvatar(child: Text('JD')),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            Navigator.pop(context); // Close drawer
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
          },
        ),
        // More ListTile items...
      ],
    ),
  ),
  body: Center(child: Text('Main Content')),
)
```

### Programmatic Control

```dart
// Using GlobalKey
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

Scaffold(
  key: _scaffoldKey,
  // ... other properties
)

// Open drawer programmatically
_scaffoldKey.currentState?.openDrawer();

// Using Scaffold.of(context)
Scaffold.of(context).openDrawer();
```

## 🛣️ Named Routes & Selected State

### Centralized Route Management

```dart
MaterialApp(
  routes: {
    '/': (context) => HomePage(),
    '/home': (context) => HomePage(),
    '/search': (context) => SearchPage(),
    '/profile': (context) => ProfilePage(),
    '/settings': (context) => SettingsPage(),
  },
  onUnknownRoute: (settings) {
    return MaterialPageRoute(builder: (context) => NotFoundPage());
  },
)
```

### Selected State Highlighting

```dart
// Get current route
final String currentRoute = ModalRoute.of(context)?.settings.name ?? '/';

ListTile(
  leading: Icon(
    Icons.home,
    color: currentRoute == '/home' 
        ? Theme.of(context).colorScheme.primary 
        : Theme.of(context).colorScheme.onSurfaceVariant,
  ),
  title: Text(
    'Home',
    style: TextStyle(
      fontWeight: currentRoute == '/home' ? FontWeight.bold : FontWeight.normal,
      color: currentRoute == '/home' 
          ? Theme.of(context).colorScheme.primary 
          : Theme.of(context).colorScheme.onSurface,
    ),
  ),
  selected: currentRoute == '/home',
  selectedTileColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
  onTap: () {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/home');
  },
)
```

## 🎨 Material 3 NavigationDrawer

### Modern Implementation

```dart
NavigationDrawer(
  selectedIndex: _selectedIndex,
  onDestinationSelected: (int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  },
  children: [
    Padding(
      padding: EdgeInsets.fromLTRB(16, 28, 16, 16),
      child: Text('Navigation', style: Theme.of(context).textTheme.titleSmall),
    ),
    NavigationDrawerDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: Text('Home'),
    ),
    // More destinations...
  ],
)
```

### Navigation Destinations

```dart
static const List<NavigationDestination> _destinations = [
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
  // More destinations...
];
```

## 📱 Responsive Design - Drawer ↔ Rail Adaptation

### Breakpoint-Based Layout

```dart
LayoutBuilder(
  builder: (context, constraints) {
    // Switch to NavigationRail for wider screens (≥900px)
    if (constraints.maxWidth >= 900) {
      return _buildWideLayout();
    } else {
      return _buildNarrowLayout();
    }
  },
)
```

### NavigationRail for Wide Screens

```dart
NavigationRail(
  extended: true, // Show labels when extended
  minExtendedWidth: 200,
  selectedIndex: _selectedIndex,
  onDestinationSelected: (int index) {
    setState(() {
      _selectedIndex = index;
    });
  },
  destinations: _destinations.map((destination) {
    return NavigationRailDestination(
      icon: destination.icon,
      selectedIcon: destination.selectedIcon,
      label: Text(destination.label),
    );
  }).toList(),
  // Custom header and footer...
)
```

## 🎛️ Programmatic Control & UX Details

### Opening/Closing Drawers

```dart
// Open drawer
Scaffold.of(context).openDrawer();
// or
_scaffoldKey.currentState?.openDrawer();

// Close drawer
Navigator.pop(context);

// Check if drawer is open
Scaffold.of(context).isDrawerOpen
```

### Custom Headers

```dart
// Classic Drawer Header
UserAccountsDrawerHeader(
  accountName: Text('John Doe'),
  accountEmail: Text('john.doe@example.com'),
  currentAccountPicture: CircleAvatar(child: Text('JD')),
  decoration: BoxDecoration(
    color: Theme.of(context).colorScheme.primary,
  ),
)

// Custom M3 Header
Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Theme.of(context).colorScheme.primary,
  ),
  child: Column(
    children: [
      CircleAvatar(radius: 32, child: Text('JD')),
      Text('John Doe', style: TextStyle(color: Colors.white)),
      Text('john.doe@example.com', style: TextStyle(color: Colors.white70)),
    ],
  ),
)
```

## 🎨 Styling & Theming (Material 3)

### ColorScheme Integration

```dart
ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.light,
  ),
  // Custom drawer themes
  drawerTheme: DrawerThemeData(
    backgroundColor: ColorScheme.fromSeed(seedColor: Colors.blue).surface,
    elevation: 1,
  ),
  navigationDrawerTheme: NavigationDrawerThemeData(
    backgroundColor: ColorScheme.fromSeed(seedColor: Colors.blue).surface,
    elevation: 1,
    indicatorColor: ColorScheme.fromSeed(seedColor: Colors.blue).primaryContainer,
  ),
)
```

### Dark Mode Support

```dart
MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
  ),
  darkTheme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
  ),
)
```

## 🧪 Testing Tips

### Widget Testing

```dart
testWidgets('Drawer opens on menu button tap', (WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
  
  // Tap menu button
  await tester.tap(find.byIcon(Icons.menu));
  await tester.pumpAndSettle();
  
  // Verify drawer is open
  expect(find.byType(Drawer), findsOneWidget);
});

testWidgets('Selecting drawer item navigates correctly', (WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
  
  // Open drawer
  await tester.tap(find.byIcon(Icons.menu));
  await tester.pumpAndSettle();
  
  // Tap navigation item
  await tester.tap(find.text('Settings'));
  await tester.pumpAndSettle();
  
  // Verify navigation occurred
  expect(find.text('Settings Page'), findsOneWidget);
});

testWidgets('Selected state highlights correctly', (WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
  
  // Navigate to settings
  await tester.tap(find.byIcon(Icons.menu));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Settings'));
  await tester.pumpAndSettle();
  
  // Open drawer again and check selection
  await tester.tap(find.byIcon(Icons.menu));
  await tester.pumpAndSettle();
  
  // Verify settings item is highlighted
  final settingsTile = find.text('Settings');
  expect(tester.widget<ListTile>(settingsTile).selected, isTrue);
});
```

## 🏋️ Exercises

### Easy: Add an End Drawer

Create a settings drawer that opens from the right side:

```dart
Scaffold(
  endDrawer: Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          child: Text('Settings'),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          trailing: Switch(value: true, onChanged: (value) {}),
        ),
        // More settings...
      ],
    ),
  ),
  appBar: AppBar(
    actions: [
      IconButton(
        onPressed: () => Scaffold.of(context).openEndDrawer(),
        icon: Icon(Icons.settings),
      ),
    ],
  ),
)
```

### Intermediate: Convert to NavigationDrawer

Convert the classic drawer to use Material 3 NavigationDrawer:

```dart
NavigationDrawer(
  selectedIndex: _selectedIndex,
  onDestinationSelected: (int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  },
  children: [
    // Header
    Padding(
      padding: EdgeInsets.fromLTRB(16, 28, 16, 16),
      child: Text('Navigation'),
    ),
    // Destinations
    NavigationDrawerDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: Text('Home'),
    ),
    // More destinations...
  ],
)
```

### Advanced: Adaptive Layout with Deep Links

Implement a responsive layout that preserves navigation state and supports deep links:

```dart
class AdaptiveNavigationApp extends StatefulWidget {
  @override
  _AdaptiveNavigationAppState createState() => _AdaptiveNavigationAppState();
}

class _AdaptiveNavigationAppState extends State<AdaptiveNavigationApp> {
  int _selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        // Handle deep links and preserve selection
        switch (settings.name) {
          case '/':
            _selectedIndex = 0;
            return MaterialPageRoute(builder: (_) => HomePage());
          case '/search':
            _selectedIndex = 1;
            return MaterialPageRoute(builder: (_) => SearchPage());
          // More routes...
        }
      },
      home: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.maxWidth >= 900
              ? _buildWideLayout()
              : _buildNarrowLayout();
        },
      ),
    );
  }
  
  // Implement wide and narrow layouts with preserved state
}
```

## 📋 Summary

### Key Takeaways

1. **Choose the right navigation pattern** based on your app's needs and target devices
2. **Use named routes** for better organization and deep linking support
3. **Implement selected state** to provide clear visual feedback
4. **Apply responsive design** with breakpoint-based layout switching
5. **Ensure accessibility** with proper semantics and keyboard navigation
6. **Follow Material 3 guidelines** for modern, consistent styling

### Best Practices

- **Keep widget trees shallow** by extracting drawer items and headers
- **Centralize route definitions** for easier maintenance
- **Use typed arguments** when passing data between routes
- **Handle back button behavior** correctly with `WillPopScope`
- **Test on multiple screen sizes** to ensure responsive behavior
- **Add proper semantics** for screen readers and accessibility tools

### When to Use Each Pattern

| Pattern | Use Case | Pros | Cons |
|---------|----------|------|------|
| Classic Drawer | Simple mobile apps | Easy to implement | Less modern styling |
| Named Routes | Complex navigation | Better organization | More setup required |
| M3 NavigationDrawer | Modern apps | Best UX, accessibility | More complex |
| Adaptive Rail | Desktop apps | Persistent navigation | Requires responsive design |

## 🚀 Getting Started

1. **Clone or download** this project
2. **Run `flutter pub get`** to install dependencies
3. **Execute `flutter run`** to launch the app
4. **Explore each example** by tapping the cards on the home screen
5. **Resize the window** in the Material 3 example to see adaptive behavior

## 📖 Additional Resources

- [Flutter Navigation Documentation](https://docs.flutter.dev/ui/navigation)
- [Material 3 Design Guidelines](https://m3.material.io/)
- [Flutter Widget Catalog](https://docs.flutter.dev/ui/widgets)
- [Accessibility in Flutter](https://docs.flutter.dev/ui/accessibility)

---

**Happy coding! 🎉**

This tutorial demonstrates modern Flutter navigation patterns with Material 3 design principles. All code is null-safe and compatible with Dart 3.6.1+ and the latest stable Flutter SDK.
