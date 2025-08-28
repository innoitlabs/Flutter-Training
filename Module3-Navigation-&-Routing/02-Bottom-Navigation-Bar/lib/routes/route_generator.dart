import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/home/home_details_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/search/search_results_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/profile/profile_settings_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/home/details':
        return MaterialPageRoute(builder: (_) => const HomeDetailsScreen());
      case '/search':
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case '/search/results':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => SearchResultsScreen(query: args['query']),
        );
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case '/profile/settings':
        return MaterialPageRoute(builder: (_) => const ProfileSettingsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
