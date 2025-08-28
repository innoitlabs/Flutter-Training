import 'package:flutter/material.dart';
import 'examples/basic_tabs_example.dart';
import 'examples/manual_tabs_example.dart';
import 'examples/nested_scroll_tabs_example.dart';

void main() {
  runApp(const TabNavigationLearningApp());
}

class TabNavigationLearningApp extends StatelessWidget {
  const TabNavigationLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tab Navigation Examples',
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
      home: const ExampleSelectorScreen(),
    );
  }
}

class ExampleSelectorScreen extends StatelessWidget {
  const ExampleSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Tab Navigation Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select an example to run:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildExampleCard(
              context,
              'Basic Tabs Example',
              'DefaultTabController with 3 tabs, icons, and Material 3 theming',
              Icons.tab,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BasicTabsExample(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildExampleCard(
              context,
              'Manual TabController Example',
              'Custom TabController with state preservation and lifecycle management',
              Icons.settings,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManualTabsExample(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildExampleCard(
              context,
              'Nested Scroll Tabs Example',
              'NestedScrollView with SliverAppBar and collapsing header',
              Icons.view_column,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NestedScrollTabsExample(),
                ),
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
                size: 32,
                color: Theme.of(context).colorScheme.primary,
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
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
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
