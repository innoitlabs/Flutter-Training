import 'todo_model.dart';

// Abstract repository interface for dependency injection
// This allows us to easily swap implementations (real API, fake data, etc.)
abstract class TodoRepository {
  Future<List<TodoModel>> getAllTodos();
  Future<void> addTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
  Future<void> toggleTodo(String id);
}

// In-memory implementation of TodoRepository
// Used for development and testing
class InMemoryTodoRepository implements TodoRepository {
  final List<TodoModel> _todos = [];

  @override
  Future<List<TodoModel>> getAllTodos() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_todos);
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _todos.add(todo);
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _todos.removeWhere((todo) => todo.id == id);
  }

  @override
  Future<void> toggleTodo(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final todo = _todos[index];
      _todos[index] = todo.copyWith(done: !todo.done);
    }
  }
}

// Fake repository for testing
// Provides predictable data for unit tests
class FakeTodoRepository implements TodoRepository {
  final List<TodoModel> _todos = [
    const TodoModel(id: '1', title: 'Learn Riverpod', done: true),
    const TodoModel(id: '2', title: 'Build awesome app', done: false),
    const TodoModel(id: '3', title: 'Write tests', done: false),
  ];

  @override
  Future<List<TodoModel>> getAllTodos() async {
    return List.unmodifiable(_todos);
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    _todos.add(todo);
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    _todos.removeWhere((todo) => todo.id == id);
  }

  @override
  Future<void> toggleTodo(String id) async {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final todo = _todos[index];
      _todos[index] = todo.copyWith(done: !todo.done);
    }
  }
}
