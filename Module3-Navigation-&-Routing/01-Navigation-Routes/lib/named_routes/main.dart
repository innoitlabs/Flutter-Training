import 'package:flutter/material.dart';
import 'home_page.dart';
import 'details_page.dart';
import 'profile_page.dart';
import 'app_routes.dart';

void main() {
  runApp(const NamedRoutesApp());
}

class NamedRoutesApp extends StatelessWidget {
  const NamedRoutesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Routes',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      // Define static routes
      routes: {
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.details: (context) => const DetailsPage(),
        AppRoutes.profile: (context) => const ProfilePage(),
      },
      // Handle dynamic routes with arguments
      onGenerateRoute: (settings) {
        return AppRoutes.onGenerateRoute(settings);
      },
      // Handle unknown routes
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Page Not Found'),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            body: const Center(
              child: Text('The requested page was not found.'),
            ),
          ),
        );
      },
      initialRoute: AppRoutes.home,
    );
  }
}
