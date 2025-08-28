import 'package:flutter/foundation.dart';

/// Settings model that manages app-wide preferences
/// Extends ChangeNotifier to notify widgets when state changes
class SettingsModel extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  String _language = 'en';

  /// Get current dark mode setting
  bool get isDarkMode => _isDarkMode;

  /// Get current notifications setting
  bool get notificationsEnabled => _notificationsEnabled;

  /// Get current language setting
  String get language => _language;

  /// Toggle dark mode setting
  /// Calls notifyListeners() to trigger UI rebuilds
  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // Notify all listening widgets to rebuild
  }

  /// Set dark mode setting
  void setDarkMode(bool value) {
    if (_isDarkMode != value) {
      _isDarkMode = value;
      notifyListeners();
    }
  }

  /// Toggle notifications setting
  void toggleNotifications() {
    _notificationsEnabled = !_notificationsEnabled;
    notifyListeners();
  }

  /// Set notifications setting
  void setNotificationsEnabled(bool value) {
    if (_notificationsEnabled != value) {
      _notificationsEnabled = value;
      notifyListeners();
    }
  }

  /// Set language setting
  void setLanguage(String language) {
    if (_language != language) {
      _language = language;
      notifyListeners();
    }
  }

  /// Reset all settings to defaults
  void resetToDefaults() {
    _isDarkMode = false;
    _notificationsEnabled = true;
    _language = 'en';
    notifyListeners();
  }
}
