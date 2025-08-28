import 'package:flutter_test/flutter_test.dart';
import '../../lib/features/counter/counter_service.dart';

void main() {
  group('CounterService', () {
    late CounterService counterService;

    setUp(() {
      counterService = CounterService();
    });

    group('Initial state', () {
      test('should start with count of 0', () {
        expect(counterService.count, equals(0));
      });

      test('should be at zero initially', () {
        expect(counterService.isZero, isTrue);
      });

      test('should not be positive initially', () {
        expect(counterService.isPositive, isFalse);
      });
    });

    group('increment', () {
      test('should increment count by 1', () {
        counterService.increment();
        expect(counterService.count, equals(1));
      });

      test('should increment multiple times correctly', () {
        counterService.increment();
        counterService.increment();
        counterService.increment();
        expect(counterService.count, equals(3));
      });

      test('should make counter positive after increment', () {
        counterService.increment();
        expect(counterService.isPositive, isTrue);
        expect(counterService.isZero, isFalse);
      });
    });

    group('decrement', () {
      test('should decrement count by 1 when positive', () {
        counterService.increment();
        counterService.increment();
        final result = counterService.decrement();
        
        expect(result, isTrue);
        expect(counterService.count, equals(1));
      });

      test('should return false when trying to decrement from zero', () {
        final result = counterService.decrement();
        
        expect(result, isFalse);
        expect(counterService.count, equals(0));
      });

      test('should not go below zero', () {
        counterService.increment();
        counterService.decrement();
        final result = counterService.decrement();
        
        expect(result, isFalse);
        expect(counterService.count, equals(0));
      });

      test('should become zero after decrementing from 1', () {
        counterService.increment();
        counterService.decrement();
        
        expect(counterService.isZero, isTrue);
        expect(counterService.isPositive, isFalse);
      });
    });

    group('reset', () {
      test('should reset count to 0', () {
        counterService.increment();
        counterService.increment();
        counterService.increment();
        
        counterService.reset();
        
        expect(counterService.count, equals(0));
        expect(counterService.isZero, isTrue);
        expect(counterService.isPositive, isFalse);
      });

      test('should work when already at zero', () {
        counterService.reset();
        
        expect(counterService.count, equals(0));
        expect(counterService.isZero, isTrue);
      });
    });

    group('setValue', () {
      test('should set count to specified positive value', () {
        counterService.setValue(5);
        
        expect(counterService.count, equals(5));
        expect(counterService.isPositive, isTrue);
        expect(counterService.isZero, isFalse);
      });

      test('should set count to zero', () {
        counterService.increment();
        counterService.setValue(0);
        
        expect(counterService.count, equals(0));
        expect(counterService.isZero, isTrue);
        expect(counterService.isPositive, isFalse);
      });

      test('should throw ArgumentError for negative values', () {
        expect(
          () => counterService.setValue(-1),
          throwsA(isA<ArgumentError>()),
        );
        
        expect(
          () => counterService.setValue(-10),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('should not change count when ArgumentError is thrown', () {
        counterService.increment();
        final originalCount = counterService.count;
        
        expect(
          () => counterService.setValue(-1),
          throwsA(isA<ArgumentError>()),
        );
        
        expect(counterService.count, equals(originalCount));
      });
    });

    group('Complex scenarios', () {
      test('should handle multiple operations correctly', () {
        // Start at 0
        expect(counterService.count, equals(0));
        
        // Increment to 3
        counterService.increment();
        counterService.increment();
        counterService.increment();
        expect(counterService.count, equals(3));
        
        // Decrement to 1
        counterService.decrement();
        counterService.decrement();
        expect(counterService.count, equals(1));
        
        // Set to 10
        counterService.setValue(10);
        expect(counterService.count, equals(10));
        
        // Reset to 0
        counterService.reset();
        expect(counterService.count, equals(0));
        
        // Try to decrement (should fail)
        final result = counterService.decrement();
        expect(result, isFalse);
        expect(counterService.count, equals(0));
      });

      test('should maintain consistency across all properties', () {
        counterService.increment();
        expect(counterService.count, equals(1));
        expect(counterService.isPositive, isTrue);
        expect(counterService.isZero, isFalse);
        
        counterService.decrement();
        expect(counterService.count, equals(0));
        expect(counterService.isPositive, isFalse);
        expect(counterService.isZero, isTrue);
      });
    });
  });
}

