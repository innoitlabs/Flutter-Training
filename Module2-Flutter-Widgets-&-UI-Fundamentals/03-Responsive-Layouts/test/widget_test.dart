// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:responsive_layouts_demo/main.dart';

void main() {
  testWidgets('Responsive layouts demo smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ResponsiveLayoutsDemo());

    // Verify that our app title is displayed.
    expect(find.text('Responsive Layouts Demo'), findsOneWidget);
    
    // Verify that example cards are displayed.
    expect(find.text('MediaQuery Basics'), findsOneWidget);
    expect(find.text('LayoutBuilder'), findsOneWidget);
    expect(find.text('OrientationBuilder'), findsOneWidget);
  });
}
