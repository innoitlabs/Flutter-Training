import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_event.dart';
import 'counter_state.dart';

/// CounterBloc demonstrates fundamental BLoC patterns:
/// - Event handling with on<Event> methods
/// - State emission with emit()
/// - Business logic separation from UI
/// - Simple state transitions
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState.initial()) {
    // Register event handlers
    on<CounterIncrement>(_onIncrement);
    on<CounterDecrement>(_onDecrement);
    on<CounterReset>(_onReset);
  }

  /// Handles CounterIncrement events
  /// This demonstrates synchronous event handling
  void _onIncrement(CounterIncrement event, Emitter<CounterState> emit) {
    // Business logic: increment the counter
    final newValue = state.value + 1;
    emit(CounterState.value(newValue));
  }

  /// Handles CounterDecrement events
  /// This demonstrates synchronous event handling with validation
  void _onDecrement(CounterDecrement event, Emitter<CounterState> emit) {
    // Business logic: decrement the counter (no negative values)
    final newValue = state.value > 0 ? state.value - 1 : 0;
    emit(CounterState.value(newValue));
  }

  /// Handles CounterReset events
  /// This demonstrates synchronous event handling
  void _onReset(CounterReset event, Emitter<CounterState> emit) {
    // Business logic: reset to zero
    emit(const CounterState.initial());
  }

  @override
  void onTransition(Transition<CounterEvent, CounterState> transition) {
    super.onTransition(transition);
    // Optional: Log transitions for debugging
    // print('${transition.event} -> ${transition.currentState}');
  }
}
