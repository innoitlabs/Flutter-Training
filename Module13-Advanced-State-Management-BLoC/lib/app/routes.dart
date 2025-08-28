import 'package:flutter/material.dart';
import '../features/counter/counter_page.dart';
import '../features/todos/ui/todos_page.dart';
import '../features/feed/ui/feed_page.dart';

/// App routes configuration
class AppRoutes {
  static const String counter = '/counter';
  static const String todos = '/todos';
  static const String feed = '/feed';
  
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case counter:
        return MaterialPageRoute(
          builder: (_) => const CounterPage(),
        );
      case todos:
        return MaterialPageRoute(
          builder: (_) => const TodosPage(),
        );
      case feed:
        return MaterialPageRoute(
          builder: (_) => const FeedPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Route not found'),
            ),
          ),
        );
    }
  }
}
