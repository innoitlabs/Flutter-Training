/// Base exception class for the application
abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);
  
  @override
  String toString() => message;
}

/// Exception thrown when network operations fail
class NetworkException extends AppException {
  const NetworkException(super.message);
}

/// Exception thrown when data is not found
class NotFoundException extends AppException {
  const NotFoundException(super.message);
}

/// Exception thrown when validation fails
class ValidationException extends AppException {
  const ValidationException(super.message);
}

/// Exception thrown when an operation is not allowed
class UnauthorizedException extends AppException {
  const UnauthorizedException(super.message);
}

/// Exception thrown when there's a server error
class ServerException extends AppException {
  const ServerException(super.message);
}
