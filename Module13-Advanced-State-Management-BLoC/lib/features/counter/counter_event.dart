import 'package:equatable/equatable.dart';

/// Events that can be dispatched to the CounterBloc
/// This demonstrates the fundamental BLoC pattern with simple events
abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object?> get props => [];
}

/// Event to increment the counter
class CounterIncrement extends CounterEvent {
  const CounterIncrement();
}

/// Event to decrement the counter
class CounterDecrement extends CounterEvent {
  const CounterDecrement();
}

/// Event to reset the counter to zero
class CounterReset extends CounterEvent {
  const CounterReset();
}
