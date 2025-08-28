import 'package:flutter/material.dart';
import 'app/app.dart';
import 'app/providers.dart';

/// Main entry point for the ProviderShop app
/// Demonstrates MultiProvider setup and Material 3 theme
void main() {
  runApp(const ProviderShopApp());
}

/// Root app widget wrapped with MultiProvider
/// This provides all the state models to the entire app
class ProviderShopApp extends StatelessWidget {
  const ProviderShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: const ProviderShopAppWidget(),
    );
  }
}
