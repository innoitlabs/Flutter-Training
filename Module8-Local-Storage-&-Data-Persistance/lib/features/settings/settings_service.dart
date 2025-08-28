import 'package:shared_preferences/shared_preferences.dart';
import '../../core/cache/memory_cache.dart';
import '../../core/utils/result.dart';

/// Service for managing user settings using SharedPreferences
/// Implements caching for frequently accessed settings
class SettingsService {
  static const String _keyUsername = 'username';
  static const String _keyIsDarkMode = 'is_dark_mode';
  static const String _keyLaunchCount = 'launch_count';
  static const String _keyLastLaunchDate = 'last_launch_date';
  static const String _keyNotificationsEnabled = 'notifications_enabled';
  static const String _keyAutoSaveEnabled = 'auto_save_enabled';

  // Default values
  static const String _defaultUsername = '';
  static const bool _defaultIsDarkMode = false;
  static const int _defaultLaunchCount = 0;
  static const bool _defaultNotificationsEnabled = true;
  static const bool _defaultAutoSaveEnabled = true;

  // Cache for frequently accessed settings
  final MemoryCache<SharedPreferences> _prefsCache = MemoryCache<SharedPreferences>(
    ttl: const Duration(minutes: 5), // Cache for 5 minutes
  );

  /// Get SharedPreferences instance with caching
  Future<SharedPreferences> get _prefs async {
    if (_prefsCache.isValid && _prefsCache.value != null) {
      return _prefsCache.value!;
    }

    final prefs = await SharedPreferences.getInstance();
    _prefsCache.set(prefs);
    return prefs;
  }

  /// Get username setting
  Future<Result<String>> getUsername() async {
    try {
      final prefs = await _prefs;
      final username = prefs.getString(_keyUsername) ?? _defaultUsername;
      return Result.success(username);
    } catch (e) {
      return Result.error('Failed to get username: $e');
    }
  }

  /// Set username setting
  Future<Result<bool>> setUsername(String username) async {
    try {
      final prefs = await _prefs;
      final success = await prefs.setString(_keyUsername, username);
      
      if (success) {
        // Invalidate cache to ensure fresh data
        _prefsCache.invalidate();
      }
      
      return Result.success(success);
    } catch (e) {
      return Result.error('Failed to set username: $e');
    }
  }

  /// Get dark mode setting
  Future<Result<bool>> getIsDarkMode() async {
    try {
      final prefs = await _prefs;
      final isDarkMode = prefs.getBool(_keyIsDarkMode) ?? _defaultIsDarkMode;
      return Result.success(isDarkMode);
    } catch (e) {
      return Result.error('Failed to get dark mode setting: $e');
    }
  }

  /// Set dark mode setting
  Future<Result<bool>> setIsDarkMode(bool isDarkMode) async {
    try {
      final prefs = await _prefs;
      final success = await prefs.setBool(_keyIsDarkMode, isDarkMode);
      
      if (success) {
        // Invalidate cache to ensure fresh data
        _prefsCache.invalidate();
      }
      
      return Result.success(success);
    } catch (e) {
      return Result.error('Failed to set dark mode: $e');
    }
  }

  /// Get launch count
  Future<Result<int>> getLaunchCount() async {
    try {
      final prefs = await _prefs;
      final launchCount = prefs.getInt(_keyLaunchCount) ?? _defaultLaunchCount;
      return Result.success(launchCount);
    } catch (e) {
      return Result.error('Failed to get launch count: $e');
    }
  }

  /// Increment launch count
  Future<Result<int>> incrementLaunchCount() async {
    try {
      final currentCount = await getLaunchCount();
      if (!currentCount.isSuccess) {
        return Result.error(currentCount.errorMessage!);
      }

      final newCount = currentCount.data! + 1;
      final prefs = await _prefs;
      final success = await prefs.setInt(_keyLaunchCount, newCount);
      
      if (success) {
        // Invalidate cache to ensure fresh data
        _prefsCache.invalidate();
        return Result.success(newCount);
      } else {
        return Result.error('Failed to save launch count');
      }
    } catch (e) {
      return Result.error('Failed to increment launch count: $e');
    }
  }

  /// Get last launch date
  Future<Result<DateTime?>> getLastLaunchDate() async {
    try {
      final prefs = await _prefs;
      final timestamp = prefs.getInt(_keyLastLaunchDate);
      
      if (timestamp != null) {
        return Result.success(DateTime.fromMillisecondsSinceEpoch(timestamp));
      } else {
        return Result.success(null);
      }
    } catch (e) {
      return Result.error('Failed to get last launch date: $e');
    }
  }

