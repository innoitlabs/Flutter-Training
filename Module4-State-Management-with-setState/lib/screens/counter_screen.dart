import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  // State variables that can be modified
  int _counter = 0;
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Using setState',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'setState() tells Flutter to rebuild the widget with new state values.\n'
              'This is the most basic form of state management in Flutter.',
            ),
            const SizedBox(height: 32),
            
            // Counter Display
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      '$_counter',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _counter > 0 
                            ? Colors.green 
                            : _counter < 0 
                                ? Colors.red 
                                : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _message,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Control Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _decrement,
                  icon: const Icon(Icons.remove),
                  label: const Text('Decrement'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[100],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _reset,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[100],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _increment,
                  icon: const Icon(Icons.add),
                  label: const Text('Increment'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[100],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Code Explanation
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How setState Works:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '1. User taps a button\n'
                      '2. setState() is called with a callback\n'
                      '3. State variables are modified inside setState\n'
                      '4. Flutter rebuilds the widget with new values\n'
                      '5. UI updates to reflect the new state',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to increment counter
  void _increment() {
    setState(() {
      // This callback is where we modify the state
      _counter++;
      _updateMessage();
    });
  }

  // Method to decrement counter
  void _decrement() {
    setState(() {
      // This callback is where we modify the state
      _counter--;
      _updateMessage();
    });
  }

  // Method to reset counter
  void _reset() {
    setState(() {
      // This callback is where we modify the state
      _counter = 0;
      _updateMessage();
    });
  }

  // Helper method to update message based on counter value
  void _updateMessage() {
    if (_counter > 0) {
      _message = 'Positive number!';
    } else if (_counter < 0) {
      _message = 'Negative number!';
    } else {
      _message = 'Zero!';
    }
  }
}
