import 'package:flutter/material.dart';

class WidgetComparisonScreen extends StatelessWidget {
  const WidgetComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Comparison'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'StatelessWidget vs StatefulWidget',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'StatelessWidget: Cannot change its state after creation.\n'
                'StatefulWidget: Can change its state and rebuild the UI.',
              ),
              const SizedBox(height: 24),
              
              // StatelessWidget Example
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'StatelessWidget Example:',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const StatelessExample(),
                      const SizedBox(height: 8),
                      const Text(
                        'This widget cannot change its text when tapped.',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // StatefulWidget Example
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'StatefulWidget Example:',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const StatefulExample(),
                      const SizedBox(height: 8),
                      const Text(
                        'This widget can change its text when tapped.',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Lifecycle Demo
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'StatefulWidget Lifecycle Demo:',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const LifecycleDemo(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// StatelessWidget Example
class StatelessExample extends StatelessWidget {
  const StatelessExample({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // This won't change anything because StatelessWidget cannot rebuild
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('StatelessWidget cannot change state!'),
            duration: Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Tap me (I\'m Stateless)',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

// StatefulWidget Example
class StatefulExample extends StatefulWidget {
  const StatefulExample({super.key});

  @override
  State<StatefulExample> createState() => _StatefulExampleState();
}

class _StatefulExampleState extends State<StatefulExample> {
  String _text = 'Tap me (I\'m Stateful)';
  int _tapCount = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // This will change the state and rebuild the widget
        setState(() {
          _tapCount++;
          _text = 'Tapped $_tapCount times!';
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          _text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

// Lifecycle Demo
class LifecycleDemo extends StatefulWidget {
  const LifecycleDemo({super.key});

  @override
  State<LifecycleDemo> createState() => _LifecycleDemoState();
}

class _LifecycleDemoState extends State<LifecycleDemo> {
  String _status = 'Widget created';
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    // Called when the widget is first created
    _status = 'initState called';
    debugPrint('LifecycleDemo: initState called');
  }

  @override
  void dispose() {
    // Called when the widget is removed from the widget tree
    debugPrint('LifecycleDemo: dispose called');
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _status = 'setState called - Counter: $_counter';
    });
    debugPrint('LifecycleDemo: setState called, counter = $_counter');
  }

  @override
  Widget build(BuildContext context) {
    // Called every time the widget needs to be rebuilt
    debugPrint('LifecycleDemo: build called');
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Status: $_status'),
        const SizedBox(height: 8),
        Text('Counter: $_counter'),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _incrementCounter,
          child: const Text('Increment Counter'),
        ),
        const SizedBox(height: 8),
        const Text(
          'Check the console for lifecycle logs!',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
        ),
      ],
    );
  }
}
