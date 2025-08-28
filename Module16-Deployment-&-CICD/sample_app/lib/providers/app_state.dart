import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _isFirstLaunch = true;
  String _currentVersion = '1.0.0';
  int _buildNumber = 1;

  // Getters
  bool get isDarkMode => _isDarkMode;
  bool get isFirstLaunch => _isFirstLaunch;
  String get currentVersion => _currentVersion;
  int get buildNumber => _buildNumber;

  AppState() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    _currentVersion = prefs.getString('currentVersion') ?? '1.0.0';
    _buildNumber = prefs.getInt('buildNumber') ?? 1;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  Future<void> setFirstLaunchComplete() async {
    _isFirstLaunch = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false);
    notifyListeners();
  }

  Future<void> updateVersion(String version, int buildNumber) async {
    _currentVersion = version;
    _buildNumber = buildNumber;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentVersion', version);
    await prefs.setInt('buildNumber', buildNumber);
    notifyListeners();
  }

  // Method to simulate app update for testing
  Future<void> simulateAppUpdate() async {
    final newBuildNumber = _buildNumber + 1;
    final newVersion = '1.0.${newBuildNumber}';
    await updateVersion(newVersion, newBuildNumber);
  }

  // Method to reset app data (for testing purposes)
  Future<void> resetAppData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _isDarkMode = false;
    _isFirstLaunch = true;
    _currentVersion = '1.0.0';
    _buildNumber = 1;
    notifyListeners();
  }
}
