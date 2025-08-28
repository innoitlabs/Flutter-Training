import 'package:flutter/material.dart';
import 'home_page.dart';
import 'app_routes.dart';
import 'item_details_page.dart';
import 'add_item_page.dart';
import 'settings_page.dart';

void main() {
  runApp(const CompleteExampleApp());
}

class CompleteExampleApp extends StatelessWidget {
  const CompleteExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complete Navigation Example',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      // Define static routes
      routes: {
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.itemDetails: (context) => const ItemDetailsPage(),
        AppRoutes.addItem: (context) => const AddItemPage(),
        AppRoutes.settings: (context) => const SettingsPage(),
      },
      // Handle dynamic routes with arguments
      onGenerateRoute: (settings) {
        return AppRoutes.onGenerateRoute(settings);
      },
      initialRoute: AppRoutes.home,
    );
  }
}
