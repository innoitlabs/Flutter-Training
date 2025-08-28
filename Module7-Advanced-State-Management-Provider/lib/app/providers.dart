import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/catalog/catalog_model.dart';
import '../features/cart/cart_model.dart';
import '../features/settings/settings_model.dart';

/// MultiProvider configuration that wires all state models together
/// This creates a global state tree that can be accessed throughout the app
class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Settings model - manages app-wide preferences like theme
        ChangeNotifierProvider(
          create: (_) => SettingsModel(),
        ),
        
        // Catalog model - manages product catalog and async loading
        ChangeNotifierProvider(
          create: (_) => CatalogModel(),
        ),
        
        // Cart model - manages shopping cart state
        ChangeNotifierProvider(
          create: (_) => CartModel(),
        ),
      ],
      child: child,
    );
  }
}

/// Extension methods for easier provider access
extension ProviderExtensions on BuildContext {
  /// Get the settings model
  SettingsModel get settings => read<SettingsModel>();
  
  /// Watch the settings model for changes
  SettingsModel get watchSettings => watch<SettingsModel>();
  
  /// Get the catalog model
  CatalogModel get catalog => read<CatalogModel>();
  
  /// Watch the catalog model for changes
  CatalogModel get watchCatalog => watch<CatalogModel>();
  
  /// Get the cart model
  CartModel get cart => read<CartModel>();
  
  /// Watch the cart model for changes
  CartModel get watchCart => watch<CartModel>();
}
