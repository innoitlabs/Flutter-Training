import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifier is used for complex state management with business logic
// It provides a way to manage state and expose methods to modify it
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  // Increment the counter
  void increment() {
    state = state + 1;
  }

  // Decrement the counter
  void decrement() {
    state = state - 1;
  }

  // Reset the counter to zero
  void reset() {
    state = 0;
  }

  // Add a specific value to the counter
  void add(int value) {
    state = state + value;
  }

  // Set the counter to a specific value
  void setValue(int value) {
    state = value;
  }

  // Check if the current value is even
  bool get isEven => state.isEven;

  // Check if the current value is odd
  bool get isOdd => state.isOdd;
}
