import 'package:flutter/material.dart';
import 'counter_service.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final CounterService _counterService = CounterService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_counterService.count}',
              style: Theme.of(context).textTheme.headlineLarge,
              key: const Key('counter_value'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _counterService.increment();
                    });
                  },
                  key: const Key('increment_button'),
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _counterService.isZero
                      ? null
                      : () {
                          setState(() {
                            _counterService.decrement();
                          });
                        },
                  key: const Key('decrement_button'),
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _counterService.reset();
                    });
                  },
                  key: const Key('reset_button'),
                  child: const Icon(Icons.refresh),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              _counterService.isZero ? 'Counter is at zero' : 'Counter is positive',
              style: Theme.of(context).textTheme.bodyLarge,
              key: const Key('counter_status'),
            ),
          ],
        ),
      ),
    );
  }
}

