import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cart_model.dart';

/// Cart badge widget that demonstrates Selector usage
/// Only rebuilds when the cart item count changes, not when other cart state changes
class CartBadge extends StatelessWidget {
  const CartBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<CartModel, int>(
      // Only rebuild when itemCount changes - performance optimization
      selector: (context, cart) => cart.itemCount,
      builder: (context, itemCount, child) {
        return Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                // Navigate to cart page
                // Note: This would typically be handled by the parent widget
              },
            ),
            if (itemCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.error,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    itemCount.toString(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onError,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// Alternative implementation using context.select
/// This achieves the same result as Selector but with less boilerplate
class CartBadgeWithContextSelect extends StatelessWidget {
  const CartBadgeWithContextSelect({super.key});

  @override
  Widget build(BuildContext context) {
    // Use context.select for fine-grained rebuilds
    final itemCount = context.select<CartModel, int>((cart) => cart.itemCount);
    
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            // Navigate to cart page
          },
        ),
        if (itemCount > 0)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                itemCount.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onError,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
