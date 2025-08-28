/// Generic in-memory cache with TTL (Time To Live) functionality
/// This provides fast access to frequently used data with automatic expiration
class MemoryCache<T> {
  T? _value;
  DateTime? _expiresAt;
  final Duration _ttl;

  /// Create a memory cache with specified TTL
  /// [ttl] - Time To Live duration for cached values
  MemoryCache({Duration? ttl}) : _ttl = ttl ?? const Duration(seconds: 10);

  /// Get the cached value if it exists and is still valid
  T? get value {
    if (isValid) {
      return _value;
    }
    // Clear expired cache
    _clear();
    return null;
  }

  /// Set a new value in the cache with TTL
  void set(T value) {
    _value = value;
    _expiresAt = DateTime.now().add(_ttl);
  }

  /// Check if the cache has a valid value
  bool get isValid {
    return _value != null && 
           _expiresAt != null && 
           DateTime.now().isBefore(_expiresAt!);
  }

  /// Check if the cache has any value (valid or expired)
  bool get hasValue => _value != null;

  /// Clear the cache
  void clear() {
    _clear();
  }

  /// Invalidate the cache (mark as expired)
  void invalidate() {
    _expiresAt = DateTime.now().subtract(const Duration(seconds: 1));
  }

  /// Get cache statistics
  Map<String, dynamic> get stats {
    return {
      'hasValue': hasValue,
      'isValid': isValid,
      'expiresAt': _expiresAt?.toIso8601String(),
      'ttl': _ttl.inSeconds,
      'remainingSeconds': _expiresAt != null 
          ? _expiresAt!.difference(DateTime.now()).inSeconds 
          : 0,
    };
  }

  /// Private method to clear cache
  void _clear() {
    _value = null;
    _expiresAt = null;
  }
}

/// Cache manager for multiple caches
class CacheManager {
  static final CacheManager _instance = CacheManager._internal();
  factory CacheManager() => _instance;
  CacheManager._internal();

  final Map<String, MemoryCache> _caches = {};

  /// Get or create a cache with the specified key
  MemoryCache<T> getCache<T>(String key, {Duration? ttl}) {
    if (!_caches.containsKey(key)) {
      _caches[key] = MemoryCache<T>(ttl: ttl);
    }
    return _caches[key] as MemoryCache<T>;
  }

  /// Clear a specific cache
  void clearCache(String key) {
    _caches[key]?.clear();
  }

  /// Clear all caches
  void clearAll() {
    for (final cache in _caches.values) {
      cache.clear();
    }
  }

  /// Get statistics for all caches
  Map<String, Map<String, dynamic>> getAllStats() {
    final stats = <String, Map<String, dynamic>>{};
    for (final entry in _caches.entries) {
      stats[entry.key] = entry.value.stats;
    }
    return stats;
  }

  /// Remove expired caches
  void cleanup() {
    final keysToRemove = <String>[];
    for (final entry in _caches.entries) {
      if (!entry.value.isValid && !entry.value.hasValue) {
        keysToRemove.add(entry.key);
      }
    }
    for (final key in keysToRemove) {
      _caches.remove(key);
    }
  }
}
