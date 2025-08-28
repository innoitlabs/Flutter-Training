import 'package:flutter/material.dart';

class TransitionsPage extends StatelessWidget {
  const TransitionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      'Custom Page Transitions',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Explore different custom page transition animations',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Transition buttons
            Expanded(
              child: Column(
                children: [
                  _buildTransitionButton(
                    context,
                    'Slide Transition',
                    Icons.swap_horiz,
                    Colors.blue,
                    () => _navigateWithSlideTransition(context),
                  ),
                  const SizedBox(height: 12),
                  _buildTransitionButton(
                    context,
                    'Scale Transition',
                    Icons.zoom_in,
                    Colors.green,
                    () => _navigateWithScaleTransition(context),
                  ),
                  const SizedBox(height: 12),
                  _buildTransitionButton(
                    context,
                    'Fade Transition',
                    Icons.opacity,
                    Colors.orange,
                    () => _navigateWithFadeTransition(context),
                  ),
                  const SizedBox(height: 12),
                  _buildTransitionButton(
                    context,
                    'Rotation Transition',
                    Icons.rotate_right,
                    Colors.purple,
                    () => _navigateWithRotationTransition(context),
                  ),
                  const SizedBox(height: 12),
                  _buildTransitionButton(
                    context,
                    'Combined Transition',
                    Icons.all_inclusive,
                    Colors.red,
                    () => _navigateWithCombinedTransition(context),
                  ),
                  const SizedBox(height: 12),
                  _buildTransitionButton(
                    context,
                    'Curved Transition',
                    Icons.waves,
                    Colors.teal,
                    () => _navigateWithCurvedTransition(context),
                  ),
                ],
              ),
            ),

            // Information card
            Card(
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Page Transition Tips',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Use PageRouteBuilder for custom transitions\n'
                      '• Combine multiple animations for rich effects\n'
                      '• Consider performance on lower-end devices\n'
                      '• Keep transitions under 300ms for responsiveness\n'
                      '• Test on different screen sizes and orientations',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }

  Widget _buildTransitionButton(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _navigateWithSlideTransition(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const _TransitionDemoPage(
            title: 'Slide Transition',
            color: Colors.blue,
            description: 'This page slides in from the right',
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  void _navigateWithScaleTransition(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const _TransitionDemoPage(
            title: 'Scale Transition',
            color: Colors.green,
            description: 'This page scales up from the center',
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  void _navigateWithFadeTransition(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const _TransitionDemoPage(
            title: 'Fade Transition',
            color: Colors.orange,
            description: 'This page fades in smoothly',
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _navigateWithRotationTransition(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const _TransitionDemoPage(
            title: 'Rotation Transition',
            color: Colors.purple,
            description: 'This page rotates in from the center',
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return RotationTransition(
            turns: animation,
            child: ScaleTransition(
              scale: animation,
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  void _navigateWithCombinedTransition(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const _TransitionDemoPage(
            title: 'Combined Transition',
            color: Colors.red,
            description: 'This page combines slide, scale, and fade',
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;

          var slideTween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(slideTween),
            child: ScaleTransition(
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _navigateWithCurvedTransition(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const _TransitionDemoPage(
            title: 'Curved Transition',
            color: Colors.teal,
            description: 'This page uses custom curves for smooth motion',
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.elasticOut;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }
}

class _TransitionDemoPage extends StatelessWidget {
  final String title;
  final Color color;
  final String description;

  const _TransitionDemoPage({
    required this.title,
    required this.color,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: color,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              color,
              color.withValues(alpha: 0.7),
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 24),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Go Back'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: color,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
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
