# Module 15 — Testing in Flutter (Dart 3.6.1)

## Learning Objectives

By the end of this module, you will be able to:

- **Write unit tests** for pure Dart logic with comprehensive coverage
- **Implement widget tests** for UI behavior and layout verification
- **Create integration tests** that drive the full app end-to-end
- **Set up a testing environment** with mocking/stubbing of external dependencies
- **Generate and interpret test coverage** reports
- **Apply testing best practices** for maintainable and reliable code

## Key Concepts

### Testing Pyramid

Flutter testing follows a pyramid approach:

1. **Unit Tests** (Base) - Fast, isolated tests for pure logic
2. **Widget Tests** (Middle) - UI component testing with mocked dependencies
3. **Integration Tests** (Top) - End-to-end app testing

### Test Types Overview

| Test Type | Scope | Speed | Dependencies | Use Case |
|-----------|-------|-------|--------------|----------|
| **Unit** | Single function/class | Very Fast | None | Business logic, calculations |
| **Widget** | UI components | Fast | Mocked | UI behavior, user interactions |
| **Integration** | Full app flow | Slow | Real/Stubbed | User journeys, navigation |

### Architecture for Testability

The app is structured to maximize testability:

- **Pure logic** in service classes (e.g., `CounterService`)
- **Abstract interfaces** for dependencies (e.g., `TodoRepository`)
- **Constructor injection** for easy mocking
- **Thin widgets** that delegate to services

## Project Setup

### Dependencies

The project uses the latest stable Flutter testing packages:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
  test: ^1.24.0
  mocktail: ^1.0.0
```

### Key Configuration

- **Dart SDK**: `>=3.6.1 <4.0.0` (null safety enabled)
- **Flutter**: `>=3.16.0` (Material 3 support)
- **Material 3**: Modern theming with `useMaterial3: true`

## Feature A — Counter (Unit Tests)

### CounterService

A pure logic service with no dependencies - perfect for unit testing:

```dart
class CounterService {
  int _count = 0;
  
  int get count => _count;
  bool get isZero => _count == 0;
  bool get isPositive => _count > 0;
  
  void increment() => _count++;
  bool decrement() => _count > 0 ? (_count--, true) : false;
  void reset() => _count = 0;
  void setValue(int value) {
    if (value < 0) throw ArgumentError('Counter value cannot be negative');
    _count = value;
  }
}
```

### Unit Test Examples

```dart
test('should increment count by 1', () {
  counterService.increment();
  expect(counterService.count, equals(1));
});

test('should throw ArgumentError for negative values', () {
  expect(
    () => counterService.setValue(-1),
    throwsA(isA<ArgumentError>()),
  );
});
```

**Key Testing Concepts:**
- `setUp()` - Initialize fresh instances for each test
- `group()` - Organize related tests
- `expect()` - Assert expected outcomes
- `throwsA()` - Test exception handling

## Feature B — Todos (Widget Tests + Mocks)

### Repository Pattern

Abstract interface for dependency injection:

```dart
abstract class TodoRepository {
  Future<List<Todo>> fetchTodos();
  Future<Todo> addTodo(String title);
  Future<Todo> toggleTodo(String id);
  Future<bool> deleteTodo(String id);
}
```

### Mocking with Mocktail

```dart
class MockTodoRepository extends Mock implements TodoRepository {}

// Setup mock behavior
when(() => mockRepository.fetchTodos()).thenAnswer((_) async => [
  const Todo(id: '1', title: 'Test Todo', createdAt: null),
]);

// Verify interactions
verify(() => mockRepository.addTodo('New Todo')).called(1);
```

### Widget Test Examples

```dart
testWidgets('should add todo when button is pressed', (tester) async {
  await pumpApp(tester, const TodosPage());
  await tester.pumpAndSettle();

  await tester.enterText(
    find.byKey(const Key('todo_input')),
    'New Test Todo',
  );
  await tester.tap(find.byKey(const Key('add_todo_button')));
  await tester.pumpAndSettle();

  verify(() => mockRepository.addTodo('New Test Todo')).called(1);
});
```

**Key Widget Testing Concepts:**
- `pumpApp()` - Wraps widget with MaterialApp and theme
- `pumpAndSettle()` - Waits for all animations to complete
- `find.byKey()` - Locate widgets reliably using keys
- `tester.tap()` / `tester.enterText()` - Simulate user interactions

## Feature C — Login (Integration Test)

### AuthService

Fake authentication with simulated network delays:

```dart
class AuthService {
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final isValidEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    final isValidPassword = password.length >= 6;
    
    return isValidEmail && isValidPassword;
  }
}
```

### Integration Test Example

```dart
testWidgets('Complete login and todo workflow', (tester) async {
  app.main();
  await tester.pumpAndSettle();

  // Login flow
  await tester.enterText(find.byKey(const Key('email_field')), 'test@example.com');
  await tester.enterText(find.byKey(const Key('password_field')), 'password123');
  await tester.tap(find.byKey(const Key('login_button')));
  await tester.pumpAndSettle();

  // Verify navigation
  expect(find.text('Todos'), findsOneWidget);
  expect(find.text('Welcome to TestLab'), findsNothing);

  // Todo operations
  await tester.enterText(find.byKey(const Key('todo_input')), 'Integration Test Todo');
  await tester.tap(find.byKey(const Key('add_todo_button')));
  await tester.pumpAndSettle();

  expect(find.text('Integration Test Todo'), findsOneWidget);
});
```

## Mocking & Stubbing

### Mocktail Setup

```dart
// Register fallback values for complex types
registerFallbackValue(const Todo(
  id: '1',
  title: 'Test Todo',
  createdAt: null,
));

