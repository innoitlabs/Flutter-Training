import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../lib/app/theme.dart';

/// Helper function to pump a widget with MaterialApp and theme
/// This ensures consistent theming and navigation context in tests
Future<void> pumpApp(
  WidgetTester tester,
  Widget widget, {
  ThemeData? theme,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: theme ?? AppTheme.lightTheme,
      home: widget,
    ),
  );
}

/// Helper function to pump a widget and wait for all animations to complete
/// Useful for testing async operations and animations
Future<void> pumpAppAndSettle(
  WidgetTester tester,
  Widget widget, {
  ThemeData? theme,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: theme ?? AppTheme.lightTheme,
      home: widget,
    ),
  );
  await tester.pumpAndSettle();
}

