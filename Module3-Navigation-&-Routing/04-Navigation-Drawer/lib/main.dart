import 'package:flutter/material.dart';
import 'examples/classic_drawer_example.dart';
import 'examples/named_routes_example.dart';
import 'examples/material3_drawer_example.dart';

void main() {
  runApp(const NavigationDrawerTutorialApp());
}

class NavigationDrawerTutorialApp extends StatelessWidget {
  const NavigationDrawerTutorialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Drawer Tutorial',
      debugShowCheckedModeBanner: false,
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
      home: const TutorialHomePage(),
    );
  }
}

class TutorialHomePage extends StatelessWidget {
  const TutorialHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Drawer Tutorial'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flutter Navigation Drawer (Material 3)',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Choose an example to explore:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  _buildExampleCard(
                    context,
                    'Classic Drawer (Modal)',
                    'Basic Scaffold.drawer with ListTile items and simple navigation',
                    Icons.menu,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ClassicDrawerExample(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildExampleCard(
                    context,
                    'Named Routes + Selected State',
                    'Centralized routes with highlighted active destination',
                    Icons.route,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NamedRoutesExample(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildExampleCard(
                    context,
                    'Material 3 NavigationDrawer + Adaptive Rail',
                    'Modern M3 drawer with responsive rail adaptation',
                    Icons.railway_alert,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Material3DrawerExample(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
