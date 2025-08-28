/// A sealed-like class for handling success and error results
/// This provides type-safe error handling throughout the app
sealed class Result<T> {
  const Result();

  /// Create a success result with data
  const factory Result.success(T data) = Success<T>;

  /// Create an error result with error message
  const factory Result.error(String message) = Error<T>;

  /// Check if the result is successful
  bool get isSuccess => this is Success<T>;

  /// Check if the result is an error
  bool get isError => this is Error<T>;

  /// Get the data if successful, null otherwise
  T? get data => isSuccess ? (this as Success<T>).data : null;

  /// Get the error message if error, null otherwise
  String? get errorMessage => isError ? (this as Error<T>).message : null;

  /// Transform the data if successful
  Result<R> map<R>(R Function(T data) transform) {
    return switch (this) {
      Success(data: final data) => Result.success(transform(data)),
      Error(message: final message) => Result.error(message),
    };
  }

  /// Handle both success and error cases
  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(String message) onError,
  }) {
    return switch (this) {
      Success(data: final data) => onSuccess(data),
      Error(message: final message) => onError(message),
    };
  }
}

/// Success result with data
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

/// Error result with message
class Error<T> extends Result<T> {
  final String message;
  const Error(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Error<T> &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'Error($message)';
}
