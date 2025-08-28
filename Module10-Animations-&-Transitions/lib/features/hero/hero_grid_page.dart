import 'package:flutter/material.dart';
import 'hero_detail_page.dart';

class HeroGridPage extends StatelessWidget {
  const HeroGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for the grid
    final items = [
      {'id': '1', 'title': 'Mountain View', 'color': Colors.green, 'icon': Icons.landscape},
      {'id': '2', 'title': 'Ocean Blue', 'color': Colors.blue, 'icon': Icons.water},
      {'id': '3', 'title': 'Sunset Orange', 'color': Colors.orange, 'icon': Icons.wb_sunny},
      {'id': '4', 'title': 'Purple Night', 'color': Colors.purple, 'icon': Icons.nightlight},
      {'id': '5', 'title': 'Forest Green', 'color': Colors.teal, 'icon': Icons.forest},
      {'id': '6', 'title': 'Rose Pink', 'color': Colors.pink, 'icon': Icons.local_florist},
    ];

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hero Animations',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tap any card to see the Hero transition to detail page',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Grid of items
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.0,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return _buildGridItem(context, item);
                },
              ),
            ),
          ],
        ),
      );
  }

  Widget _buildGridItem(BuildContext context, Map<String, dynamic> item) {
    return Hero(
      // Unique tag for Hero animation - must match detail page
      tag: 'hero_${item['id']}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigate to detail page with Hero animation
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return HeroDetailPage(item: item);
                },
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  // Custom transition that works well with Hero
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 300),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: item['color'],
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item['icon'],
                  size: 48,
                  color: Colors.white,
                ),
                const SizedBox(height: 8),
                Text(
                  item['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Tap to view',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
