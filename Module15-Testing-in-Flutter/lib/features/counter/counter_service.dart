/// Service class containing pure logic for counter operations.
/// This is perfect for unit testing as it has no dependencies.
class CounterService {
  int _count = 0;

  /// Current counter value
  int get count => _count;

  /// Increments the counter by 1
  void increment() {
    _count++;
  }

  /// Decrements the counter by 1
  /// Returns false if counter would go below 0, true otherwise
  bool decrement() {
    if (_count > 0) {
      _count--;
      return true;
    }
    return false;
  }

  /// Resets the counter to 0
  void reset() {
    _count = 0;
  }

  /// Sets the counter to a specific value
  /// Throws ArgumentError if value is negative
  void setValue(int value) {
    if (value < 0) {
      throw ArgumentError('Counter value cannot be negative');
    }
    _count = value;
  }

  /// Checks if the counter is at zero
  bool get isZero => _count == 0;

  /// Checks if the counter is positive
  bool get isPositive => _count > 0;
}

