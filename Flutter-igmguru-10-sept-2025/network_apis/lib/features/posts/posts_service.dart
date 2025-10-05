import 'dart:convert';
import 'package:http/http.dart' as _httpClient;
import 'package:network_apis/memory_cache/memory_cache.dart';
import 'package:network_apis/network/api_result.dart';
import 'package:network_apis/network/http_client.dart';

import 'post_model.dart';

class PostsService{
  final AppHttpClient _httpClient = AppHttpClient();
  final MemoryCache _cache = MemoryCache();

  static const String _postsEndpoint = '/posts';
  static const String _cacheKey = 'posts_list';
  static const int _cacheTTL = 300; // 5 minutes

  Future<ApiResult<List<Post>>> getPosts({bool forceRefresh = false}) async {
    // Check cache first (uncless force refresh)
    if(!forceRefresh){
      final cachedPosts = _cache.get<List<Post>>(_cacheKey);
      if(cachedPosts != null){
        return ApiSuccess(cachedPosts);
      }
    }

    final result = await _httpClient.get(_postsEndpoint);

    return result.when(
      success: (response) {
        try{
          // Parse JSON response
          final List<dynamic> jsonList = json.decode(response.body) as List<dynamic>;
          final posts = jsonList.map((json) => Post.fromJson(json as Map<String, dynamic>)).toList();

          _cache.set(_cacheKey, posts, ttlSeconds: _cacheTTL);
          return ApiSuccess(posts);
        } catch (e){
          return ApiError(
              message: 'Failed to parse posts data: ${e.toString()}',
            exception: e is Exception ? e : Exception(e.toString())
          );
        }
      },
      error: (message, statusCode, exception) => ApiError(
          message: message,
        statusCode: statusCode,
        exception: exception
      ),
    );
  }

  //Get a single post by ID
  Future<ApiResult<Post>> getPost(int id) async {
    final cacheKey = 'post_$id';

    // check cache first
    final cachedPost = _cache.get<Post>(cacheKey);
    if(cachedPost != null){
      return ApiSuccess(cachedPost);
    }

    final result = await _httpClient.get('$_postsEndpoint/$id');

    return result.when(
      success: (response) {
        try{
          final jsonMap = json.decode(response.body) as Map<String, dynamic>;
          final post = Post.fromJson(jsonMap);

          // Cache the result
          _cache.set(cacheKey, post, ttlSeconds: _cacheTTL);

          return ApiSuccess(post);
        }catch(e){
          return ApiError(
            message: 'Failed to parse post data: ${e.toString()}',
            exception: e is Exception ? e : Exception(e.toString()),
          );
        }

      },
      error: (message, statusCode, exception) => ApiError(
          message: message,
        statusCode: statusCode,
        exception: exception
      ),
    );
  }

  void clearCache(){
    _cache.remove(_cacheKey);
  }

  void clearAllCache(){
    _cache.clear();
  }
}

extension ApiResultWhen<T> on ApiResult<T>{
  R when<R>({
    required R Function(T data) success,
    required R Function(String message, int? statusCode, Exception? exception) error
}){
    if(this is ApiSuccess<T>){
      return success((this as ApiSuccess<T>).data);
    }
    else if(this is ApiError<T>){
      final apiError = this as ApiError<T>;
      return error(apiError.message, apiError.statusCode, apiError.exception);
    } else {
      throw Exception('Unknown ApiResult type');
    }
  }
}