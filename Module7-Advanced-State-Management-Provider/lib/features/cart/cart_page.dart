import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/app.dart';
import '../../shared/widgets/price_text.dart';
import '../../shared/models/product.dart';
import 'cart_model.dart';

/// Cart page demonstrating derived state and Selector usage
/// Shows how to optimize rebuilds with Selector for specific state parts
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ShopAppBar(title: 'Shopping Cart'),
      body: Consumer<CartModel>(
        // Watch cart for UI updates - rebuilds when cart state changes
        builder: (context, cart, child) {
          if (cart.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add some products from the catalog',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Cart Items List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return CartItemCard(item: item);
                  },
                ),
              ),
              
              // Cart Summary and Checkout
              CartSummary(),
            ],
          );
        },
      ),
    );
  }
}

/// Cart item card widget
class CartItemCard extends StatelessWidget {
  final CartItem item;

  const CartItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.product.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, color: Colors.grey),
                  );
                },
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  PriceText(
                    price: item.product.price,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Quantity Controls
            Column(
              children: [
                // Quantity Display
                Selector<CartModel, int>(
                  // Only rebuild when this specific item's quantity changes
                  selector: (context, cart) => cart.getQuantity(item.product.id),
                  builder: (context, quantity, child) {
                    return Text(
                      'Qty: $quantity',
                      style: Theme.of(context).textTheme.bodySmall,
                    );
                  },
                ),
                
                const SizedBox(height: 8),
                
                // Quantity Buttons
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, size: 16),
                      onPressed: () {
                        // Use context.read() for actions - no rebuild needed
                        context.read<CartModel>().removeItem(item.product.id);
                      },
                                              style: IconButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                          minimumSize: const Size(32, 32),
                        ),
                    ),
                    
                    const SizedBox(width: 8),
                    
                    IconButton(
                      icon: const Icon(Icons.add, size: 16),
                      onPressed: () {
                        context.read<CartModel>().addItem(item.product);
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        minimumSize: const Size(32, 32),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Cart summary widget with checkout functionality
class CartSummary extends StatefulWidget {
  const CartSummary({super.key});

  @override
  State<CartSummary> createState() => _CartSummaryState();
}

class _CartSummaryState extends State<CartSummary> {
  bool _isCheckingOut = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Total Price - uses Selector for performance
          Selector<CartModel, double>(
            // Only rebuild when total price changes
            selector: (context, cart) => cart.totalPrice,
            builder: (context, totalPrice, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  PriceText(
                    price: totalPrice,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            },
          ),
          
          const SizedBox(height: 16),
          
          // Checkout Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isCheckingOut ? null : _checkout,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isCheckingOut
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: 8),
                        Text('Processing...'),
                      ],
                    )
                  : const Text('Checkout'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _checkout() async {
    setState(() {
      _isCheckingOut = true;
    });

    try {
      final result = await context.read<CartModel>().checkout();
      
      if (mounted) {
        result.fold(
          onSuccess: (orderId) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Order placed successfully! Order ID: $orderId'),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            );
          },
          onError: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Checkout failed: $error'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          },
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCheckingOut = false;
        });
      }
    }
  }
}
