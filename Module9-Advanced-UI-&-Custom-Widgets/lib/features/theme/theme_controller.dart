import 'package:flutter/material.dart';

/// Custom color data class for theme state
class CustomColorData {
  const CustomColorData({
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
  });

  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;

  CustomColorData copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? accentColor,
  }) {
    return CustomColorData(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      accentColor: accentColor ?? this.accentColor,
    );
  }
}

/// InheritedWidget for theme state management
/// Demonstrates how to propagate state down the widget tree
class ThemeController extends InheritedWidget {
  const ThemeController({
    super.key,
    required this.colorData,
    required this.onColorChanged,
    required super.child,
  });

  final CustomColorData colorData;
  final ValueChanged<CustomColorData> onColorChanged;

  /// Static method to access the ThemeController from any descendant widget
  static ThemeController of(BuildContext context) {
    final ThemeController? result = context.dependOnInheritedWidgetOfExactType<ThemeController>();
    assert(result != null, 'No ThemeController found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ThemeController oldWidget) {
    return colorData != oldWidget.colorData;
  }
}

/// Stateful widget that manages theme state
/// Demonstrates proper lifecycle management
class ThemeControllerDemo extends StatefulWidget {
  const ThemeControllerDemo({super.key});

  @override
  State<ThemeControllerDemo> createState() => _ThemeControllerDemoState();
}

class _ThemeControllerDemoState extends State<ThemeControllerDemo> {
  late CustomColorData _colorData;

  @override
  void initState() {
    super.initState();
    // Initialize with default colors
    _colorData = const CustomColorData(
      primaryColor: Colors.blue,
      secondaryColor: Colors.green,
      accentColor: Colors.orange,
    );
  }

  void _updateColors(CustomColorData newColors) {
    setState(() {
      _colorData = newColors;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeController(
      colorData: _colorData,
      onColorChanged: _updateColors,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('InheritedWidget Demo'),
          backgroundColor: _colorData.primaryColor,
          foregroundColor: Colors.white,
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DescriptionSection(),
              SizedBox(height: 24),
              _ColorControlsSection(),
              SizedBox(height: 24),
              _ThemeDisplaySection(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Description section widget
class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'InheritedWidget Demo',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'This demonstrates how InheritedWidget propagates state down the widget tree. '
          'Descendant widgets automatically rebuild when the theme colors change.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

/// Color controls section widget
class _ColorControlsSection extends StatelessWidget {
  const _ColorControlsSection();

  @override
  Widget build(BuildContext context) {
    final controller = ThemeController.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color Controls',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _ColorButton(
                label: 'Blue Theme',
                color: Colors.blue,
                onPressed: () => controller.onColorChanged(
                  const CustomColorData(
                    primaryColor: Colors.blue,
                    secondaryColor: Colors.lightBlue,
                    accentColor: Colors.blueAccent,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _ColorButton(
                label: 'Purple Theme',
                color: Colors.purple,
                onPressed: () => controller.onColorChanged(
                  const CustomColorData(
                    primaryColor: Colors.purple,
                    secondaryColor: Colors.deepPurple,
                    accentColor: Colors.purpleAccent,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _ColorButton(
                label: 'Green Theme',
                color: Colors.green,
                onPressed: () => controller.onColorChanged(
                  const CustomColorData(
                    primaryColor: Colors.green,
                    secondaryColor: Colors.lightGreen,
                    accentColor: Colors.greenAccent,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _ColorButton(
                label: 'Orange Theme',
                color: Colors.orange,
                onPressed: () => controller.onColorChanged(
                  const CustomColorData(
                    primaryColor: Colors.orange,
                    secondaryColor: Colors.deepOrange,
                    accentColor: Colors.orangeAccent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Reusable color button widget
class _ColorButton extends StatelessWidget {
  const _ColorButton({
    required this.label,
    required this.color,
    required this.onPressed,
  });

  final String label;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      child: Text(label),
    );
  }
}

/// Theme display section widget
/// Demonstrates how descendant widgets access InheritedWidget data
class _ThemeDisplaySection extends StatelessWidget {
  const _ThemeDisplaySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current Theme Colors',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        const _ColorDisplayCard(),
        const SizedBox(height: 16),
        const _ColorPreviewWidget(),
      ],
    );
  }
}

/// Color display card widget
/// Shows how to access InheritedWidget data using ThemeController.of(context)
class _ColorDisplayCard extends StatelessWidget {
  const _ColorDisplayCard();

  @override
  Widget build(BuildContext context) {
    // Access the InheritedWidget data
    final colorData = ThemeController.of(context).colorData;
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _ColorRow('Primary', colorData.primaryColor),
            const SizedBox(height: 8),
            _ColorRow('Secondary', colorData.secondaryColor),
            const SizedBox(height: 8),
            _ColorRow('Accent', colorData.accentColor),
          ],
        ),
      ),
    );
  }
}

/// Color row widget for displaying color information
class _ColorRow extends StatelessWidget {
  const _ColorRow(this.label, this.color);

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            '$label: ${color.toString()}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

/// Color preview widget
/// Another example of accessing InheritedWidget data
class _ColorPreviewWidget extends StatelessWidget {
  const _ColorPreviewWidget();

  @override
  Widget build(BuildContext context) {
    // Access the InheritedWidget data
    final colorData = ThemeController.of(context).colorData;
    
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorData.primaryColor,
            colorData.secondaryColor,
            colorData.accentColor,
          ],
        ),
      ),
      child: const Center(
        child: Text(
          'Color Preview',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
