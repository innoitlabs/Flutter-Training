import 'package:flutter/foundation.dart';
import '../../shared/models/product.dart';
import '../../shared/utils/result.dart';

/// Cart model that manages shopping cart state
/// Demonstrates derived state and immutable updates
class CartModel extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  /// Get all cart items as a list
  List<CartItem> get items => _items.values.toList();

  /// Get the total number of items in cart
  int get itemCount => _items.values.fold(0, (sum, item) => sum + item.quantity);

  /// Get the total price of all items (derived state)
  double get totalPrice => _items.values.fold(0.0, (sum, item) => sum + item.totalPrice);

  /// Check if cart is empty
  bool get isEmpty => _items.isEmpty;

  /// Check if cart has items
  bool get isNotEmpty => _items.isNotEmpty;

  /// Get quantity of a specific product
  int getQuantity(String productId) {
    return _items[productId]?.quantity ?? 0;
  }

  /// Add a product to cart
  /// Uses immutable update pattern - creates new state then notifies
  void addItem(Product product) {
    final existingItem = _items[product.id];
    
    if (existingItem != null) {
      // Update existing item with new quantity
      _items[product.id] = existingItem.copyWith(
        quantity: existingItem.quantity + 1,
      );
    } else {
      // Add new item
      _items[product.id] = CartItem(
        product: product,
        quantity: 1,
      );
    }
    
    notifyListeners(); // Notify widgets to rebuild
  }

  /// Remove a product from cart
  void removeItem(String productId) {
    final existingItem = _items[productId];
    
    if (existingItem != null) {
      if (existingItem.quantity > 1) {
        // Decrease quantity
        _items[productId] = existingItem.copyWith(
          quantity: existingItem.quantity - 1,
        );
      } else {
        // Remove item completely
        _items.remove(productId);
      }
      
      notifyListeners();
    }
  }

  /// Set quantity for a product
  void setQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      _items.remove(productId);
    } else {
      final existingItem = _items[productId];
      if (existingItem != null) {
        _items[productId] = existingItem.copyWith(quantity: quantity);
      }
    }
    
    notifyListeners();
  }

  /// Clear all items from cart
  void clear() {
    _items.clear();
    notifyListeners();
  }

  /// Checkout process (simulated)
  Future<Result<String>> checkout() async {
    if (isEmpty) {
      return const Result.error('Cart is empty');
    }

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulate success
      final orderId = 'ORDER-${DateTime.now().millisecondsSinceEpoch}';
      clear(); // Clear cart after successful checkout
      
      return Result.success(orderId);
    } catch (e) {
      return Result.error('Checkout failed: $e');
    }
  }
}
