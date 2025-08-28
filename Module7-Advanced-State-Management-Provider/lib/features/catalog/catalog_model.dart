import 'package:flutter/foundation.dart';
import '../../shared/models/product.dart';
import '../../shared/utils/result.dart';

/// Catalog model that manages product catalog with async loading
/// Demonstrates proper error handling and loading states
class CatalogModel extends ChangeNotifier {
  Result<List<Product>> _productsResult = const Result.success([]);
  bool _isLoading = false;

  /// Get current products result
  Result<List<Product>> get productsResult => _productsResult;

  /// Get products list (null if error)
  List<Product>? get products => _productsResult.data;

  /// Check if currently loading
  bool get isLoading => _isLoading;

  /// Check if has error
  bool get hasError => _productsResult.isError;

  /// Get error message
  String? get errorMessage => _productsResult.errorMessage;

  /// Load products from mock API
  /// Demonstrates async state management with loading and error states
  Future<void> loadProducts() async {
    if (_isLoading) return; // Prevent multiple simultaneous loads

    _isLoading = true;
    notifyListeners(); // Notify to show loading state

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Simulate random error (10% chance)
      if (DateTime.now().millisecond % 10 == 0) {
        throw Exception('Network error occurred');
      }

      // Mock product data
      final mockProducts = [
        const Product(
          id: '1',
          name: 'Flutter T-Shirt',
          description: 'Comfortable cotton t-shirt with Flutter logo',
          price: 29.99,
          imageUrl: 'https://via.placeholder.com/150',
          category: 'Clothing',
        ),
        const Product(
          id: '2',
          name: 'Dart Mug',
          description: 'Ceramic mug perfect for your morning coffee',
          price: 14.99,
          imageUrl: 'https://via.placeholder.com/150',
          category: 'Kitchen',
        ),
        const Product(
          id: '3',
          name: 'Provider Book',
          description: 'Complete guide to state management with Provider',
          price: 39.99,
          imageUrl: 'https://via.placeholder.com/150',
          category: 'Books',
        ),
        const Product(
          id: '4',
          name: 'Material Design Poster',
          description: 'Beautiful poster showcasing Material Design principles',
          price: 19.99,
          imageUrl: 'https://via.placeholder.com/150',
          category: 'Home',
        ),
        const Product(
          id: '5',
          name: 'Flutter Stickers',
          description: 'Set of 10 high-quality Flutter stickers',
          price: 9.99,
          imageUrl: 'https://via.placeholder.com/150',
          category: 'Accessories',
        ),
        const Product(
          id: '6',
          name: 'Dart Keychain',
          description: 'Durable keychain with Dart logo',
          price: 7.99,
          imageUrl: 'https://via.placeholder.com/150',
          category: 'Accessories',
        ),
      ];

      _productsResult = Result.success(mockProducts);
    } catch (e) {
      _productsResult = Result.error('Failed to load products: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify to update UI
    }
  }

  /// Retry loading products
  Future<void> retry() async {
    await loadProducts();
  }

  /// Get products by category
  List<Product> getProductsByCategory(String category) {
    return products?.where((product) => product.category == category).toList() ?? [];
  }

  /// Search products by name
  List<Product> searchProducts(String query) {
    if (query.isEmpty) return products ?? [];
    
    return products?.where((product) => 
      product.name.toLowerCase().contains(query.toLowerCase()) ||
      product.description.toLowerCase().contains(query.toLowerCase())
    ).toList() ?? [];
  }

  /// Get unique categories
  List<String> get categories {
    final categories = products?.map((p) => p.category).toSet() ?? {};
    return categories.toList()..sort();
  }
}
