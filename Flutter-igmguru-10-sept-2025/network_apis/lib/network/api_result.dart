sealed class ApiResult<T>{
  const ApiResult();
}

//Success case with data
class ApiSuccess<T> extends ApiResult<T>{
  final T data;
  const ApiSuccess(this.data);
}

//Error case with error details
class ApiError<T> extends ApiResult<T>{
  final String message;
  final int? statusCode;
  final Exception? exception;


  const ApiError({
    required this.message,
    this.statusCode,
    this.exception,
  });

  factory ApiError.fromStatusCode(int statusCode){
    String message;
    switch(statusCode) {
      case 400:
         message = 'Bad Request. Please check your input';
        break;
      case 401:
        message = 'Authentication Required. Please login';
        break;
      case 403:
        message = 'Forbidden. You do not have permission to access this resource';
        break;
      case 404:
        message = 'Not Found. The requested resource was not found';
        break;
      case 500:
        message = 'Internal Server Error. Something went wrong on our end';
        break;
      default:
        message = 'Unknown Error. Please try again later';
    }
    return ApiError(message: message, statusCode: statusCode);

    }


    factory ApiError.fromException(Exception exception){
      String message;
      if (exception.toString().contains('SocketException')) {
        message = 'No internet connection. Please check your network';
      } else if(exception.toString().contains('TimeoutException')){
        message = 'Request timed out. Please try again later';
      }
      else {
        message = 'Network Error: ${exception.toString()}';
      }
      return ApiError(message: message, exception: exception);
    }

}

// Loading State
class ApiLoading<T> extends ApiResult<T>{
  const ApiLoading();
}

extension ApiResultExtensions<T> on ApiResult<T>{
  // check if result is success
  bool get isSuccess => this is ApiSuccess<T>;

  // check if result is error
  bool get isError => this is ApiError<T>;

  // check if result is loading
  bool get isLoading => this is ApiLoading<T>;

  T? get data => this is ApiSuccess<T> ? (this as ApiSuccess<T>).data : null;

  String? get errorMessage => this is ApiError<T> ? (this as ApiError<T>).message : null;

}