  /// Set last launch date
  Future<Result<bool>> setLastLaunchDate(DateTime date) async {
    try {
      final prefs = await _prefs;
      final success = await prefs.setInt(_keyLastLaunchDate, date.millisecondsSinceEpoch);
      
      if (success) {
        // Invalidate cache to ensure fresh data
        _prefsCache.invalidate();
      }
      
      return Result.success(success);
    } catch (e) {
      return Result.error('Failed to set last launch date: $e');
    }
  }

  /// Get notifications enabled setting
  Future<Result<bool>> getNotificationsEnabled() async {
    try {
      final prefs = await _prefs;
      final enabled = prefs.getBool(_keyNotificationsEnabled) ?? _defaultNotificationsEnabled;
      return Result.success(enabled);
    } catch (e) {
      return Result.error('Failed to get notifications setting: $e');
    }
  }

  /// Set notifications enabled setting
  Future<Result<bool>> setNotificationsEnabled(bool enabled) async {
    try {
      final prefs = await _prefs;
      final success = await prefs.setBool(_keyNotificationsEnabled, enabled);
      
      if (success) {
        // Invalidate cache to ensure fresh data
        _prefsCache.invalidate();
      }
      
      return Result.success(success);
    } catch (e) {
      return Result.error('Failed to set notifications: $e');
    }
  }

  /// Get auto save enabled setting
  Future<Result<bool>> getAutoSaveEnabled() async {
    try {
      final prefs = await _prefs;
      final enabled = prefs.getBool(_keyAutoSaveEnabled) ?? _defaultAutoSaveEnabled;
      return Result.success(enabled);
    } catch (e) {
      return Result.error('Failed to get auto save setting: $e');
    }
  }

  /// Set auto save enabled setting
  Future<Result<bool>> setAutoSaveEnabled(bool enabled) async {
    try {
      final prefs = await _prefs;
      final success = await prefs.setBool(_keyAutoSaveEnabled, enabled);
      
      if (success) {
        // Invalidate cache to ensure fresh data
        _prefsCache.invalidate();
      }
      
      return Result.success(success);
    } catch (e) {
      return Result.error('Failed to set auto save: $e');
    }
  }

  /// Get all settings as a map
  Future<Result<Map<String, dynamic>>> getAllSettings() async {
    try {
      final username = await getUsername();
      final isDarkMode = await getIsDarkMode();
      final launchCount = await getLaunchCount();
      final lastLaunchDate = await getLastLaunchDate();
      final notificationsEnabled = await getNotificationsEnabled();
      final autoSaveEnabled = await getAutoSaveEnabled();

      if (!username.isSuccess || !isDarkMode.isSuccess || !launchCount.isSuccess ||
          !lastLaunchDate.isSuccess || !notificationsEnabled.isSuccess || !autoSaveEnabled.isSuccess) {
        return Result.error('Failed to get all settings');
      }

      return Result.success({
        'username': username.data,
        'isDarkMode': isDarkMode.data,
        'launchCount': launchCount.data,
        'lastLaunchDate': lastLaunchDate.data?.toIso8601String(),
        'notificationsEnabled': notificationsEnabled.data,
        'autoSaveEnabled': autoSaveEnabled.data,
      });
    } catch (e) {
      return Result.error('Failed to get all settings: $e');
    }
  }

  /// Reset all settings to defaults
  Future<Result<bool>> resetToDefaults() async {
    try {
      final prefs = await _prefs;
      
      final results = await Future.wait([
        prefs.setString(_keyUsername, _defaultUsername),
        prefs.setBool(_keyIsDarkMode, _defaultIsDarkMode),
        prefs.setInt(_keyLaunchCount, _defaultLaunchCount),
        prefs.remove(_keyLastLaunchDate),
        prefs.setBool(_keyNotificationsEnabled, _defaultNotificationsEnabled),
        prefs.setBool(_keyAutoSaveEnabled, _defaultAutoSaveEnabled),
      ]);

      final success = results.every((result) => result);
      
      if (success) {
        // Invalidate cache to ensure fresh data
        _prefsCache.invalidate();
      }
      
      return Result.success(success);
    } catch (e) {
      return Result.error('Failed to reset settings: $e');
    }
  }

  /// Clear the cache
  void clearCache() {
    _prefsCache.clear();
  }

  /// Get cache statistics
  Map<String, dynamic> getCacheStats() {
    return _prefsCache.stats;
  }
}
