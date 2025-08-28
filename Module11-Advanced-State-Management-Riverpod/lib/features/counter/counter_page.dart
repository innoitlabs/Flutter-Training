import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'counter_providers.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.listen allows you to react to state changes without rebuilding
    // This is useful for side effects like showing snackbars
    ref.listen<int>(counterNotifierProvider, (previous, next) {
      if (next == 10) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🎉 You reached 10!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      if (next == -5) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('⚠️ Counter is getting low!'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // StateProvider Example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'StateProvider Example',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // ref.watch rebuilds the widget when the provider changes
                    Consumer(
                      builder: (context, ref, child) {
                        final count = ref.watch(counterProvider);
                        return Text(
                          'Count: $count',
                          style: Theme.of(context).textTheme.headlineMedium,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // ref.read is used for one-time reads or actions
                            // It doesn't create a dependency on the provider
                            ref.read(counterProvider.notifier).state--;
                          },
                          child: const Text('-'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(counterProvider.notifier).state++;
                          },
                          child: const Text('+'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // StateNotifierProvider Example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'StateNotifierProvider Example',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Consumer(
                      builder: (context, ref, child) {
                        final count = ref.watch(counterNotifierProvider);
                        return Text(
                          'Count: $count',
                          style: Theme.of(context).textTheme.headlineMedium,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Derived provider example with optimization
                    Consumer(
                      builder: (context, ref, child) {
                        // ref.watch with select optimizes rebuilds
                        // Only rebuilds when the selected value changes
                        final isEven = ref.watch(
                          counterNotifierProvider.select((value) => value.isEven),
                        );
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isEven ? Colors.green : Colors.red,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            isEven ? 'EVEN' : 'ODD',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Status provider example
                    Consumer(
                      builder: (context, ref, child) {
                        final status = ref.watch(counterStatusProvider);
                        return Text(
                          'Status: $status',
                          style: Theme.of(context).textTheme.titleMedium,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Call methods on the StateNotifier
                            ref.read(counterNotifierProvider.notifier).decrement();
                          },
                          child: const Text('-'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(counterNotifierProvider.notifier).increment();
                          },
                          child: const Text('+'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(counterNotifierProvider.notifier).reset();
                          },
                          child: const Text('Reset'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            ref.read(counterNotifierProvider.notifier).add(5);
                          },
                          child: const Text('+5'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(counterNotifierProvider.notifier).setValue(100);
                          },
                          child: const Text('Set 100'),
                        ),
                      ],
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
}
