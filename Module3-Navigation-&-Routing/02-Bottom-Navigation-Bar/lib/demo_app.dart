import 'package:flutter/material.dart';
import 'main.dart';
import 'advanced_main.dart';
import 'examples/legacy_bottom_navigation.dart';
import 'examples/responsive_navigation.dart';
import 'examples/state_preservation_example.dart';

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bottom Navigation Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const DemoHomePage(),
    );
  }
}

class DemoHomePage extends StatelessWidget {
  const DemoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Bottom Navigation Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Flutter Bottom Navigation (Material 3) Examples',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          _buildExampleCard(
            context,
            'Basic NavigationBar with IndexedStack',
            'Simple implementation using NavigationBar and IndexedStack for state management.',
            Icons.home,
            Colors.blue,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavigationExample()),
            ),
          ),
          const SizedBox(height: 16),
          _buildExampleCard(
            context,
            'Advanced NavigationBar with Nested Navigators',
            'Complex implementation with nested navigators for each tab, preserving navigation stacks.',
            Icons.navigation,
            Colors.green,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdvancedApp()),
            ),
          ),
          const SizedBox(height: 16),
          _buildExampleCard(
            context,
            'State Preservation with PageStorageKey',
            'Demonstrates how to preserve scroll positions and form data across tab switches.',
            Icons.save,
            Colors.orange,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StatePreservationExample()),
            ),
          ),
          const SizedBox(height: 16),
          _buildExampleCard(
            context,
            'Responsive Navigation (Bar ↔ Rail)',
            'Automatically switches between NavigationBar and NavigationRail based on screen size.',
            Icons.screen_rotation,
            Colors.purple,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ResponsiveNavigationExample()),
            ),
          ),
          const SizedBox(height: 16),
          _buildExampleCard(
            context,
            'Legacy BottomNavigationBar',
            'Reference implementation using the legacy BottomNavigationBar (not Material 3).',
            Icons.history,
            Colors.grey,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LegacyBottomNavigationExample()),
            ),
          ),
          const SizedBox(height: 32),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Key Features Demonstrated:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('• Material 3 NavigationBar vs Legacy BottomNavigationBar'),
                  Text('• IndexedStack vs Nested Navigators for state management'),
                  Text('• Back button handling with WillPopScope'),
                  Text('• Badge implementation for notifications'),
                  Text('• State preservation using PageStorageKey'),
                  Text('• Responsive design with NavigationRail'),
                  Text('• Proper theming with ColorScheme.fromSeed'),
                  Text('• Accessibility features and best practices'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
