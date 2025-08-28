import 'package:equatable/equatable.dart';

/// State representing the counter's current value and derived properties
/// This demonstrates how states can contain both data and computed properties
class CounterState extends Equatable {
  final int value;
  final bool isEven;
  final bool isPositive;
  final bool isZero;

  const CounterState({
    required this.value,
  }) : isEven = value % 2 == 0,
       isPositive = value > 0,
       isZero = value == 0;

  /// Factory constructor for initial state
  const CounterState.initial() : this(value: 0);

  /// Factory constructor for a specific value
  const CounterState.value(int value) : this(value: value);

  /// Creates a copy of this state with updated values
  CounterState copyWith({int? value}) {
    return CounterState(value: value ?? this.value);
  }

  @override
  List<Object?> get props => [value, isEven, isPositive, isZero];

  @override
  String toString() => 'CounterState(value: $value, isEven: $isEven, isPositive: $isPositive, isZero: $isZero)';
}
