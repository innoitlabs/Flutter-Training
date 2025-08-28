// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_forms_validation_module/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FormsValidationApp());

    // Verify that the app title is displayed.
    expect(find.text('Flutter Forms & Validation'), findsOneWidget);
    
    // Verify that the module title is displayed.
    expect(find.text('Module 5: Forms & Validation'), findsOneWidget);
    
    // Verify that the learning objectives are displayed.
    expect(find.text('Learning Objectives'), findsOneWidget);
    expect(find.text('Runnable Examples'), findsOneWidget);
  });
}
