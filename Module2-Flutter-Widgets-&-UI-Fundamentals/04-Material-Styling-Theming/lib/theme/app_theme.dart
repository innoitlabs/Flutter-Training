import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      
      // Color Scheme
      primarySwatch: Colors.blue,
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.background,
        error: AppColors.error,
        onPrimary: AppColors.onPrimary,
        onSecondary: AppColors.onSecondary,
        onSurface: AppColors.onBackground,
        onError: AppColors.onError,
      ),
      
      // Scaffold
      scaffoldBackgroundColor: AppColors.background,
      
      // Text Themes
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.onBackground,
          fontFamily: 'Poppins',
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.onBackground,
          fontFamily: 'Poppins',
        ),
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.onBackground,
          fontFamily: 'Poppins',
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.onBackground,
          fontFamily: 'Poppins',
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: AppColors.onBackground,
          fontFamily: 'Roboto',
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: AppColors.onBackground,
          fontFamily: 'Roboto',
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.onBackground,
          fontFamily: 'Roboto',
        ),
      ),
      
      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.onPrimary,
          fontFamily: 'Poppins',
        ),
      ),
      
      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      
      // Card Theme
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: AppColors.surface,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        labelStyle: const TextStyle(
          color: AppColors.onSurface,
          fontFamily: 'Roboto',
        ),
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 6,
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.onSurface,
        size: 24,
      ),
    );
  }
  
  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      
      // Color Scheme
      primarySwatch: Colors.blue,
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.darkBackground,
        error: AppColors.error,
        onPrimary: AppColors.onPrimary,
        onSecondary: AppColors.onSecondary,
        onSurface: AppColors.darkOnBackground,
        onError: AppColors.onError,
      ),
      
      // Scaffold
      scaffoldBackgroundColor: AppColors.darkBackground,
      
      // Text Themes
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.darkOnBackground,
          fontFamily: 'Poppins',
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.darkOnBackground,
          fontFamily: 'Poppins',
        ),
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.darkOnBackground,
          fontFamily: 'Poppins',
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.darkOnBackground,
          fontFamily: 'Poppins',
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: AppColors.darkOnBackground,
          fontFamily: 'Roboto',
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: AppColors.darkOnBackground,
          fontFamily: 'Roboto',
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.darkOnBackground,
          fontFamily: 'Roboto',
        ),
      ),
      
      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkSurface,
        foregroundColor: AppColors.darkOnSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.darkOnSurface,
          fontFamily: 'Poppins',
        ),
      ),
      
      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      
      // Card Theme
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: AppColors.darkSurface,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.darkOutline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.darkOutline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        labelStyle: const TextStyle(
          color: AppColors.darkOnSurface,
          fontFamily: 'Roboto',
        ),
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 6,
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.darkOnSurface,
        size: 24,
      ),
    );
  }
}
