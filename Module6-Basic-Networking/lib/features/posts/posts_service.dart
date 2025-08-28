import 'dart:convert';
import '../core/network/api_result.dart';
import '../core/network/http_client.dart';
import '../core/cache/memory_cache.dart';
import 'post_model.dart';

/// Service for handling posts-related API operations
class PostsService {
  final AppHttpClient _httpClient = AppHttpClient();
  final MemoryCache _cache = MemoryCache();
  
  static const String _postsEndpoint = '/posts';
  static const String _cacheKey = 'posts_list';
  static const int _cacheTTL = 300; // 5 minutes
  
  /// Get all posts with caching
  Future<ApiResult<List<Post>>> getPosts({bool forceRefresh = false}) async {
    // Check cache first (unless force refresh)
    if (!forceRefresh) {
      final cachedPosts = _cache.get<List<Post>>(_cacheKey);
      if (cachedPosts != null) {
        return ApiSuccess(cachedPosts);
      }
    }
    
    // Make HTTP request
    final result = await _httpClient.get(_postsEndpoint);
    
    return result.when(
      success: (response) {
        try {
          // Parse JSON response
          final List<dynamic> jsonList = json.decode(response.body) as List<dynamic>;
          final posts = jsonList.map((json) => Post.fromJson(json as Map<String, dynamic>)).toList();
          
          // Cache the result
          _cache.set(_cacheKey, posts, ttlSeconds: _cacheTTL);
          
          return ApiSuccess(posts);
        } catch (e) {
          return ApiError(
            message: 'Failed to parse posts data: ${e.toString()}',
            exception: e is Exception ? e : Exception(e.toString()),
          );
        }
      },
      error: (message, statusCode, exception) => ApiError(
        message: message,
        statusCode: statusCode,
        exception: exception,
      ),
    );
  }
  
  /// Get a single post by ID
  Future<ApiResult<Post>> getPost(int id) async {
    final cacheKey = 'post_$id';
    
    // Check cache first
    final cachedPost = _cache.get<Post>(cacheKey);
    if (cachedPost != null) {
      return ApiSuccess(cachedPost);
    }
    
    // Make HTTP request
    final result = await _httpClient.get('$_postsEndpoint/$id');
    
    return result.when(
      success: (response) {
        try {
          // Parse JSON response
          final jsonMap = json.decode(response.body) as Map<String, dynamic>;
          final post = Post.fromJson(jsonMap);
          
          // Cache the result
          _cache.set(cacheKey, post, ttlSeconds: _cacheTTL);
          
          return ApiSuccess(post);
        } catch (e) {
          return ApiError(
            message: 'Failed to parse post data: ${e.toString()}',
            exception: e is Exception ? e : Exception(e.toString()),
          );
        }
      },
      error: (message, statusCode, exception) => ApiError(
        message: message,
        statusCode: statusCode,
        exception: exception,
      ),
    );
  }
  
  /// Create a new post
  Future<ApiResult<Post>> createPost(CreatePostRequest request) async {
    final result = await _httpClient.post(
      _postsEndpoint,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(request.toJson()),
    );
    
    return result.when(
      success: (response) {
        try {
          // Parse JSON response
          final jsonMap = json.decode(response.body) as Map<String, dynamic>;
          final post = Post.fromJson(jsonMap);
          
          // Invalidate posts list cache since we added a new post
          _cache.remove(_cacheKey);
          
          return ApiSuccess(post);
        } catch (e) {
          return ApiError(
            message: 'Failed to parse created post data: ${e.toString()}',
            exception: e is Exception ? e : Exception(e.toString()),
          );
        }
      },
      error: (message, statusCode, exception) => ApiError(
        message: message,
        statusCode: statusCode,
        exception: exception,
      ),
    );
  }
  
  /// Clear posts cache (useful for pull-to-refresh)
  void clearCache() {
    _cache.remove(_cacheKey);
  }
  
  /// Clear all cache
  void clearAllCache() {
    _cache.clear();
  }
}

/// Extension to handle ApiResult pattern matching
extension ApiResultWhen<T> on ApiResult<T> {
  R when<R>({
    required R Function(T data) success,
    required R Function(String message, int? statusCode, Exception? exception) error,
  }) {
    if (this is ApiSuccess<T>) {
      return success((this as ApiSuccess<T>).data);
    } else if (this is ApiError<T>) {
      final error = this as ApiError<T>;
      return error(error.message, error.statusCode, error.exception);
    } else {
      throw Exception('Unhandled ApiResult state');
    }
  }
}
