import 'package:flutter/material.dart';
import 'app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Named Routes - Home'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Named Routes Concepts',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Named routes provide a cleaner way to handle navigation:',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text('• Define routes centrally in MaterialApp.routes'),
                    Text('• Use onGenerateRoute for dynamic routes with arguments'),
                    Text('• Navigate using Navigator.pushNamed()'),
                    Text('• Better organization and maintainability'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Basic named route navigation
                Navigator.pushNamed(context, '/details');
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Navigate to Details (Basic)'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                // Named route with arguments using helper method
                AppRoutes.navigateToDetails(
                  context,
                  itemId: 'item_123',
                  itemTitle: 'Sample Item',
                );
              },
              icon: const Icon(Icons.data_usage),
              label: const Text('Details with Arguments'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                // Named route with arguments using direct navigation
                Navigator.pushNamed(
                  context,
                  '/user-profile',
                  arguments: {
                    'userId': 'user_456',
                    'username': 'John Doe',
                  },
                );
              },
              icon: const Icon(Icons.person),
              label: const Text('User Profile with Arguments'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {
                // Replace current route with named route
                Navigator.pushReplacementNamed(context, '/profile');
              },
              icon: const Icon(Icons.swap_horiz),
              label: const Text('Replace with Profile'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 20),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Named Routes Benefits',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Advantages of using named routes:',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text('• Centralized route management'),
                    Text('• Type-safe route names'),
                    Text('• Easier to maintain and refactor'),
                    Text('• Better for deep linking'),
                    Text('• Cleaner navigation code'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Route Types',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Different ways to define routes:',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text('• Static routes in MaterialApp.routes'),
                    Text('• Dynamic routes in onGenerateRoute'),
                    Text('• Unknown routes in onUnknownRoute'),
                    Text('• Helper methods for complex navigation'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
