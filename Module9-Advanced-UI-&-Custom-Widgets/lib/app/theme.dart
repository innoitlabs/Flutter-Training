import 'package:flutter/material.dart';

/// Custom theme extension for brand colors
/// Demonstrates extending ThemeData with custom properties
class BrandColors extends ThemeExtension<BrandColors> {
  const BrandColors({
    required this.primary,
    required this.secondary,
    required this.accent,
  });

  final Color primary;
  final Color secondary;
  final Color accent;

  /// Light theme brand colors
  static const light = BrandColors(
    primary: Color(0xFF6750A4),
    secondary: Color(0xFF625B71),
    accent: Color(0xFF7D5260),
  );

  /// Dark theme brand colors
  static const dark = BrandColors(
    primary: Color(0xFFD0BCFF),
    secondary: Color(0xFFCCC2DC),
    accent: Color(0xFFEFB8C8),
  );

  @override
  BrandColors copyWith({
    Color? primary,
    Color? secondary,
    Color? accent,
  }) {
    return BrandColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      accent: accent ?? this.accent,
    );
  }

  @override
  BrandColors lerp(ThemeExtension<BrandColors>? other, double t) {
    if (other is! BrandColors) {
      return this;
    }
    return BrandColors(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
    );
  }
}

/// Application theme configuration
/// Demonstrates Material 3 theming with custom extensions
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6750A4),
        brightness: Brightness.light,
      ),
      extensions: const [BrandColors.light],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFD0BCFF),
        brightness: Brightness.dark,
      ),
      extensions: const [BrandColors.dark],
    );
  }
}
