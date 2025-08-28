import 'package:flutter/material.dart';
import '../../shared/widgets/animated_pulse_button.dart';

class ExplicitPage extends StatefulWidget {
  const ExplicitPage({super.key});

  @override
  State<ExplicitPage> createState() => _ExplicitPageState();
}

class _ExplicitPageState extends State<ExplicitPage>
    with TickerProviderStateMixin {
  // Animation controllers for different examples
  late AnimationController _cardController;
  late AnimationController _rotationController;
  late AnimationController _bounceController;

  // Animations for the expanding card
  late Animation<double> _cardScaleAnimation;
  late Animation<double> _cardOpacityAnimation;
  late Animation<Offset> _cardSlideAnimation;

  // Animations for the rotating icon
  late Animation<double> _rotationAnimation;

  // Animations for the bouncing ball
  late Animation<double> _bounceAnimation;
  late Animation<double> _bounceOpacityAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize card animation controller
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Create card animations with different curves
    _cardScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _cardController,
      curve: Curves.elasticOut,
    ));

    _cardOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _cardController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    ));

    _cardSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _cardController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
    ));

    // Initialize rotation animation controller
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    // Initialize bounce animation controller
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.bounceOut,
    ));

    _bounceOpacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
    ));
  }

  @override
  void dispose() {
    // Always dispose controllers to prevent memory leaks
    _cardController.dispose();
    _rotationController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Expanding Card Example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Expanding Card',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimatedBuilder(
                      animation: _cardController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _cardScaleAnimation.value,
                          child: SlideTransition(
                            position: _cardSlideAnimation,
                            child: Opacity(
                              opacity: _cardOpacityAnimation.value,
                              child: Container(
                                width: 200,
                                height: 120,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.purple.shade300,
                                      Colors.purple.shade600,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Animated Card',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                            if (_cardController.status == AnimationStatus.completed) {
                              _cardController.reverse();
                            } else {
                              _cardController.forward();
                            }
                          },
                          child: Text(
                            _cardController.status == AnimationStatus.completed
                                ? 'Collapse'
                                : 'Expand',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _cardController.repeat();
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

            // Rotating Icon Example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Rotating Icon',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimatedBuilder(
                      animation: _rotationController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _rotationAnimation.value * 2 * 3.14159,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.refresh,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
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
                            if (_rotationController.isAnimating) {
                              _rotationController.stop();
                            } else {
                              _rotationController.repeat();
                            }
                          },
                          child: Text(
                            _rotationController.isAnimating ? 'Stop' : 'Start',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _rotationController.reset();
                          },
                          child: const Text('Reset'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Bouncing Ball Example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Bouncing Ball',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: AnimatedBuilder(
                        animation: _bounceController,
                        builder: (context, child) {
                          return Align(
                            alignment: Alignment(
                              0,
                              -1 + 2 * _bounceAnimation.value,
                            ),
                            child: Opacity(
                              opacity: _bounceOpacityAnimation.value,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _bounceController.forward().then((_) {
                          _bounceController.reset();
                        });
                      },
                      child: const Text('Bounce'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Animated Pulse Button Example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Custom Animated Button',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimatedPulseButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Button pressed!'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Pulse Me!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
                      'Explicit Animations',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Manual control with AnimationController\n'
                      '• Requires TickerProviderStateMixin for vsync\n'
                      '• Use Tween to define animation values\n'
                      '• AnimatedBuilder for efficient rebuilds\n'
                      '• Always dispose controllers!',
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
}
