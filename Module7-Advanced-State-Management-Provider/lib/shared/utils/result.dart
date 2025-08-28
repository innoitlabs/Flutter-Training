/// Result utility for handling async operations
/// Provides a clean way to handle success/error states
sealed class Result<T> {
  const Result();

  /// Create a success result
  const factory Result.success(T data) = Success<T>;

  /// Create an error result
  const factory Result.error(String message) = Error<T>;

  /// Check if this is a success result
  bool get isSuccess => this is Success<T>;

  /// Check if this is an error result
  bool get isError => this is Error<T>;

  /// Get the data if success, null otherwise
  T? get data => isSuccess ? (this as Success<T>).data : null;

  /// Get the error message if error, null otherwise
  String? get errorMessage => isError ? (this as Error<T>).message : null;

  /// Transform the data if success
  Result<R> map<R>(R Function(T) transform) {
    return switch (this) {
      Success(data: final d) => Result.success(transform(d)),
      Error(message: final m) => Result.error(m),
    };
  }

  /// Execute different functions based on result type
  R fold<R>({
    required R Function(T) onSuccess,
    required R Function(String) onError,
  }) {
    return switch (this) {
      Success(data: final d) => onSuccess(d),
      Error(message: final m) => onError(m),
    };
  }
}

/// Success result containing data
class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Success<T> && other.data == data;
  }

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() => 'Success($data)';
}

/// Error result containing error message
class Error<T> extends Result<T> {
  final String message;

  const Error(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Error<T> && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'Error($message)';
}
