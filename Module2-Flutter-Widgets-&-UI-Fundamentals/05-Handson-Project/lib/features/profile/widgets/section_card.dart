import 'package:flutter/material.dart';

/// Reusable card widget for profile sections with consistent styling
class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.title,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.elevation,
  });

  final String title;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: elevation,
      margin: margin,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section title
            Text(
              title,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            // Section content
            child,
          ],
        ),
      ),
    );
  }
}
