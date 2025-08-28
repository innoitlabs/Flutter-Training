import 'package:flutter/material.dart';
import 'app_routes.dart';
import 'models/item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Item> _items = [
    Item(
      id: '1',
      title: 'Flutter Navigation',
      description: 'Learn how to navigate between screens in Flutter apps',
      createdAt: DateTime(2024, 1, 15),
    ),
    Item(
      id: '2',
      title: 'Material Design',
      description: 'Beautiful and consistent design system for mobile apps',
      createdAt: DateTime(2024, 1, 10),
      isFavorite: true,
    ),
    Item(
      id: '3',
      title: 'State Management',
      description: 'Manage app state efficiently with various patterns',
      createdAt: DateTime(2024, 1, 5),
    ),
    Item(
      id: '4',
      title: 'API Integration',
      description: 'Connect your Flutter app to backend services',
      createdAt: DateTime(2024, 1, 1),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Navigation Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () async {
              final settings = await AppRoutes.navigateToSettings(context);
              if (settings != null) {
                _showSnackBar('Settings updated: ${settings['theme']}');
              }
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Complete Navigation Example',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'This app demonstrates all navigation concepts:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    const Text('• Named routes with centralized management'),
                    const Text('• Data passing with custom objects'),
                    const Text('• Form handling and data return'),
                    const Text('• Complex navigation patterns'),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text(
                        item.title[0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      item.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.description),
                        const SizedBox(height: 4),
                        Text(
                          'Created: ${_formatDate(item.createdAt)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (item.isFavorite)
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 20,
                          ),
                        const Icon(Icons.arrow_forward_ios, size: 16),
                      ],
                    ),
                    onTap: () {
                      AppRoutes.navigateToItemDetails(context, item);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newItem = await AppRoutes.navigateToAddItem(context);
          if (newItem != null) {
            setState(() {
              _items.insert(0, newItem);
            });
            _showSnackBar('Added: ${newItem.title}');
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
