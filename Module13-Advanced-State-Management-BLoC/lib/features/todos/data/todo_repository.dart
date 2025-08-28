import '../../../core/result.dart';
import '../../../core/exceptions.dart';
import 'todo_model.dart';

/// Abstract repository for todo operations
/// This demonstrates the repository pattern for data access
abstract class TodoRepository {
  /// Get all todos
  Future<Result<List<Todo>>> getTodos();
  
  /// Add a new todo
  Future<Result<Todo>> addTodo(Todo todo);
  
  /// Update an existing todo
  Future<Result<Todo>> updateTodo(Todo todo);
  
  /// Delete a todo by id
  Future<Result<void>> deleteTodo(String id);
  
  /// Toggle todo completion status
  Future<Result<Todo>> toggleTodo(String id);
  
  /// Clear all completed todos
  Future<Result<void>> clearCompleted();
}

/// In-memory implementation of TodoRepository
/// This demonstrates a simple repository implementation for testing
class InMemoryTodoRepository implements TodoRepository {
  final List<Todo> _todos = [];
  
  // Simulate network delay
  static const Duration _delay = Duration(milliseconds: 300);

  @override
  Future<Result<List<Todo>>> getTodos() async {
    await Future.delayed(_delay);
    return Result.success(List.unmodifiable(_todos));
  }

  @override
  Future<Result<Todo>> addTodo(Todo todo) async {
    await Future.delayed(_delay);
    
    // Validate todo
    if (todo.title.trim().isEmpty) {
      return const Result.error(ValidationException('Todo title cannot be empty'));
    }
    
    // Check for duplicate titles
    if (_todos.any((t) => t.title.toLowerCase() == todo.title.toLowerCase())) {
      return const Result.error(ValidationException('Todo with this title already exists'));
    }
    
    _todos.add(todo);
    return Result.success(todo);
  }

  @override
  Future<Result<Todo>> updateTodo(Todo todo) async {
    await Future.delayed(_delay);
    
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index == -1) {
      return const Result.error(NotFoundException('Todo not found'));
    }
    
    // Validate todo
    if (todo.title.trim().isEmpty) {
      return const Result.error(ValidationException('Todo title cannot be empty'));
    }
    
    _todos[index] = todo;
    return Result.success(todo);
  }

  @override
  Future<Result<void>> deleteTodo(String id) async {
    await Future.delayed(_delay);
    
    final index = _todos.indexWhere((t) => t.id == id);
    if (index == -1) {
      return const Result.error(NotFoundException('Todo not found'));
    }
    
    _todos.removeAt(index);
    return const Result.success(null);
  }

  @override
  Future<Result<Todo>> toggleTodo(String id) async {
    await Future.delayed(_delay);
    
    final index = _todos.indexWhere((t) => t.id == id);
    if (index == -1) {
      return const Result.error(NotFoundException('Todo not found'));
    }
    
    final updatedTodo = _todos[index].toggleCompletion();
    _todos[index] = updatedTodo;
    return Result.success(updatedTodo);
  }
  
  /// Clear all completed todos
  Future<Result<void>> clearCompleted() async {
    await Future.delayed(_delay);
    _todos.removeWhere((todo) => todo.isCompleted);
    return const Result.success(null);
  }
}