// Setup mock responses
when(() => mockRepository.fetchTodos()).thenAnswer((_) async => [
  const Todo(id: '1', title: 'Test Todo 1', isCompleted: false),
  const Todo(id: '2', title: 'Test Todo 2', isCompleted: true),
]);

// Setup error scenarios
when(() => mockRepository.fetchTodos()).thenThrow(Exception('Network error'));
```

### Mock Helpers

```dart
class MockHelpers {
  static void setupMockTodoRepository(MockTodoRepository mock) {
    when(() => mock.fetchTodos()).thenAnswer((_) async => [
      // Test data
    ]);
  }
  
  static MockTodoRepository createErrorMockTodoRepository() {
    final mock = MockTodoRepository();
    when(() => mock.fetchTodos()).thenThrow(Exception('Network error'));
    return mock;
  }
}
```

## Test Coverage

### Generate Coverage

```bash
# Run tests with coverage
flutter test --coverage

# Generate HTML report (requires lcov)
genhtml coverage/lcov.info -o coverage/html

# View in browser
open coverage/html/index.html
```

### Coverage Interpretation

- **Line Coverage**: Percentage of code lines executed
- **Branch Coverage**: Percentage of conditional branches tested
- **Function Coverage**: Percentage of functions called

**Best Practice**: Focus on **risk-based coverage** rather than chasing 100%. Test critical business logic and error paths thoroughly.

## Running the Tests

### Prerequisites

1. **Flutter SDK**: Ensure you have Flutter 3.16.0+ installed
2. **Dart SDK**: Version 3.6.1+ (null safety)
3. **iOS Simulator**: For integration tests

### Setup Commands

```bash
# Get dependencies
flutter pub get

# Verify Flutter installation
flutter doctor
```

### Test Commands

```bash
# Run all unit and widget tests
flutter test

# Run only unit tests
flutter test test/unit/

# Run only widget tests
flutter test test/widget/

# Run integration tests
flutter test integration_test/

# Run tests with coverage
flutter test --coverage
```

### iOS Simulator Setup

```bash
# Open iOS Simulator
open -a Simulator

# List available devices
flutter devices

# Run app on iOS Simulator
flutter run -d ios

# Run integration tests on iOS Simulator
flutter test integration_test/ -d ios
```

## App Features

### TestLab App Structure

The app demonstrates three main features:

1. **Counter** - Pure logic with unit tests
2. **Todos** - UI with mocked repository
3. **Login** - Authentication flow with integration tests

### Navigation

- **Bottom Navigation Bar** - Switch between features
- **Material 3 Design** - Modern UI with Material You theming
- **Responsive Layout** - Works on different screen sizes

### Demo Credentials

For testing the login feature:
- **Email**: `test@example.com`
- **Password**: `password123`

## Best Practices

### Test Organization

1. **Arrange-Act-Assert** pattern
2. **Meaningful test names** that describe behavior
3. **Group related tests** using `group()`
4. **Keep tests independent** - no shared state

### Widget Testing

1. **Use Keys** for reliable widget finding
2. **Mock external dependencies** (network, storage)
3. **Test user interactions** (tap, enter text, scroll)
4. **Verify UI state changes** after interactions

### Integration Testing

1. **Test complete user journeys**
2. **Use realistic test data**
3. **Handle async operations** with `pumpAndSettle()`
4. **Test error scenarios** and edge cases

### Code Quality

1. **Separate logic from UI** for easier testing
2. **Use dependency injection** for testability
3. **Write pure functions** when possible
4. **Avoid testing implementation details**

## Exercises

### Easy: Logout Flow

Add a logout button to the TodosPage and write a widget test that verifies navigation back to LoginPage.

**Hint**: Use `Navigator.of(context).pushReplacement()` for navigation.

### Intermediate: Todo Filtering

Add a filter to show only active/completed todos and test the UI changes.

**Hint**: Add filter buttons and test that the correct todos are displayed.

### Advanced: Persistence

Add local storage (SharedPreferences or SQLite) and mock it in tests. Expand integration tests to cover add/edit/delete operations.

**Hint**: Create a `StorageService` interface and mock implementation.

## Troubleshooting

### Common Issues

1. **Tests failing on CI/CD**: Ensure consistent test environment
2. **Flaky tests**: Use `pumpAndSettle()` for async operations
3. **Mock not working**: Check `registerFallbackValue()` for complex types
4. **Integration test timeouts**: Increase timeout or optimize app performance

### Debug Tips

1. **Use `debugPrint()`** in tests for debugging
2. **Check widget tree** with `tester.dumpWidgetTree()`
3. **Verify mock setup** with `verify()` calls
4. **Test one thing at a time** for easier debugging

## Conclusion

This module provides a comprehensive foundation for Flutter testing. You've learned:

- **Unit testing** pure Dart logic
- **Widget testing** with mocked dependencies
- **Integration testing** for end-to-end scenarios
- **Mocking and stubbing** with Mocktail
- **Test coverage** generation and interpretation
- **Best practices** for maintainable tests

The TestLab app demonstrates real-world testing scenarios and provides a solid foundation for testing your own Flutter applications.

Remember: **Good tests are an investment in code quality and developer productivity**. Start with critical functionality and build your test suite incrementally.

