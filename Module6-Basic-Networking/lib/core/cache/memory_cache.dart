/// Simple in-memory cache entry with TTL support
class CacheEntry<T> {
  final T data;
  final DateTime expiresAt;
  
  const CacheEntry({
    required this.data,
    required this.expiresAt,
  });
  
  /// Check if the cache entry is still valid
  bool get isValid => DateTime.now().isBefore(expiresAt);
  
  /// Create a cache entry with TTL in seconds
  factory CacheEntry.withTTL(T data, int ttlSeconds) {
    return CacheEntry(
      data: data,
      expiresAt: DateTime.now().add(Duration(seconds: ttlSeconds)),
    );
  }
}

/// Simple in-memory cache implementation
class MemoryCache {
  static final MemoryCache _instance = MemoryCache._internal();
  factory MemoryCache() => _instance;
  MemoryCache._internal();
  
  final Map<String, CacheEntry> _cache = {};
  
  /// Store data in cache with TTL
  void set<T>(String key, T data, {int ttlSeconds = 300}) {
    _cache[key] = CacheEntry.withTTL(data, ttlSeconds);
  }
  
  /// Get data from cache if valid
  T? get<T>(String key) {
    final entry = _cache[key];
    if (entry == null || !entry.isValid) {
      // Remove expired entry
      if (entry != null) {
        _cache.remove(key);
      }
      return null;
    }
    return entry.data as T;
  }
  
  /// Check if key exists and is valid
  bool has(String key) {
    final entry = _cache[key];
    if (entry == null || !entry.isValid) {
      if (entry != null) {
        _cache.remove(key);
      }
      return false;
    }
    return true;
  }
  
  /// Remove specific key from cache
  void remove(String key) {
    _cache.remove(key);
  }
  
  /// Clear all cache entries
  void clear() {
    _cache.clear();
  }
  
  /// Get cache size (including expired entries)
  int get size => _cache.length;
  
  /// Clean up expired entries
  void cleanup() {
    final keysToRemove = <String>[];
    for (final entry in _cache.entries) {
      if (!entry.value.isValid) {
        keysToRemove.add(entry.key);
      }
    }
    for (final key in keysToRemove) {
      _cache.remove(key);
    }
  }
}
