import 'package:flutter/material.dart';

class ImplicitPage extends StatefulWidget {
  const ImplicitPage({super.key});

  @override
  State<ImplicitPage> createState() => _ImplicitPageState();
}

class _ImplicitPageState extends State<ImplicitPage> {
  // State variables to control implicit animations
  bool _isExpanded = false;
  bool _isVisible = true;
  bool _isAligned = false;
  Color _containerColor = Colors.blue;
  double _borderRadius = 8.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // AnimatedContainer example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'AnimatedContainer',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      width: _isExpanded ? 200 : 100,
                      height: _isExpanded ? 200 : 100,
                      decoration: BoxDecoration(
                        color: _containerColor,
                        borderRadius: BorderRadius.circular(_borderRadius),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.auto_awesome,
                          color: Colors.white,
                          size: 32,
                        ),
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
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          child: Text(_isExpanded ? 'Shrink' : 'Expand'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _containerColor = _containerColor == Colors.blue
                                  ? Colors.red
                                  : Colors.blue;
                            });
                          },
                          child: const Text('Change Color'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _borderRadius = _borderRadius == 8.0 ? 50.0 : 8.0;
                            });
                          },
                          child: const Text('Toggle Radius'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // AnimatedOpacity example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'AnimatedOpacity',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimatedOpacity(
                      opacity: _isVisible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        width: 150,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'Fade In/Out',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      child: Text(_isVisible ? 'Hide' : 'Show'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // AnimatedAlign example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'AnimatedAlign',
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
                      child: AnimatedAlign(
                        alignment: _isAligned
                            ? Alignment.bottomRight
                            : Alignment.topLeft,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.bounceOut,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.star,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isAligned = !_isAligned;
                        });
                      },
                      child: Text(_isAligned ? 'Move to Top-Left' : 'Move to Bottom-Right'),
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
                      'Implicit Animations',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Automatically animate when properties change\n'
                      '• No controller needed - Flutter handles everything\n'
                      '• Perfect for simple property transitions\n'
                      '• Built-in widgets: AnimatedContainer, AnimatedOpacity, AnimatedAlign',
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
