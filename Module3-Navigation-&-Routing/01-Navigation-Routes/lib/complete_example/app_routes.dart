import 'package:flutter/material.dart';
import 'item_details_page.dart';
import 'models/item.dart';

/// Centralized route definitions for the complete example app
class AppRoutes {
  // Static route names
  static const String home = '/';
  static const String itemDetails = '/item-details';
  static const String addItem = '/add-item';
  static const String settings = '/settings';
  static const String itemDetailsWithId = '/item-details-with-id';

  /// Generate routes dynamically for routes with arguments
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case itemDetailsWithId:
        // Extract arguments from settings
        final args = settings.arguments as Map<String, dynamic>?;
        final item = args?['item'] as Item?;
        
        if (item != null) {
          return MaterialPageRoute(
            builder: (context) => ItemDetailsPage(item: item),
          );
        } else {
          // Handle case where item is not provided
          return MaterialPageRoute(
            builder: (context) => const ItemDetailsPage(),
          );
        }
      
      default:
        // Return a default route for unknown routes
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Page Not Found'),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Route "${settings.name}" not found',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, home),
                    child: const Text('Go Home'),
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }

  /// Helper method to navigate to item details with an item
  static void navigateToItemDetails(
    BuildContext context,
    Item item,
  ) {
    Navigator.pushNamed(
      context,
      itemDetailsWithId,
      arguments: {'item': item},
    );
  }

  /// Helper method to navigate to add item and return the new item
  static Future<Item?> navigateToAddItem(BuildContext context) async {
    final result = await Navigator.pushNamed(context, addItem);
    return result as Item?;
  }

  /// Helper method to navigate to settings and return settings data
  static Future<Map<String, dynamic>?> navigateToSettings(BuildContext context) async {
    final result = await Navigator.pushNamed(context, settings);
    return result as Map<String, dynamic>?;
  }
}
