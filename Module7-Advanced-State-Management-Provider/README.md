# Advanced State Management with Provider (Dart 3.6.1)

## Learning Objectives
- Implement the Provider pattern with ChangeNotifier
- Manage global app state across multiple screens
- Handle complex state (derived/computed values, async loads, error states)
- Optimize rebuilds using Selector, context.select, and granular widgets

## Key Concepts & Architecture

### Why Provider?
Provider is a simple, testable, and composable state management solution that follows the InheritedWidget pattern. It provides:
- **Simplicity**: Easy to understand and implement
- **Testability**: Business logic can be unit tested independently
- **Composability**: Multiple providers can be combined and scoped

### App Architecture Layers
1. **Models** (ChangeNotifier): Business logic and state
2. **Providers**: Dependency injection and state distribution
3. **Widgets**: UI components that consume state

### Provider Methods
- **context.watch<T>()**: Rebuilds widget when state changes
- **context.read<T>()**: One-time access, no rebuilds
- **context.select<T, R>()**: Rebuilds only when specific part changes

### When to Use Each
- **Consumer**: When you need to rebuild based on multiple providers
- **Selector**: For fine-grained rebuilds on specific state changes
- **MultiProvider**: For composing multiple providers at app level

## Project Structure
```
lib/
  main.dart
  app/app.dart
  app/theme.dart
  app/providers.dart
  features/catalog/
    catalog_model.dart
    catalog_page.dart
  features/cart/
    cart_model.dart
    cart_page.dart
    widgets/cart_badge.dart
  features/settings/
    settings_model.dart
    settings_page.dart
  shared/
    models/product.dart
    widgets/price_text.dart
    utils/result.dart
test/
  unit/cart_model_test.dart
  widget/cart_badge_test.dart
```

## Setup Instructions

### 1. Project Setup
```bash
# Install dependencies
flutter pub get

# Run tests to verify everything works
flutter test
```

### 2. Run on iOS Simulator
```bash
# Launch simulator (if not already running)
open -a Simulator

# Check available devices
flutter devices

# Run the app on iOS simulator
flutter run -d ios
```

### 3. Verify Behavior
Once the app is running, you should be able to:

**Catalog Page:**
- See a loading indicator while products load
- View a list of products with images, names, descriptions, and prices
- Add products to cart using "Add to Cart" buttons
- See snackbar feedback when items are added
- Experience random loading errors (10% chance) with retry functionality

**Cart Page:**
- View cart items with quantities
- Increase/decrease quantities using +/- buttons
- See real-time total price updates (using Selector for performance)
- Checkout with simulated processing
- See success/error feedback after checkout

**Settings Page:**
- Toggle dark mode (affects entire app theme)
- Toggle notifications setting
- Change language preference
- Reset all settings to defaults

**Global State:**
- Cart badge in app bar updates instantly when items are added/removed
- Theme changes apply immediately across all screens
- State persists across navigation

## Code Examples

### Basic Provider Usage (Settings)
```dart
// Watch for UI updates
Consumer<SettingsModel>(
  builder: (context, settings, child) {
    return SwitchListTile(
      value: settings.isDarkMode,
      onChanged: (value) {
        // Use read for actions - no rebuild needed
        context.read<SettingsModel>().setDarkMode(value);
      },
    );
  },
)
```

### Selector for Performance (Cart Badge)
```dart
// Only rebuild when itemCount changes
Selector<CartModel, int>(
  selector: (context, cart) => cart.itemCount,
  builder: (context, itemCount, child) {
    return Text(itemCount.toString());
  },
)
```

### Async State Management (Catalog)
```dart
// Handle loading, error, and success states
Consumer<CatalogModel>(
  builder: (context, catalog, child) {
    if (catalog.isLoading) {
      return CircularProgressIndicator();
    }
    
    if (catalog.hasError) {
      return ErrorWidget(
        message: catalog.errorMessage,
        onRetry: () => context.read<CatalogModel>().retry(),
      );
    }
    
    return ProductList(products: catalog.products);
  },
)
```

## Best Practices

### State Management
- Use Provider for global/feature state; keep models small and focused
- Use `read` for actions; `watch` for visuals; `select`/`Selector` for fine-grained rebuilds
- Keep business logic in models, not widgets
- Handle loading/error states explicitly

### Performance Optimization
- Minimize rebuilds with Selector / context.select
- Keep Consumers near the leaf widgets
- Separate business logic from UI
- Use immutable data where possible

### Testing
- Write unit tests for critical state logic
- Test widget rebuilds with widget tests
- Mock providers for isolated testing

## Exercises

### Easy
Add a favorites provider; use Selector to rebuild only favorite icons.

### Intermediate
Add a checkout async flow (loading + success/error states).

### Advanced
Scope a route-specific provider (e.g., promo code state) that's created/disposed with the page.

## Troubleshooting

### Common Issues
1. **Import errors**: Make sure all model files are properly imported
2. **Provider not found**: Check that MultiProvider is set up correctly in main.dart
3. **Performance issues**: Use Selector instead of Consumer for fine-grained updates
4. **State not updating**: Ensure notifyListeners() is called after state changes

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/unit/cart_model_test.dart

# Run with coverage
flutter test --coverage
```

## Dependencies
- **provider**: ^6.1.1 - State management
- **flutter**: >=3.16.0 - UI framework
- **dart**: >=3.6.1 - Programming language

## Features Demonstrated
- ✅ MultiProvider setup with global state
- ✅ ChangeNotifier with proper state management
- ✅ Consumer, Selector, and context.select usage
- ✅ Async state handling with loading/error states
- ✅ Derived state (cart total, item count)
- ✅ Performance optimization with Selector
- ✅ Material 3 theming with dark mode support
- ✅ Unit and widget tests
- ✅ Null safety throughout
- ✅ Immutable data models
- ✅ Proper error handling with Result type
