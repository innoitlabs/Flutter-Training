import 'package:flutter/material.dart';
import 'basic_navigation/main.dart' as basic_nav;
import 'named_routes/main.dart' as named_routes;
import 'data_passing/main.dart' as data_passing;
import 'complete_example/main.dart' as complete_example;

void main() {
  runApp(const NavigationModuleApp());
}

class NavigationModuleApp extends StatelessWidget {
  const NavigationModuleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Module',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ModuleSelectorPage(),
    );
  }
}

class ModuleSelectorPage extends StatelessWidget {
  const ModuleSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Navigation Module'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select a Navigation Example:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildModuleCard(
                    context,
                    'Basic Navigation',
                    'Learn fundamental Navigator.push and Navigator.pop',
                    Icons.navigation,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const basic_nav.BasicNavigationApp(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildModuleCard(
                    context,
                    'Named Routes',
                    'Use named routes for cleaner navigation',
                    Icons.route,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const named_routes.NamedRoutesApp(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildModuleCard(
                    context,
                    'Data Passing',
                    'Pass data between screens and return results',
                    Icons.data_usage,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const data_passing.DataPassingApp(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildModuleCard(
                    context,
                    'Complete Example',
                    'Full-featured app demonstrating all concepts',
                    Icons.apps,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const complete_example.CompleteExampleApp(),
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

  Widget _buildModuleCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
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
