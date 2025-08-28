import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_hub/features/counter/counter_notifier.dart';
import 'package:riverpod_hub/features/counter/counter_providers.dart';

void main() {
  group('CounterNotifier', () {
    late ProviderContainer container;
    late CounterNotifier notifier;

    setUp(() {
      container = ProviderContainer();
      notifier = container.read(counterNotifierProvider.notifier);
    });

    tearDown(() {
      container.dispose();
    });

    test('should start with initial value of 0', () {
      expect(notifier.state, 0);
    });

    test('should increment counter', () {
      notifier.increment();
      expect(notifier.state, 1);

      notifier.increment();
      expect(notifier.state, 2);
    });

    test('should decrement counter', () {
      notifier.increment();
      notifier.increment();
      expect(notifier.state, 2);

      notifier.decrement();
      expect(notifier.state, 1);

      notifier.decrement();
      expect(notifier.state, 0);
    });

    test('should reset counter to 0', () {
      notifier.increment();
      notifier.increment();
      notifier.increment();
      expect(notifier.state, 3);

      notifier.reset();
      expect(notifier.state, 0);
    });

    test('should add specific value', () {
      notifier.add(5);
      expect(notifier.state, 5);

      notifier.add(3);
      expect(notifier.state, 8);
    });

    test('should set specific value', () {
      notifier.setValue(100);
      expect(notifier.state, 100);

      notifier.setValue(42);
      expect(notifier.state, 42);
    });

    test('should correctly identify even numbers', () {
      expect(notifier.isEven, true); // 0 is even

      notifier.increment();
      expect(notifier.isEven, false); // 1 is odd

      notifier.increment();
      expect(notifier.isEven, true); // 2 is even

      notifier.add(3);
      expect(notifier.isEven, false); // 5 is odd
    });

    test('should correctly identify odd numbers', () {
      expect(notifier.isOdd, false); // 0 is not odd

      notifier.increment();
      expect(notifier.isOdd, true); // 1 is odd

      notifier.increment();
      expect(notifier.isOdd, false); // 2 is not odd
    });
  });

  group('Counter Providers', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('counterProvider should start at 0', () {
      final count = container.read(counterProvider);
      expect(count, 0);
    });

    test('counterNotifierProvider should start at 0', () {
      final count = container.read(counterNotifierProvider);
      expect(count, 0);
    });

    test('isEvenProvider should return true for even numbers', () {
      final notifier = container.read(counterNotifierProvider.notifier);
      
      // Start with 0 (even)
      expect(container.read(isEvenProvider), true);

      // Increment to 1 (odd)
      notifier.increment();
      expect(container.read(isEvenProvider), false);

      // Increment to 2 (even)
      notifier.increment();
      expect(container.read(isEvenProvider), true);
    });

    test('counterStatusProvider should return correct status', () {
      final notifier = container.read(counterNotifierProvider.notifier);
      
      // Start with 0
      expect(container.read(counterStatusProvider), 'Zero');

      // Positive number
      notifier.increment();
      expect(container.read(counterStatusProvider), 'Positive');

      // Negative number
      notifier.setValue(-5);
      expect(container.read(counterStatusProvider), 'Negative');
    });

    test('should update derived providers when state changes', () {
      final notifier = container.read(counterNotifierProvider.notifier);
      
      // Initial state
      expect(container.read(isEvenProvider), true);
      expect(container.read(counterStatusProvider), 'Zero');

      // Change state
      notifier.setValue(5);
      
      // Derived providers should update
      expect(container.read(isEvenProvider), false);
      expect(container.read(counterStatusProvider), 'Positive');
    });
  });
}
