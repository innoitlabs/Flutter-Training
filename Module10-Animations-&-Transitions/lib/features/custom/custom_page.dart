import 'package:flutter/material.dart';
import '../../shared/painters/progress_ring_painter.dart';

class CustomPage extends StatefulWidget {
  const CustomPage({super.key});

  @override
  State<CustomPage> createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage>
    with TickerProviderStateMixin {
  // Animation controllers
  late AnimationController _progressController;
  late AnimationController _staggeredController;

  // Progress ring animations
  late Animation<double> _progressAnimation;
  late Animation<Color?> _colorAnimation;

  // Staggered animations
  late Animation<double> _fadeAnimation1;
  late Animation<double> _fadeAnimation2;
  late Animation<double> _fadeAnimation3;
  late Animation<Offset> _slideAnimation1;
  late Animation<Offset> _slideAnimation2;
  late Animation<Offset> _slideAnimation3;
  late Animation<double> _scaleAnimation1;
  late Animation<double> _scaleAnimation2;
  late Animation<double> _scaleAnimation3;

  @override
  void initState() {
    super.initState();

    // Initialize progress controller
    _progressController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Progress ring animations
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    _colorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.green,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    // Initialize staggered controller
    _staggeredController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Staggered fade animations with intervals
    _fadeAnimation1 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _staggeredController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    ));

    _fadeAnimation2 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _staggeredController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeIn),
    ));

    _fadeAnimation3 = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _staggeredController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
    ));

    // Staggered slide animations
    _slideAnimation1 = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _staggeredController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
    ));

    _slideAnimation2 = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _staggeredController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
    ));

    _slideAnimation3 = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _staggeredController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
    ));

    // Staggered scale animations
    _scaleAnimation1 = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _staggeredController,
      curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
    ));

    _scaleAnimation2 = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _staggeredController,
      curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
    ));

    _scaleAnimation3 = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _staggeredController,
      curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
    ));
  }

  @override
  void dispose() {
    _progressController.dispose();
    _staggeredController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress Ring Example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Custom Progress Ring',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimatedBuilder(
                      animation: _progressController,
                      builder: (context, child) {
                        return SizedBox(
                          width: 120,
                          height: 120,
                          child: CustomPaint(
                            painter: ProgressRingPainter(
                              progress: _progressAnimation.value,
                              color: _colorAnimation.value ?? Colors.blue,
                              strokeWidth: 8.0,
                              backgroundColor: Colors.grey.shade300,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${(_progressAnimation.value * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      alignment: WrapAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_progressController.status == AnimationStatus.completed) {
                              _progressController.reverse();
                            } else {
                              _progressController.forward();
                            }
                          },
                          child: Text(
                            _progressController.status == AnimationStatus.completed
                                ? 'Reset'
                                : 'Start',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _progressController.repeat();
                          },
                          child: const Text('Repeat'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Staggered Animation Example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Staggered Card Animation',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimatedBuilder(
                      animation: _staggeredController,
                      builder: (context, child) {
                        return Column(
                          children: [
                            // Card 1
                            SlideTransition(
                              position: _slideAnimation1,
                              child: FadeTransition(
                                opacity: _fadeAnimation1,
                                child: ScaleTransition(
                                  scale: _scaleAnimation1,
                                  child: _buildStaggeredCard(
                                    'Card 1',
                                    Colors.blue,
                                    Icons.star,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Card 2
                            SlideTransition(
                              position: _slideAnimation2,
                              child: FadeTransition(
                                opacity: _fadeAnimation2,
                                child: ScaleTransition(
                                  scale: _scaleAnimation2,
                                  child: _buildStaggeredCard(
                                    'Card 2',
                                    Colors.green,
                                    Icons.favorite,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Card 3
                            SlideTransition(
                              position: _slideAnimation3,
                              child: FadeTransition(
                                opacity: _fadeAnimation3,
                                child: ScaleTransition(
                                  scale: _scaleAnimation3,
                                  child: _buildStaggeredCard(
                                    'Card 3',
                                    Colors.orange,
                                    Icons.thumb_up,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      alignment: WrapAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_staggeredController.status == AnimationStatus.completed) {
                              _staggeredController.reverse();
                            } else {
                              _staggeredController.forward();
                            }
                          },
                          child: Text(
                            _staggeredController.status == AnimationStatus.completed
                                ? 'Hide'
                                : 'Show',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _staggeredController.repeat();
                          },
                          child: const Text('Repeat'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Information card
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Custom Animations',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Custom painters for complex graphics\n'
                      '• Staggered animations with intervals\n'
                      '• Multiple animations on single controller\n'
                      '• Custom curves and timing functions\n'
                      '• Efficient repaint with shouldRepaint',
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

  Widget _buildStaggeredCard(String title, Color color, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
