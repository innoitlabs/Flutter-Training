import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../lib/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('TestLab App Integration Tests', () {
    testWidgets('Counter functionality works', (tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Verify we start on counter page (first tab) - check app bar title
      expect(find.descendant(
        of: find.byType(AppBar),
        matching: find.text('Counter'),
      ), findsOneWidget);
      expect(find.byKey(const Key('counter_value')), findsOneWidget);
      expect(find.text('0'), findsOneWidget);

      // Increment counter
      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pumpAndSettle();
      expect(find.text('1'), findsOneWidget);

      // Increment again
      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pumpAndSettle();
      expect(find.text('2'), findsOneWidget);

      // Decrement counter
      await tester.tap(find.byKey(const Key('decrement_button')));
      await tester.pumpAndSettle();
      expect(find.text('1'), findsOneWidget);

      // Decrement to zero
      await tester.tap(find.byKey(const Key('decrement_button')));
      await tester.pumpAndSettle();
      expect(find.text('0'), findsOneWidget);

      // Try to decrement below zero (should not work)
      await tester.tap(find.byKey(const Key('decrement_button')));
      await tester.pumpAndSettle();
      expect(find.text('0'), findsOneWidget);

      // Reset counter
      await tester.tap(find.byKey(const Key('reset_button')));
      await tester.pumpAndSettle();
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('Navigation between tabs works', (tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Verify we start on counter page (first tab) - check app bar title
      expect(find.descendant(
        of: find.byType(AppBar),
        matching: find.text('Counter'),
      ), findsOneWidget);

      // Navigate to todos tab
      final todosTab = find.byIcon(Icons.list_outlined);
      await tester.tap(todosTab);
      await tester.pumpAndSettle();
      expect(find.descendant(
        of: find.byType(AppBar),
        matching: find.text('Todos'),
      ), findsOneWidget);

      // Navigate to login tab
      final loginTab = find.byIcon(Icons.login_outlined);
      await tester.tap(loginTab);
      await tester.pumpAndSettle();
      expect(find.descendant(
        of: find.byType(AppBar),
        matching: find.text('Login'),
      ), findsOneWidget);

      // Navigate back to counter tab
      final counterTab = find.byIcon(Icons.add_circle_outline);
      await tester.tap(counterTab);
      await tester.pumpAndSettle();
      expect(find.descendant(
        of: find.byType(AppBar),
        matching: find.text('Counter'),
      ), findsOneWidget);
    });

    testWidgets('Login page form validation works', (tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Navigate to login page (third tab)
      final loginTab = find.byIcon(Icons.login_outlined);
      await tester.tap(loginTab);
      await tester.pumpAndSettle();

      // Verify we're on the login page
      expect(find.descendant(
        of: find.byType(AppBar),
        matching: find.text('Login'),
      ), findsOneWidget);
      expect(find.text('Welcome to TestLab'), findsOneWidget);

      // Try to login with empty fields
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pump();

      // Verify validation errors are shown
      expect(find.text('Please enter your email'), findsOneWidget);

      // Enter invalid email format
      await tester.tap(find.byKey(const Key('email_field')));
      await tester.enterText(
        find.byKey(const Key('email_field')),
        'invalid-email',
      );
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pump();

      expect(find.text('Please enter a valid email'), findsOneWidget);

      // Enter valid email but short password
      await tester.tap(find.byKey(const Key('email_field')));
      await tester.enterText(
        find.byKey(const Key('email_field')),
        'test@example.com',
      );
      await tester.tap(find.byKey(const Key('password_field')));
      await tester.enterText(
        find.byKey(const Key('password_field')),
        '123',
      );
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pump();

      expect(find.text('Password must be at least 6 characters'), findsOneWidget);
    });

    testWidgets('Todos page loads and shows input fields', (tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Navigate to todos tab
      final todosTab = find.byIcon(Icons.list_outlined);
      await tester.tap(todosTab);
      await tester.pumpAndSettle();

      // Verify todos page is displayed
      expect(find.descendant(
        of: find.byType(AppBar),
        matching: find.text('Todos'),
      ), findsOneWidget);

      // Verify the todos page has input fields
      expect(find.byKey(const Key('todo_input')), findsOneWidget);
      expect(find.byKey(const Key('add_todo_button')), findsOneWidget);

      // Wait for any loading to complete
      await tester.pumpAndSettle();

      // Verify we can see either the empty state or some todos
      expect(
        find.byKey(const Key('empty_state')).evaluate().isNotEmpty ||
        find.byType(Checkbox).evaluate().isNotEmpty,
        isTrue,
      );
    });
  });
}
