// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_state_management_learning/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app loads with the correct title.
    expect(find.text('Flutter State Management Learning'), findsOneWidget);
    
    // Verify that learning objectives are displayed.
    expect(find.text('Learning Objectives:'), findsOneWidget);
    
    // Verify that examples section exists.
    expect(find.text('Examples:'), findsOneWidget);
    
    // Verify that at least one example is visible.
    expect(find.text('1. Widget Comparison'), findsOneWidget);
  });

  testWidgets('Navigation works', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap on the first example (Widget Comparison).
    await tester.tap(find.text('1. Widget Comparison'));
    await tester.pumpAndSettle();

    // Verify that we navigated to the widget comparison screen.
    expect(find.text('Widget Comparison'), findsOneWidget);
    expect(find.text('StatelessWidget vs StatefulWidget'), findsOneWidget);
  });
}
