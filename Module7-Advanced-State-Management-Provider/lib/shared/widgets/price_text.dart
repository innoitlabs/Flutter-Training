import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Reusable price text widget that uses Selector for performance optimization
/// Only rebuilds when the price changes, not when other state changes
class PriceText extends StatelessWidget {
  final double price;
  final TextStyle? style;
  final bool showCurrency;

  const PriceText({
    super.key,
    required this.price,
    this.style,
    this.showCurrency = true,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatPrice(price),
      style: style ?? Theme.of(context).textTheme.bodyLarge,
    );
  }

  String _formatPrice(double price) {
    if (showCurrency) {
      return '\$${price.toStringAsFixed(2)}';
    }
    return price.toStringAsFixed(2);
  }
}

/// Selector widget that only rebuilds when the price changes
/// This is a performance optimization - only the price text rebuilds
class SelectorPriceText extends StatelessWidget {
  final double price;
  final TextStyle? style;
  final bool showCurrency;

  const SelectorPriceText({
    super.key,
    required this.price,
    this.style,
    this.showCurrency = true,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<double, double>(
      // Only rebuild when the price value changes
      selector: (context, price) => price,
      builder: (context, price, child) {
        return PriceText(
          price: price,
          style: style,
          showCurrency: showCurrency,
        );
      },
    );
  }
}
