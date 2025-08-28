import 'package:flutter/material.dart';
import 'widget_comparison_screen.dart';
import 'counter_screen.dart';
import 'toggle_screen.dart';
import 'form_validation_screen.dart';
import 'profile_form_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter State Management Learning'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Learning Objectives:',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '• Understand Stateful vs Stateless widgets\n'
              '• Learn state lifecycle (initState, build, dispose)\n'
              '• Implement setState for UI updates\n'
              '• Handle user interactions\n'
              '• Manage form state with validation',
            ),
            const SizedBox(height: 32),
            Text(
              'Examples:',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildExampleCard(
                    context,
                    '1. Widget Comparison',
                    'StatelessWidget vs StatefulWidget demo',
                    Icons.compare_arrows,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WidgetComparisonScreen(),
                      ),
                    ),
                  ),
                  _buildExampleCard(
                    context,
                    '2. Counter App',
                    'Basic setState implementation',
                    Icons.add_circle_outline,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CounterScreen(),
                      ),
                    ),
                  ),
                  _buildExampleCard(
                    context,
                    '3. Toggle Visibility',
                    'Button interactions with setState',
                    Icons.visibility,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ToggleScreen(),
                      ),
                    ),
                  ),
                  _buildExampleCard(
                    context,
                    '4. Form Validation',
                    'Basic form validation with setState',
                    Icons.verified,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FormValidationScreen(),
                      ),
                    ),
                  ),
                  _buildExampleCard(
                    context,
                    '5. Profile Form Project',
                    'Complete interactive form with validation',
                    Icons.person_add,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileFormScreen(),
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
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
