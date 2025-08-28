import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../lib/features/auth/login_page.dart';
import '../../lib/features/auth/auth_service.dart';
import '../helpers/pump_app.dart';
import '../helpers/mock_repositories.dart';

void main() {
  group('LoginPage Widget Tests', () {
    late MockAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockAuthService();
    });

    tearDown(() {
      reset(mockAuthService);
    });

    group('Initial state', () {
      testWidgets('should display login form elements', (tester) async {
        await pumpApp(tester, LoginPage(authService: mockAuthService));

        expect(find.byKey(const Key('email_field')), findsOneWidget);
        expect(find.byKey(const Key('password_field')), findsOneWidget);
        expect(find.byKey(const Key('login_button')), findsOneWidget);
        expect(find.text('Welcome to TestLab'), findsOneWidget);
        expect(find.text('Demo Credentials:'), findsOneWidget);
      });

      testWidgets('should show demo credentials', (tester) async {
        await pumpApp(tester, LoginPage(authService: mockAuthService));

        expect(find.text('Email: test@example.com'), findsOneWidget);
        expect(find.text('Password: password123'), findsOneWidget);
      });
    });

    group('Form validation', () {
      testWidgets('should show error for empty email', (tester) async {
        await pumpApp(tester, LoginPage(authService: mockAuthService));

        // Try to submit with empty email
        await tester.tap(find.byKey(const Key('login_button')));
        await tester.pump();

        expect(find.text('Please enter your email'), findsOneWidget);
      });

      testWidgets('should show error for invalid email format', (tester) async {
        await pumpApp(tester, LoginPage(authService: mockAuthService));

        // Enter invalid email
        await tester.enterText(
          find.byKey(const Key('email_field')),
          'invalid-email',
        );
        await tester.tap(find.byKey(const Key('login_button')));
        await tester.pump();

        expect(find.text('Please enter a valid email'), findsOneWidget);
      });

      testWidgets('should show error for empty password', (tester) async {
        await pumpApp(tester, LoginPage(authService: mockAuthService));

        // Enter valid email but empty password
        await tester.enterText(
          find.byKey(const Key('email_field')),
          'test@example.com',
        );
        await tester.tap(find.byKey(const Key('login_button')));
        await tester.pump();

        expect(find.text('Please enter your password'), findsOneWidget);
      });

      testWidgets('should show error for short password', (tester) async {
        await pumpApp(tester, LoginPage(authService: mockAuthService));

        // Enter valid email but short password
        await tester.enterText(
          find.byKey(const Key('email_field')),
          'test@example.com',
        );
        await tester.enterText(
          find.byKey(const Key('password_field')),
          '123',
        );
        await tester.tap(find.byKey(const Key('login_button')));
        await tester.pump();

        expect(find.text('Password must be at least 6 characters'), findsOneWidget);
      });

      testWidgets('should not show errors for valid credentials', (tester) async {
        await pumpApp(tester, LoginPage(authService: mockAuthService));

        // Enter valid credentials
        await tester.enterText(
          find.byKey(const Key('email_field')),
          'test@example.com',
        );
        await tester.enterText(
          find.byKey(const Key('password_field')),
          'password123',
        );
        await tester.tap(find.byKey(const Key('login_button')));
        await tester.pumpAndSettle();

        // Should not show validation errors
        expect(find.text('Please enter your email'), findsNothing);
        expect(find.text('Please enter a valid email'), findsNothing);
        expect(find.text('Please enter your password'), findsNothing);
        expect(find.text('Password must be at least 6 characters'), findsNothing);
      });
    });

    group('Login functionality', () {
      testWidgets('should call auth service with correct credentials', (tester) async {
        // Set up successful login
        when(() => mockAuthService.login('test@example.com', 'password123'))
            .thenAnswer((_) async => true);
            
        await pumpApp(tester, LoginPage(authService: mockAuthService));

        // Enter valid credentials
        await tester.enterText(
          find.byKey(const Key('email_field')),
          'test@example.com',
        );
        await tester.enterText(
          find.byKey(const Key('password_field')),
          'password123',
        );
        await tester.tap(find.byKey(const Key('login_button')));
        await tester.pumpAndSettle();

        // Verify auth service was called with correct parameters
        verify(() => mockAuthService.login('test@example.com', 'password123'))
            .called(1);
      });

      testWidgets('should show loading indicator during login', (tester) async {
        // Set up a slow login operation
        when(() => mockAuthService.login('test@example.com', 'password123')).thenAnswer(
          (_) async {
            await Future.delayed(const Duration(milliseconds: 100));
            return true;
          },
        );

        await pumpApp(tester, LoginPage(authService: mockAuthService));

        // Enter credentials and start login
        await tester.enterText(
          find.byKey(const Key('email_field')),
          'test@example.com',
        );
        await tester.enterText(
          find.byKey(const Key('password_field')),
          'password123',
        );
        await tester.tap(find.byKey(const Key('login_button')));
        await tester.pump();

        // Should show loading indicator
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        
        // Button should be disabled
        final loginButton = tester.widget<ElevatedButton>(
          find.byKey(const Key('login_button')),
        );
        expect(loginButton.onPressed, isNull);
        
        // Wait for the operation to complete
        await tester.pumpAndSettle();
      });

      testWidgets('should disable form fields during login', (tester) async {
        // Set up a slow login operation
        when(() => mockAuthService.login('test@example.com', 'password123')).thenAnswer(
          (_) async {
            await Future.delayed(const Duration(milliseconds: 100));
            return true;
          },
        );

        await pumpApp(tester, LoginPage(authService: mockAuthService));

        // Enter credentials and start login
        await tester.enterText(
          find.byKey(const Key('email_field')),
          'test@example.com',
        );
        await tester.enterText(
          find.byKey(const Key('password_field')),
          'password123',
        );
        await tester.tap(find.byKey(const Key('login_button')));
        await tester.pump();

        // Form fields should be disabled
        final emailField = tester.widget<TextFormField>(
          find.byKey(const Key('email_field')),
        );
        final passwordField = tester.widget<TextFormField>(
          find.byKey(const Key('password_field')),
        );
        
        expect(emailField.enabled, isFalse);
        expect(passwordField.enabled, isFalse);
        
        // Wait for the operation to complete
        await tester.pumpAndSettle();
      });
    });

    group('Error handling', () {
      testWidgets('should show error message for invalid credentials', (tester) async {
        // Set up failed login for any credentials
        when(() => mockAuthService.login(any(), any()))
            .thenAnswer((_) async => false);

        await pumpApp(tester, LoginPage(authService: mockAuthService));

        // Enter invalid credentials
        await tester.enterText(
          find.byKey(const Key('email_field')),
          'invalid@example.com',
        );
        await tester.enterText(
          find.byKey(const Key('password_field')),
          'wrongpassword',
        );
        
        // Check if form validation passes
        await tester.tap(find.byKey(const Key('login_button')));
        await tester.pump();
        
        // Check if there are any validation errors
        expect(find.text('Please enter your email'), findsNothing);
        expect(find.text('Please enter a valid email'), findsNothing);
        expect(find.text('Please enter your password'), findsNothing);
        expect(find.text('Password must be at least 6 characters'), findsNothing);
        
        await tester.pumpAndSettle();

        // Verify the mock was called
        verify(() => mockAuthService.login('invalid@example.com', 'wrongpassword')).called(1);

        expect(find.byKey(const Key('error_message')), findsOneWidget);
        expect(find.text('Invalid email or password'), findsOneWidget);
      });

      testWidgets('should show error message for auth service exception', (tester) async {
        // Set up auth service to throw exception
        when(() => mockAuthService.login(any(), any()))
            .thenThrow(Exception('Network error'));

        await pumpApp(tester, LoginPage(authService: mockAuthService));

        // Enter valid credentials
        await tester.enterText(
          find.byKey(const Key('email_field')),
          'test@example.com',
        );
        await tester.enterText(
          find.byKey(const Key('password_field')),
          'password123',
        );
        await tester.tap(find.byKey(const Key('login_button')));
        await tester.pumpAndSettle();

        expect(find.byKey(const Key('error_message')), findsOneWidget);
        expect(find.textContaining('Network error'), findsOneWidget);
      });

      testWidgets('should clear error message on new login attempt', (tester) async {
        // Set up failed login first for any credentials
        when(() => mockAuthService.login(any(), any()))
            .thenAnswer((_) async => false);

        await pumpApp(tester, LoginPage(authService: mockAuthService));

        // First login attempt - should fail
        await tester.enterText(
          find.byKey(const Key('email_field')),
          'invalid@example.com',
        );
        await tester.enterText(
          find.byKey(const Key('password_field')),
          'wrongpassword',
        );
        await tester.tap(find.byKey(const Key('login_button')));
        await tester.pumpAndSettle();

        expect(find.byKey(const Key('error_message')), findsOneWidget);

        // Change mock to return true for valid credentials
        when(() => mockAuthService.login('test@example.com', 'password123'))
            .thenAnswer((_) async => true);

        // Clear fields and try again with valid credentials
        await tester.enterText(
          find.byKey(const Key('email_field')),
          'test@example.com',
        );
        await tester.enterText(
          find.byKey(const Key('password_field')),
          'password123',
        );
        await tester.tap(find.byKey(const Key('login_button')));
        await tester.pumpAndSettle();

        // Error message should be cleared
        expect(find.byKey(const Key('error_message')), findsNothing);
      });
    });

    group('Navigation', () {
      testWidgets('should navigate to TodosPage on successful login', (tester) async {
        // Set up successful login
        when(() => mockAuthService.login('test@example.com', 'password123'))
            .thenAnswer((_) async => true);
            
        await pumpApp(tester, LoginPage(authService: mockAuthService));

        // Enter valid credentials
        await tester.enterText(
          find.byKey(const Key('email_field')),
          'test@example.com',
        );
        await tester.enterText(
          find.byKey(const Key('password_field')),
          'password123',
        );
        await tester.tap(find.byKey(const Key('login_button')));
        await tester.pumpAndSettle();

        // Should navigate to TodosPage
        expect(find.text('Todos'), findsOneWidget);
        expect(find.text('Welcome to TestLab'), findsNothing);
      });
    });

    group('UI elements', () {
      testWidgets('should display form with correct styling', (tester) async {
        await pumpApp(tester, LoginPage(authService: mockAuthService));

        // Check that form elements are present
        expect(find.byType(TextFormField), findsNWidgets(2));
        expect(find.byType(ElevatedButton), findsOneWidget);
        expect(find.byIcon(Icons.lock_outline), findsOneWidget);
        expect(find.byIcon(Icons.email), findsOneWidget);
        expect(find.byIcon(Icons.lock), findsOneWidget);
      });

      testWidgets('should show password field as obscured', (tester) async {
        await pumpApp(tester, LoginPage(authService: mockAuthService));

        expect(find.byKey(const Key('password_field')), findsOneWidget);
      });

      testWidgets('should show email field with email keyboard type', (tester) async {
        await pumpApp(tester, LoginPage(authService: mockAuthService));

        expect(find.byKey(const Key('email_field')), findsOneWidget);
      });
    });
  });
}
