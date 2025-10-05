import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_result.dart';

/// Shared HTTP client with timeout configuration
class AppHttpClient {
  static const Duration _timeout = Duration(seconds: 10);
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  
  // Singleton pattern for shared client
  static final AppHttpClient _instance = AppHttpClient._internal();
  factory AppHttpClient() => _instance;
  AppHttpClient._internal();
  
  /// Shared HTTP client instance
  final http.Client _client = http.Client();
  
  /// Get the base URL for API requests
  String get baseUrl => _baseUrl;
  
  /// Make a GET request with timeout and error handling
  Future<ApiResult<http.Response>> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      
      final response = await _client
          .get(uri, headers: headers)
          .timeout(_timeout);
      
      // Check if response is successful (2xx status codes)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiSuccess(response);
      } else {
        // Log error response for debugging
        _logErrorResponse(response);
        return ApiError.fromStatusCode(response.statusCode);
      }
    } on TimeoutException {
      return const ApiError(
        message: 'Request timed out. Please try again.',
        exception: TimeoutException('Request timed out'),
      );
    } on SocketException catch (e) {
      return ApiError.fromException(e);
    } on FormatException catch (e) {
      return ApiError(
        message: 'Invalid response format: ${e.message}',
        exception: e,
      );
    } catch (e) {
      return ApiError(
        message: 'Unexpected error: ${e.toString()}',
        exception: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
  
  /// Make a POST request with timeout and error handling
  Future<ApiResult<http.Response>> post(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      
      final response = await _client
          .post(uri, headers: headers, body: body)
          .timeout(_timeout);
      
      // Check if response is successful (2xx status codes)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiSuccess(response);
      } else {
        // Log error response for debugging
        _logErrorResponse(response);
        return ApiError.fromStatusCode(response.statusCode);
      }
    } on TimeoutException {
      return const ApiError(
        message: 'Request timed out. Please try again.',
        exception: TimeoutException('Request timed out'),
      );
    } on SocketException catch (e) {
      return ApiError.fromException(e);
    } on FormatException catch (e) {
      return ApiError(
        message: 'Invalid response format: ${e.message}',
        exception: e,
      );
    } catch (e) {
      return ApiError(
        message: 'Unexpected error: ${e.toString()}',
        exception: e is Exception ? e : Exception(e.toString()),
      );
    }
  }
  
  /// Log error responses for debugging (only in debug mode)
  void _logErrorResponse(http.Response response) {
    assert(() {
      print('HTTP Error ${response.statusCode}: ${response.body}');
      return true;
    }());
  }
  
  /// Dispose the HTTP client
  void dispose() {
    _client.close();
  }
}
