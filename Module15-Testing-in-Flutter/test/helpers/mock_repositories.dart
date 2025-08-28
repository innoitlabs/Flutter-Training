import 'package:mocktail/mocktail.dart';
import '../../lib/features/todos/data/todo_repository.dart';
import '../../lib/features/todos/data/todo_model.dart';
import '../../lib/features/auth/auth_service.dart';

/// Mock implementation of TodoRepository using mocktail
class MockTodoRepository extends Mock implements TodoRepository {}

/// Mock implementation of AuthService using mocktail
class MockAuthService extends Mock implements AuthService {}

/// Helper class to set up common mock behaviors
class MockHelpers {
  /// Sets up a mock todo repository with common test data
  static void setupMockTodoRepository(MockTodoRepository mock) {
    // Register fallback values for complex types
    registerFallbackValue(Todo(
      id: '1',
      title: 'Test Todo',
      createdAt: DateTime.now(),
    ));

    // Set up common mock responses
    when(() => mock.fetchTodos()).thenAnswer((_) async => [
      Todo(
        id: '1',
        title: 'Test Todo 1',
        isCompleted: false,
        createdAt: DateTime.now(),
      ),
      Todo(
        id: '2',
        title: 'Test Todo 2',
        isCompleted: true,
        createdAt: DateTime.now(),
      ),
    ]);

    when(() => mock.addTodo(any())).thenAnswer((invocation) async {
      final title = invocation.positionalArguments[0] as String;
      return Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        createdAt: DateTime.now(),
      );
    });

    when(() => mock.updateTodo(any())).thenAnswer((invocation) async {
      final todo = invocation.positionalArguments[0] as Todo;
      return todo;
    });

    when(() => mock.deleteTodo(any())).thenAnswer((_) async => true);

    when(() => mock.toggleTodo(any())).thenAnswer((invocation) async {
      final id = invocation.positionalArguments[0] as String;
      return Todo(
        id: '1',
        title: 'Test Todo',
        isCompleted: true,
        createdAt: DateTime.now(),
      );
    });
  }

  /// Sets up a mock auth service with common test behaviors
  static void setupMockAuthService(MockAuthService mock) {
    // Set up successful login
    when(() => mock.login('test@example.com', 'password123'))
        .thenAnswer((_) async => true);

    // Set up failed login
    when(() => mock.login('invalid@example.com', 'wrong'))
        .thenAnswer((_) async => false);

    // Set up empty credentials
    when(() => mock.login('', '')).thenAnswer((_) async => false);

    // Set up logout
    when(() => mock.logout()).thenAnswer((_) async {});

    // Set up isLoggedIn
    when(() => mock.isLoggedIn()).thenAnswer((_) async => false);
  }

  /// Creates a mock todo repository with error behavior
  static MockTodoRepository createErrorMockTodoRepository() {
    final mock = MockTodoRepository();
    when(() => mock.fetchTodos()).thenThrow(Exception('Network error'));
    when(() => mock.addTodo(any())).thenThrow(Exception('Add failed'));
    when(() => mock.updateTodo(any())).thenThrow(Exception('Update failed'));
    when(() => mock.deleteTodo(any())).thenThrow(Exception('Delete failed'));
    when(() => mock.toggleTodo(any())).thenThrow(Exception('Toggle failed'));
    return mock;
  }

  /// Creates a mock auth service with error behavior
  static MockAuthService createErrorMockAuthService() {
    final mock = MockAuthService();
    when(() => mock.login(any(), any())).thenThrow(Exception('Auth error'));
    when(() => mock.logout()).thenThrow(Exception('Logout error'));
    when(() => mock.isLoggedIn()).thenThrow(Exception('Check failed'));
    return mock;
  }
}
