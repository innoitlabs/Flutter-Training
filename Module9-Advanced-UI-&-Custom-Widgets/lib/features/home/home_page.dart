import 'package:flutter/material.dart';
import '../profile/profile_card.dart';
import '../layout/sliver_demo_page.dart';
import '../theme/theme_controller.dart';
import '../painter/progress_painter.dart';
import '../../app/theme.dart';

/// Main home page with navigation to all UI playground features
/// Demonstrates basic layout and navigation patterns
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final brandColors = Theme.of(context).extension<BrandColors>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Playground'),
        backgroundColor: brandColors?.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Advanced UI & Custom Widgets',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: brandColors?.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Module 9 - Dart 3.6.1',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: brandColors?.secondary,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _FeatureCard(
                    title: 'Custom Widgets',
                    subtitle: 'ProfileCard Demo',
                    icon: Icons.person,
                    color: brandColors?.primary ?? Colors.purple,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileCardDemo(),
                      ),
                    ),
                  ),
                  _FeatureCard(
                    title: 'Advanced Layout',
                    subtitle: 'SliverAppBar Demo',
                    icon: Icons.view_column,
                    color: brandColors?.secondary ?? Colors.blue,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SliverDemoPage(),
                      ),
                    ),
                  ),
                  _FeatureCard(
                    title: 'InheritedWidget',
                    subtitle: 'Theme Controller',
                    icon: Icons.palette,
                    color: brandColors?.accent ?? Colors.orange,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ThemeControllerDemo(),
                      ),
                    ),
                  ),
                  _FeatureCard(
                    title: 'CustomPainter',
                    subtitle: 'Progress Ring',
                    icon: Icons.brush,
                    color: brandColors?.primary ?? Colors.green,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProgressPainterDemo(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Reusable feature card widget
/// Demonstrates widget composition and reusability
class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: color,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
