/// A simple Result type for handling success and error cases
/// This is a common pattern in BLoC applications for repository layer results
sealed class Result<T> {
  const Result();
  
  /// Creates a success result with data
  const factory Result.success(T data) = Success<T>;
  
  /// Creates an error result with exception
  const factory Result.error(Exception exception) = Error<T>;
  
  /// Returns true if this is a success result
  bool get isSuccess => this is Success<T>;
  
  /// Returns true if this is an error result
  bool get isError => this is Error<T>;
  
  /// Gets the data if this is a success result, otherwise throws
  T get data {
    if (this is Success<T>) {
      return (this as Success<T>).data;
    }
    throw StateError('Cannot get data from error result');
  }
  
  /// Gets the exception if this is an error result, otherwise throws
  Exception get exception {
    if (this is Error<T>) {
      return (this as Error<T>).exception;
    }
    throw StateError('Cannot get exception from success result');
  }
}

/// Success result containing data
class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success<T> &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
  
  @override
  String toString() => 'Success($data)';
}

/// Error result containing exception
class Error<T> extends Result<T> {
  final Exception exception;
  const Error(this.exception);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Error<T> &&
          runtimeType == other.runtimeType &&
          exception == other.exception;

  @override
  int get hashCode => exception.hashCode;
  
  @override
  String toString() => 'Error($exception)';
}
