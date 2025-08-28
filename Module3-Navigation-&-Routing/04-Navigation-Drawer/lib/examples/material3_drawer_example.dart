import 'package:flutter/material.dart';

class Material3DrawerExample extends StatelessWidget {
  const Material3DrawerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material3DrawerHomePage();
  }
}

class Material3DrawerHomePage extends StatefulWidget {
  const Material3DrawerHomePage({super.key});

  @override
  State<Material3DrawerHomePage> createState() => _Material3DrawerHomePageState();
}

class _Material3DrawerHomePageState extends State<Material3DrawerHomePage> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Navigation destinations for both drawer and rail
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
    NavigationDestination(
      icon: Icon(Icons.person_outline),
      selectedIcon: Icon(Icons.person),
      label: 'Profile',
    ),
    NavigationDestination(
      icon: Icon(Icons.settings_outlined),
      selectedIcon: Icon(Icons.settings),
      label: 'Settings',
    ),
    NavigationDestination(
      icon: Icon(Icons.info_outline),
      selectedIcon: Icon(Icons.info),
      label: 'About',
    ),
  ];

  // Pages to display based on selection
  static const List<Widget> _pages = [
    HomeContent(),
    SearchContent(),
    ProfileContent(),
    SettingsContent(),
    AboutContent(),
  ];

  @override
  Widget build(BuildContext context) {
    // Use LayoutBuilder to determine screen width for responsive design
    return LayoutBuilder(
      builder: (context, constraints) {
        // Switch to NavigationRail for wider screens (≥900px)
        if (constraints.maxWidth >= 900) {
          return _buildWideLayout();
        } else {
          return _buildNarrowLayout();
        }
      },
    );
  }

  Widget _buildWideLayout() {
    return Scaffold(
      key: _scaffoldKey,
      body: Row(
        children: [
          // NavigationRail for wide screens
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
            // Custom header for the rail
            leading: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const Text(
                      'JD',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'John Doe',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'john.doe@example.com',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            // Footer with app info
            trailing: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'M3 Drawer v1.0.0',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          // Vertical divider
          const VerticalDivider(thickness: 1, width: 1),
          // Main content area
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }

  Widget _buildNarrowLayout() {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_destinations[_selectedIndex].label),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Menu button to open the drawer
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(Icons.menu),
          tooltip: 'Open navigation drawer',
        ),
      ),
      // Material 3 NavigationDrawer for narrow screens
      drawer: NavigationDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          // Close the drawer after selection
          Navigator.pop(context);
        },
        children: [
          // Custom header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 28, 16, 16),
            child: Text(
              'Navigation',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          // Navigation destinations
          ..._destinations.map((destination) {
            return NavigationDrawerDestination(
              icon: destination.icon,
              selectedIcon: destination.selectedIcon,
              label: Text(destination.label),
            );
          }),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
            child: Divider(),
          ),
          // User info section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: const Text(
                    'JD',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'John Doe',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'john.doe@example.com',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }
}

// Content pages for each destination
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.home,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'Material 3 NavigationDrawer',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Resize the window to see adaptive behavior',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 16),
          Text(
            '• Drawer on narrow screens (≤900px)',
            style: TextStyle(fontSize: 14),
          ),
          Text(
            '• NavigationRail on wide screens (≥900px)',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class SearchContent extends StatelessWidget {
  const SearchContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Search',
              hintText: 'Enter your search query',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Search functionality would be implemented here'),
                ),
              );
            },
            icon: const Icon(Icons.search),
            label: const Text('Search'),
          ),
        ],
      ),
    );
  }
}

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            child: Icon(Icons.person, size: 50),
          ),
          SizedBox(height: 16),
          Text(
            'John Doe',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'john.doe@example.com',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 16),
          Text(
            'Software Developer',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Notifications'),
                subtitle: const Text('Manage notification preferences'),
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text('Dark Mode'),
                subtitle: const Text('Switch between light and dark themes'),
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                subtitle: const Text('English (US)'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.security),
                title: const Text('Privacy'),
                subtitle: const Text('Manage privacy settings'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.backup),
                title: const Text('Backup & Sync'),
                subtitle: const Text('Manage data backup and synchronization'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AboutContent extends StatelessWidget {
  const AboutContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About This App',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 24),
          Text(
            'This is a demonstration of Material 3 NavigationDrawer with adaptive NavigationRail for responsive design.',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          SizedBox(height: 24),
          Text(
            'Key Features:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text('• Material 3 NavigationDrawer for mobile/tablet'),
          Text('• NavigationRail for desktop/wide screens'),
          Text('• Responsive design with breakpoint at 900px'),
          Text('• Consistent navigation state across layouts'),
          Text('• Accessibility support with semantics'),
          Text('• Modern Material 3 theming'),
          SizedBox(height: 24),
          Text(
            'Technical Details:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text('• Uses LayoutBuilder for responsive breakpoints'),
          Text('• Shared navigation destinations'),
          Text('• State preservation across layout changes'),
          Text('• Null-safe Dart 3.6.1+ code'),
        ],
      ),
    );
  }
}
