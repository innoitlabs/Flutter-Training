import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode;
  
  ThemeProvider(this._themeMode);
  
  ThemeMode get themeMode => _themeMode;
  
  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }
  
  String get themeModeName {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }
  
  void setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    
    // Save theme preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', mode.index);
  }
  
  void toggleTheme() {
    switch (_themeMode) {
      case ThemeMode.light:
        setThemeMode(ThemeMode.dark);
        break;
      case ThemeMode.dark:
        setThemeMode(ThemeMode.system);
        break;
      case ThemeMode.system:
        setThemeMode(ThemeMode.light);
        break;
    }
  }
  
  void cycleTheme() {
    switch (_themeMode) {
      case ThemeMode.light:
        setThemeMode(ThemeMode.dark);
        break;
      case ThemeMode.dark:
        setThemeMode(ThemeMode.system);
        break;
      case ThemeMode.system:
        setThemeMode(ThemeMode.light);
        break;
    }
  }
}
