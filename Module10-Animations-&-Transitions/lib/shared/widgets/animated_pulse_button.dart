import 'package:flutter/material.dart';

class AnimatedPulseButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Duration duration;
  final Curve curve;

  const AnimatedPulseButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  @override
  State<AnimatedPulseButton> createState() => _AnimatedPulseButtonState();
}

class _AnimatedPulseButtonState extends State<AnimatedPulseButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize the animation controller with vsync
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Create scale animation: 1.0 → 1.1 → 1.0
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    // Create opacity animation: 1.0 → 0.7 → 1.0
    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.7,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
  }

  @override
  void dispose() {
    // Always dispose controllers to prevent memory leaks
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    // Trigger the pulse animation
    _controller.forward().then((_) {
      _controller.reverse();
    });
    
    // Call the original onPressed callback
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: GestureDetector(
              onTapDown: (_) => _handleTap(),
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}
