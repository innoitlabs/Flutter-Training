import 'todo_model.dart';

/// Abstract interface for todo data operations
/// This allows us to easily mock the repository in tests
abstract class TodoRepository {
  /// Fetches all todos
  Future<List<Todo>> fetchTodos();

  /// Adds a new todo
  Future<Todo> addTodo(String title);

  /// Updates an existing todo
  Future<Todo> updateTodo(Todo todo);

  /// Deletes a todo by id
  Future<bool> deleteTodo(String id);

  /// Toggles the completion status of a todo
  Future<Todo> toggleTodo(String id);
}

/// In-memory implementation of TodoRepository
/// Used in the actual app, can be easily replaced with a real implementation
class InMemoryTodoRepository implements TodoRepository {
  final List<Todo> _todos = [];
  int _nextId = 1;

  @override
  Future<List<Todo>> fetchTodos() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));
    return List.unmodifiable(_todos);
  }

  @override
  Future<Todo> addTodo(String title) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));
    
    final todo = Todo(
      id: _nextId.toString(),
      title: title,
      createdAt: DateTime.now(),
    );
    
    _todos.add(todo);
    _nextId++;
    
    return todo;
  }

  @override
  Future<Todo> updateTodo(Todo todo) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 150));
    
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index == -1) {
      throw Exception('Todo not found');
    }
    
    _todos[index] = todo;
    return todo;
  }

  @override
  Future<bool> deleteTodo(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));
    
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index == -1) {
      return false;
    }
    
    _todos.removeAt(index);
    return true;
  }

  @override
  Future<Todo> toggleTodo(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));
    
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index == -1) {
      throw Exception('Todo not found');
    }
    
    final todo = _todos[index];
    final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
    _todos[index] = updatedTodo;
    
    return updatedTodo;
  }
}

