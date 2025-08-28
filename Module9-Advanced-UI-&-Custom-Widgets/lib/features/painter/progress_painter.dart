import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../app/theme.dart';

/// Custom painter for drawing a progress ring
/// Demonstrates Canvas, Paint, and custom drawing techniques
class ProgressRingPainter extends CustomPainter {
  ProgressRingPainter({
    required this.progress,
    required this.ringColor,
    required this.progressColor,
    this.strokeWidth = 8.0,
    this.backgroundColor,
  });

  final double progress; // 0.0 to 1.0
  final Color ringColor;
  final Color progressColor;
  final double strokeWidth;
  final Color? backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - strokeWidth / 2;

    // Draw background ring
    if (backgroundColor != null) {
      final backgroundPaint = Paint()
        ..color = backgroundColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawCircle(center, radius, backgroundPaint);
    }

    // Draw progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromCircle(center: center, radius: radius);
    final startAngle = -math.pi / 2; // Start from top
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(rect, startAngle, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
           oldDelegate.ringColor != ringColor ||
           oldDelegate.progressColor != progressColor ||
           oldDelegate.strokeWidth != strokeWidth ||
           oldDelegate.backgroundColor != backgroundColor;
  }
}

/// Custom painter for drawing a pie chart
/// Demonstrates more complex custom drawing
class PieChartPainter extends CustomPainter {
  PieChartPainter({
    required this.sections,
    this.strokeWidth = 2.0,
  });

  final List<PieSection> sections;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - strokeWidth;

    final rect = Rect.fromCircle(center: center, radius: radius);
    double startAngle = -math.pi / 2; // Start from top

    for (final section in sections) {
      final paint = Paint()
        ..color = section.color
        ..style = PaintingStyle.fill;

      final sweepAngle = 2 * math.pi * section.percentage;
      
      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
      
      // Draw border
      final borderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;
      
      canvas.drawArc(rect, startAngle, sweepAngle, true, borderPaint);
      
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(PieChartPainter oldDelegate) {
    return oldDelegate.sections != sections ||
           oldDelegate.strokeWidth != strokeWidth;
  }
}

/// Data class for pie chart sections
class PieSection {
  const PieSection({
    required this.label,
    required this.percentage,
    required this.color,
  });

  final String label;
  final double percentage; // 0.0 to 1.0
  final Color color;
}

/// Widget that uses the ProgressRingPainter
class ProgressRing extends StatelessWidget {
  const ProgressRing({
    super.key,
    required this.progress,
    this.size = 200.0,
    this.ringColor = Colors.grey,
    this.progressColor = Colors.blue,
    this.backgroundColor,
    this.strokeWidth = 8.0,
    this.showPercentage = true,
  });

  final double progress; // 0.0 to 1.0
  final double size;
  final Color ringColor;
  final Color progressColor;
  final Color? backgroundColor;
  final double strokeWidth;
  final bool showPercentage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: ProgressRingPainter(
              progress: progress,
              ringColor: ringColor,
              progressColor: progressColor,
              backgroundColor: backgroundColor,
              strokeWidth: strokeWidth,
            ),
          ),
          if (showPercentage)
            Text(
              '${(progress * 100).toInt()}%',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: progressColor,
              ),
            ),
        ],
      ),
    );
  }
}

/// Widget that uses the PieChartPainter
class PieChart extends StatelessWidget {
  const PieChart({
    super.key,
    required this.sections,
    this.size = 200.0,
    this.strokeWidth = 2.0,
    this.showLegend = true,
  });

  final List<PieSection> sections;
  final double size;
  final double strokeWidth;
  final bool showLegend;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            size: Size(size, size),
            painter: PieChartPainter(
              sections: sections,
              strokeWidth: strokeWidth,
            ),
          ),
        ),
        if (showLegend) ...[
          const SizedBox(height: 16),
          _Legend(sections: sections),
        ],
      ],
    );
  }
}

/// Legend widget for pie chart
class _Legend extends StatelessWidget {
  const _Legend({required this.sections});

  final List<PieSection> sections;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: sections.map((section) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: section.color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${section.label} (${(section.percentage * 100).toInt()}%)',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        );
      }).toList(),
    );
  }
}

/// Demo page showcasing CustomPainter usage
class ProgressPainterDemo extends StatefulWidget {
  const ProgressPainterDemo({super.key});

  @override
  State<ProgressPainterDemo> createState() => _ProgressPainterDemoState();
}

class _ProgressPainterDemoState extends State<ProgressPainterDemo>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  double _currentProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    _progressAnimation.addListener(() {
      setState(() {
        _currentProgress = _progressAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  void _animateProgress() {
    if (_progressController.isCompleted) {
      _progressController.reverse();
    } else {
      _progressController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final brandColors = Theme.of(context).extension<BrandColors>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomPainter Demo'),
        backgroundColor: brandColors?.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CustomPainter Demo',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This demonstrates custom drawing using Canvas, Paint, and CustomPainter. '
              'Shows progress rings and pie charts with smooth animations.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            
            // Progress Ring Section
            Text(
              'Progress Ring',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ProgressRing(
                progress: _currentProgress,
                size: 200,
                progressColor: brandColors?.primary ?? Colors.purple,
                backgroundColor: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: FilledButton(
                onPressed: _animateProgress,
                child: const Text('Animate Progress'),
              ),
            ),
            const SizedBox(height: 32),
            
            // Pie Chart Section
            Text(
              'Pie Chart',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: PieChart(
                sections: [
                  const PieSection(
                    label: 'Flutter',
                    percentage: 0.4,
                    color: Colors.blue,
                  ),
                  const PieSection(
                    label: 'Dart',
                    percentage: 0.3,
                    color: Colors.cyan,
                  ),
                  const PieSection(
                    label: 'UI/UX',
                    percentage: 0.2,
                    color: Colors.green,
                  ),
                  const PieSection(
                    label: 'Testing',
                    percentage: 0.1,
                    color: Colors.orange,
                  ),
                ],
                size: 200,
              ),
            ),
            const SizedBox(height: 32),
            
            // Multiple Progress Rings
            Text(
              'Multiple Progress Rings',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProgressRing(
                  progress: 0.75,
                  size: 100,
                  progressColor: Colors.red,
                  strokeWidth: 6,
                ),
                ProgressRing(
                  progress: 0.5,
                  size: 100,
                  progressColor: Colors.green,
                  strokeWidth: 6,
                ),
                ProgressRing(
                  progress: 0.25,
                  size: 100,
                  progressColor: Colors.blue,
                  strokeWidth: 6,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
