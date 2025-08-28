# Navigation Exercises

## Exercise 1: Basic Navigation (Easy)

**Objective**: Add a button to navigate from Home → Details using basic navigation.

**Task**: 
1. Open the basic navigation example
2. Add a new button in the HomePage that navigates to a new screen called "AboutPage"
3. Create the AboutPage with some content about Flutter navigation
4. Use `Navigator.push()` with `MaterialPageRoute`

**Expected Outcome**: 
- New button in HomePage
- AboutPage with content
- Proper navigation between screens

**Code Hints**:
```dart
// In HomePage, add this button:
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutPage()),
    );
  },
  child: const Text('Go to About'),
),

// Create AboutPage:
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: const Center(
        child: Text('This is the About page!'),
      ),
    );
  }
}
```

---

## Exercise 2: Named Routes with Data (Intermediate)

**Objective**: Pass a username to a Profile screen and display it using named routes.

**Task**:
1. Open the named routes example
2. Add a new route called "/profile" that accepts a username parameter
3. Create a ProfilePage that displays the passed username
4. Add a button in HomePage that navigates to the profile with a username
5. Use `Navigator.pushNamed()` with arguments

**Expected Outcome**:
- New route definition in AppRoutes
- ProfilePage that displays the username
- Navigation with data passing

**Code Hints**:
```dart
// In AppRoutes, add:
static const String profile = '/profile';

// In onGenerateRoute:
case profile:
  final args = settings.arguments as Map<String, dynamic>?;
  final username = args?['username'] as String? ?? 'Unknown';
  return MaterialPageRoute(
    builder: (context) => ProfilePage(username: username),
  );

// In HomePage, add:
ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(
      context,
      '/profile',
      arguments: {'username': 'John Doe'},
    );
  },
  child: const Text('View Profile'),
),
```

---

## Exercise 3: Form with Data Return (Advanced)

**Objective**: Build a form screen that returns entered data to the Home screen.

**Task**:
1. Open the data passing example
2. Create a new "ContactFormPage" with fields for name, email, and message
3. Add form validation
4. Return the form data to the previous screen when submitted
5. Display the returned data in the HomePage

**Expected Outcome**:
- ContactFormPage with form fields
- Form validation
- Data return to HomePage
- Display of returned data

**Code Hints**:
```dart
// ContactFormPage structure:
class ContactFormPage extends StatefulWidget {
  const ContactFormPage({super.key});

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Form')),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Please enter your name';
                return null;
              },
            ),
            // Add email and message fields...
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final data = {
                    'name': _nameController.text,
                    'email': _emailController.text,
                    'message': _messageController.text,
                  };
                  Navigator.pop(context, data);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Exercise 4: Complete App Enhancement (Advanced)

**Objective**: Enhance the complete example app with new features.

**Task**:
1. Open the complete example app
2. Add a search functionality to filter items
3. Add a "Categories" page that groups items by category
4. Implement a "Favorites" page that shows only favorite items
5. Add navigation between these new pages

**Expected Outcome**:
- Search functionality
- Categories page
- Favorites page
- Proper navigation between all pages

**Code Hints**:
```dart
// Add to Item model:
final String category;

// Add search functionality in HomePage:
TextField(
  decoration: const InputDecoration(
    labelText: 'Search items...',
    prefixIcon: Icon(Icons.search),
  ),
  onChanged: (query) {
    setState(() {
      _filteredItems = _items.where((item) =>
        item.title.toLowerCase().contains(query.toLowerCase()) ||
        item.description.toLowerCase().contains(query.toLowerCase())
      ).toList();
    });
  },
),

// Create CategoriesPage:
class CategoriesPage extends StatelessWidget {
  final List<Item> items;
  
  const CategoriesPage({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final categories = items.map((item) => item.category).toSet().toList();
    
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final categoryItems = items.where((item) => item.category == category).toList();
          
          return ListTile(
            title: Text(category),
            subtitle: Text('${categoryItems.length} items'),
            onTap: () {
              // Navigate to category details
            },
          );
        },
      ),
    );
  }
}
```

---

## Exercise 5: Navigation Patterns (Advanced)

**Objective**: Implement different navigation patterns and understand when to use each.

**Task**:
1. Create a "Tab Navigation" example with bottom navigation
2. Implement "Drawer Navigation" with a side menu
3. Create a "Nested Navigation" example with nested routes
4. Add "Deep Linking" support for specific routes

**Expected Outcome**:
- Multiple navigation patterns
- Understanding of when to use each pattern
- Proper implementation of complex navigation

**Code Hints**:
```dart
// Tab Navigation:
class TabNavigationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home), text: 'Home'),
                Tab(icon: Icon(Icons.favorite), text: 'Favorites'),
                Tab(icon: Icon(Icons.settings), text: 'Settings'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              HomePage(),
              FavoritesPage(),
              SettingsPage(),
            ],
          ),
        ),
      ),
    );
  }
}

// Drawer Navigation:
class DrawerNavigationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Drawer Navigation')),
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Navigation Menu'),
              ),
              ListTile(
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/');
                },
              ),
              ListTile(
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ],
          ),
        ),
        body: const HomePage(),
      ),
    );
  }
}
```

---

## Submission Guidelines

1. **Code Quality**: Ensure your code follows Flutter best practices
2. **Null Safety**: All code must be null-safe and compatible with Dart 3.6.1
3. **Documentation**: Add comments explaining your implementation
4. **Testing**: Test all navigation flows thoroughly
5. **UI/UX**: Ensure the UI is clean and user-friendly

## Learning Objectives

After completing these exercises, you should be able to:
- Implement basic navigation with Navigator.push/pop
- Use named routes effectively
- Pass data between screens
- Handle form data and validation
- Implement complex navigation patterns
- Apply best practices for navigation architecture

## Resources

- [Flutter Navigation Documentation](https://docs.flutter.dev/development/ui/navigation)
- [Material Design Navigation Guidelines](https://material.io/design/navigation/understanding-navigation.html)
- [Flutter Cookbook - Navigation](https://docs.flutter.dev/cookbook/navigation)
