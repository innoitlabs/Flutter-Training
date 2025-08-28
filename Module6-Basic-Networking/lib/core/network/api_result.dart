/// A sealed-like result type for handling API responses
/// This pattern ensures we always handle both success and error cases
sealed class ApiResult<T> {
  const ApiResult();
}

/// Success case with data
class ApiSuccess<T> extends ApiResult<T> {
  final T data;
  const ApiSuccess(this.data);
}

/// Error case with error details
class ApiError<T> extends ApiResult<T> {
  final String message;
  final int? statusCode;
  final Exception? exception;
  
  const ApiError({
    required this.message,
    this.statusCode,
    this.exception,
  });
  
  /// Create error from HTTP status code
  factory ApiError.fromStatusCode(int statusCode) {
    String message;
    switch (statusCode) {
      case 400:
        message = 'Bad request. Please check your input.';
        break;
      case 401:
        message = 'Authentication required. Please log in.';
        break;
      case 403:
        message = 'Access forbidden. You don\'t have permission.';
        break;
      case 404:
        message = 'Resource not found.';
        break;
      case 500:
        message = 'Server error. Please try again later.';
        break;
      case 502:
        message = 'Bad gateway. Server is temporarily unavailable.';
        break;
      case 503:
        message = 'Service unavailable. Please try again later.';
        break;
      default:
        message = 'An error occurred (Status: $statusCode)';
    }
    return ApiError(message: message, statusCode: statusCode);
  }
  
  /// Create error from exception
  factory ApiError.fromException(Exception exception) {
    String message;
    if (exception.toString().contains('SocketException')) {
      message = 'No internet connection. Please check your network.';
    } else if (exception.toString().contains('TimeoutException')) {
      message = 'Request timed out. Please try again.';
    } else {
      message = 'Network error: ${exception.toString()}';
    }
    return ApiError(message: message, exception: exception);
  }
}

/// Loading state
class ApiLoading<T> extends ApiResult<T> {
  const ApiLoading();
}

/// Extension methods for easier handling
extension ApiResultExtensions<T> on ApiResult<T> {
  /// Check if result is success
  bool get isSuccess => this is ApiSuccess<T>;
  
  /// Check if result is error
  bool get isError => this is ApiError<T>;
  
  /// Check if result is loading
  bool get isLoading => this is ApiLoading<T>;
  
  /// Get data if success, null otherwise
  T? get data => this is ApiSuccess<T> ? (this as ApiSuccess<T>).data : null;
  
  /// Get error message if error, null otherwise
  String? get errorMessage => this is ApiError<T> ? (this as ApiError<T>).message : null;
}
