import 'package:flutter/material.dart';
import 'details_page.dart';
import 'profile_page.dart';

/// Centralized route definitions for the app
class AppRoutes {
  // Static route names
  static const String home = '/';
  static const String details = '/details';
  static const String profile = '/profile';
  static const String userProfile = '/user-profile';

  /// Generate routes dynamically for routes with arguments
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case userProfile:
        // Extract arguments from settings
        final args = settings.arguments as Map<String, dynamic>?;
        final userId = args?['userId'] as String? ?? 'Unknown';
        final username = args?['username'] as String? ?? 'Unknown User';
        
        return MaterialPageRoute(
          builder: (context) => ProfilePage(
            userId: userId,
            username: username,
          ),
        );
      
      case details:
        // Handle details route with optional arguments
        final args = settings.arguments as Map<String, dynamic>?;
        final itemId = args?['itemId'] as String?;
        final itemTitle = args?['itemTitle'] as String?;
        
        return MaterialPageRoute(
          builder: (context) => DetailsPage(
            itemId: itemId,
            itemTitle: itemTitle,
          ),
        );
      
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

  /// Helper method to navigate with arguments
  static void navigateToUserProfile(
    BuildContext context, {
    required String userId,
    required String username,
  }) {
    Navigator.pushNamed(
      context,
      userProfile,
      arguments: {
        'userId': userId,
        'username': username,
      },
    );
  }

  /// Helper method to navigate to details with arguments
  static void navigateToDetails(
    BuildContext context, {
    String? itemId,
    String? itemTitle,
  }) {
    Navigator.pushNamed(
      context,
      details,
      arguments: {
        'itemId': itemId,
        'itemTitle': itemTitle,
      },
    );
  }
}
