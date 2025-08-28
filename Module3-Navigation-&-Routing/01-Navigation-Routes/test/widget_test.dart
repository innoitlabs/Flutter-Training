// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_navigation_module/main.dart';

void main() {
  testWidgets('Navigation module smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NavigationModuleApp());

    // Verify that the main page loads with navigation options
    expect(find.text('Flutter Navigation Module'), findsOneWidget);
    expect(find.text('Select a Navigation Example:'), findsOneWidget);
    expect(find.text('Basic Navigation'), findsOneWidget);
    expect(find.text('Named Routes'), findsOneWidget);
    expect(find.text('Data Passing'), findsOneWidget);
    expect(find.text('Complete Example'), findsOneWidget);
  });
}
