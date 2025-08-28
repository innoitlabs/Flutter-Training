import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_hub/features/counter/counter_bloc.dart';
import 'package:bloc_hub/features/counter/counter_event.dart';
import 'package:bloc_hub/features/counter/counter_state.dart';

/// Unit tests for CounterBloc
/// This demonstrates fundamental BLoC testing patterns
void main() {
  group('CounterBloc', () {
    late CounterBloc counterBloc;

    setUp(() {
      counterBloc = CounterBloc();
    });

    tearDown(() {
      counterBloc.close();
    });

    test('initial state is 0', () {
      expect(counterBloc.state, const CounterState.initial());
      expect(counterBloc.state.value, 0);
      expect(counterBloc.state.isEven, true);
      expect(counterBloc.state.isPositive, false);
      expect(counterBloc.state.isZero, true);
    });

    group('CounterIncrement', () {
      blocTest<CounterBloc, CounterState>(
        'emits [CounterState(value: 1)] when increment is added',
        build: () => counterBloc,
        act: (bloc) => bloc.add(const CounterIncrement()),
        expect: () => [const CounterState(value: 1)],
      );

      blocTest<CounterBloc, CounterState>(
        'emits [CounterState(value: 2)] when increment is added twice',
        build: () => counterBloc,
        act: (bloc) => bloc
          ..add(const CounterIncrement())
          ..add(const CounterIncrement()),
        expect: () => [
          const CounterState(value: 1),
          const CounterState(value: 2),
        ],
      );

      blocTest<CounterBloc, CounterState>(
        'emits correct derived properties when incrementing',
        build: () => counterBloc,
        act: (bloc) => bloc
          ..add(const CounterIncrement()) // 1 (odd, positive)
          ..add(const CounterIncrement()), // 2 (even, positive)
        expect: () => [
          const CounterState(value: 1), // isEven: false, isPositive: true, isZero: false
          const CounterState(value: 2), // isEven: true, isPositive: true, isZero: false
        ],
        verify: (bloc) {
          expect(bloc.state.value, 2);
          expect(bloc.state.isEven, true);
          expect(bloc.state.isPositive, true);
          expect(bloc.state.isZero, false);
        },
      );
    });

    group('CounterDecrement', () {
      blocTest<CounterBloc, CounterState>(
        'emits [CounterState(value: 0)] when decrement is added to initial state',
        build: () => counterBloc,
        act: (bloc) => bloc.add(const CounterDecrement()),
        expect: () => [const CounterState(value: 0)],
      );

      blocTest<CounterBloc, CounterState>(
        'emits [CounterState(value: 1)] when decrement is added after increment',
        build: () => counterBloc,
        act: (bloc) => bloc
          ..add(const CounterIncrement())
          ..add(const CounterIncrement()) // value: 2
          ..add(const CounterDecrement()), // value: 1
        expect: () => [
          const CounterState(value: 1),
          const CounterState(value: 2),
          const CounterState(value: 1),
        ],
      );

      blocTest<CounterBloc, CounterState>(
        'prevents negative values when decrementing',
        build: () => counterBloc,
        act: (bloc) => bloc
          ..add(const CounterDecrement()) // 0
          ..add(const CounterDecrement()) // still 0
          ..add(const CounterDecrement()), // still 0
        expect: () => [
          const CounterState(value: 0),
          const CounterState(value: 0),
          const CounterState(value: 0),
        ],
        verify: (bloc) {
          expect(bloc.state.value, 0);
          expect(bloc.state.isZero, true);
        },
      );
    });

    group('CounterReset', () {
      blocTest<CounterBloc, CounterState>(
        'emits [CounterState(value: 0)] when reset is added',
        build: () => counterBloc,
        act: (bloc) => bloc.add(const CounterReset()),
        expect: () => [const CounterState.initial()],
      );

      blocTest<CounterBloc, CounterState>(
        'resets to 0 from any value',
        build: () => counterBloc,
        act: (bloc) => bloc
          ..add(const CounterIncrement())
          ..add(const CounterIncrement())
          ..add(const CounterIncrement()) // value: 3
          ..add(const CounterReset()), // value: 0
        expect: () => [
          const CounterState(value: 1),
          const CounterState(value: 2),
          const CounterState(value: 3),
          const CounterState.initial(),
        ],
        verify: (bloc) {
          expect(bloc.state.value, 0);
          expect(bloc.state.isEven, true);
          expect(bloc.state.isPositive, false);
          expect(bloc.state.isZero, true);
        },
      );
    });

    group('Complex scenarios', () {
      blocTest<CounterBloc, CounterState>(
        'handles multiple operations correctly',
        build: () => counterBloc,
        act: (bloc) => bloc
          ..add(const CounterIncrement()) // 1
          ..add(const CounterIncrement()) // 2
          ..add(const CounterDecrement()) // 1
          ..add(const CounterIncrement()) // 2
          ..add(const CounterReset()) // 0
          ..add(const CounterIncrement()), // 1
        expect: () => [
          const CounterState(value: 1),
          const CounterState(value: 2),
          const CounterState(value: 1),
          const CounterState(value: 2),
          const CounterState.initial(),
          const CounterState(value: 1),
        ],
        verify: (bloc) {
          expect(bloc.state.value, 1);
          expect(bloc.state.isEven, false);
          expect(bloc.state.isPositive, true);
          expect(bloc.state.isZero, false);
        },
      );
    });
  });
}
