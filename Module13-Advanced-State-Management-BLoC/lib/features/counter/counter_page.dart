import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_bloc.dart';
import 'counter_event.dart';
import 'counter_state.dart';

/// Counter page demonstrates fundamental BLoC UI patterns:
/// - BlocBuilder for reactive UI updates
/// - BlocListener for side effects (snackbars)
/// - Event dispatching from UI interactions
class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter BLoC'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocListener<CounterBloc, CounterState>(
        // Listen for state changes to show snackbars
        listener: (context, state) {
          // Show snackbar when reaching certain thresholds
          if (state.value == 10) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('🎉 You reached 10!'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state.value == 0 && !state.isZero) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Counter reset to zero'),
                backgroundColor: Colors.orange,
              ),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display current counter value
              BlocBuilder<CounterBloc, CounterState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Text(
                        '${state.value}',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: state.isEven ? Colors.blue : Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Display derived state properties
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                'Parity: ${state.isEven ? "Even" : "Odd"}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Status: ${state.isZero ? "Zero" : state.isPositive ? "Positive" : "Negative"}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 32),
              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Dispatch decrement event
                      context.read<CounterBloc>().add(const CounterDecrement());
                    },
                    icon: const Icon(Icons.remove),
                    label: const Text('Decrement'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Dispatch reset event
                      context.read<CounterBloc>().add(const CounterReset());
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Dispatch increment event
                      context.read<CounterBloc>().add(const CounterIncrement());
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Increment'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // BLoC information card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'BLoC Pattern Demo',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'This demonstrates fundamental BLoC concepts:\n'
                        '• Events: Increment, Decrement, Reset\n'
                        '• States: Value with derived properties\n'
                        '• UI: BlocBuilder, BlocListener, Event dispatching',
                        textAlign: TextAlign.center,
                      ),
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
