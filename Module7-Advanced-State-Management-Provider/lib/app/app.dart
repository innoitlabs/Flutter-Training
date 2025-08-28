import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import '../features/catalog/catalog_page.dart';
import '../features/cart/cart_page.dart';
import '../features/settings/settings_page.dart';
import '../features/cart/widgets/cart_badge.dart';
import '../features/settings/settings_model.dart';

/// Main app widget that handles theme switching and navigation
class ProviderShopAppWidget extends StatelessWidget {
  const ProviderShopAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsModel>(
      // Watch settings for theme changes - rebuilds when isDarkMode changes
      builder: (context, settings, child) {
        return MaterialApp(
          title: 'Provider Shop',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const MainNavigationPage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

/// Main navigation page with bottom navigation
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  static const List<Widget> _pages = [
    CatalogPage(),
    CartPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.shopping_bag),
            label: 'Catalog',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

/// App bar widget that shows cart badge
class ShopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const ShopAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        // Cart badge that only rebuilds when cart count changes
        const CartBadge(),
        if (actions != null) ...actions!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
