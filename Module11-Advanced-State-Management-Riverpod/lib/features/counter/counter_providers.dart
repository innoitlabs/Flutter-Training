import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'counter_notifier.dart';

// Simple StateProvider for basic state management
// Use when you need simple mutable state without complex logic
final counterProvider = StateProvider<int>((ref) => 0);

// StateNotifierProvider for complex state management with business logic
// Use when you need methods, validation, or complex state transitions
final counterNotifierProvider = StateNotifierProvider<CounterNotifier, int>(
  (ref) => CounterNotifier(),
);

// Derived provider that computes a value based on other providers
// This demonstrates how to create computed values that update automatically
final isEvenProvider = Provider<bool>((ref) {
  // ref.watch listens to changes in counterNotifierProvider
  final count = ref.watch(counterNotifierProvider);
  return count.isEven;
});

// Another derived provider showing more complex computations
final counterStatusProvider = Provider<String>((ref) {
  final count = ref.watch(counterNotifierProvider);
  if (count == 0) return 'Zero';
  if (count > 0) return 'Positive';
  return 'Negative';
});
