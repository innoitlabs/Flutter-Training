import 'package:flutter/material.dart';

/// Material 3 theme configuration for the app
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  /// Seed color for generating the color scheme
  static const Color _seedColor = Color(0xFF6750A4); // Material 3 purple

  /// Light theme configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.light,
      ),
      // Typography
      textTheme: _buildTextTheme(Brightness.light),
      // Icon theme
      iconTheme: const IconThemeData(
        size: 24,
        color: Colors.grey,
      ),
      // Card theme
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
      ),
      // Chip theme
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  /// Dark theme configuration
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.dark,
      ),
      // Typography
      textTheme: _buildTextTheme(Brightness.dark),
      // Icon theme
      iconTheme: const IconThemeData(
        size: 24,
        color: Colors.grey,
      ),
      // Card theme
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
      ),
      // Chip theme
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  /// Builds text theme with appropriate contrast for light/dark modes
  static TextTheme _buildTextTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    
    return TextTheme(
      // Display styles for large headings
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : Colors.black87,
        letterSpacing: -0.5,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.white : Colors.black87,
        letterSpacing: -0.25,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.white : Colors.black87,
      ),
      
      // Headline styles for section titles
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.white : Colors.black87,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: isDark ? Colors.white : Colors.black87,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: isDark ? Colors.white70 : Colors.black54,
      ),
      
      // Body styles for content
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: isDark ? Colors.white70 : Colors.black87,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: isDark ? Colors.white70 : Colors.black87,
        height: 1.4,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: isDark ? Colors.white60 : Colors.black54,
        height: 1.3,
      ),
      
      // Label styles for buttons and chips
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: isDark ? Colors.white : Colors.black87,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: isDark ? Colors.white70 : Colors.black87,
        letterSpacing: 0.5,
      ),
    );
  }
}
