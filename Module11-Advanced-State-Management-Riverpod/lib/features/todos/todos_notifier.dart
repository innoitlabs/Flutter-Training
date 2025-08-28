import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo_model.dart';
import 'todo_repository.dart';

// StateNotifier for managing todos state
// Handles all business logic for todo operations
class TodosNotifier extends StateNotifier<List<TodoModel>> {
  final TodoRepository _repository;

  TodosNotifier(this._repository) : super([]) {
    // Load todos when the notifier is created
    _loadTodos();
  }

  // Load all todos from the repository
  Future<void> _loadTodos() async {
    try {
      final todos = await _repository.getAllTodos();
      state = todos;
    } catch (e) {
      // In a real app, you might want to handle errors differently
      state = [];
    }
  }

  // Add a new todo
  Future<void> addTodo(String title) async {
    if (title.trim().isEmpty) return;

    final todo = TodoModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
    );

    try {
      await _repository.addTodo(todo);
      // Add to local state
      state = [...state, todo];
    } catch (e) {
      // Handle error - in a real app, you might show a snackbar
    }
  }

  // Toggle the done status of a todo
  Future<void> toggleTodo(String id) async {
    try {
      await _repository.toggleTodo(id);
      // Update local state
      state = state.map((todo) {
        if (todo.id == id) {
          return todo.copyWith(done: !todo.done);
        }
        return todo;
      }).toList();
    } catch (e) {
      // Handle error
    }
  }

  // Delete a todo
  Future<void> deleteTodo(String id) async {
    try {
      await _repository.deleteTodo(id);
      // Remove from local state
      state = state.where((todo) => todo.id != id).toList();
    } catch (e) {
      // Handle error
    }
  }

  // Update a todo
  Future<void> updateTodo(TodoModel todo) async {
    try {
      await _repository.updateTodo(todo);
      // Update local state
      state = state.map((t) {
        if (t.id == todo.id) {
          return todo;
        }
        return t;
      }).toList();
    } catch (e) {
      // Handle error
    }
  }

  // Clear all completed todos
  Future<void> clearCompleted() async {
    final completedTodos = state.where((todo) => todo.done).toList();
    
    for (final todo in completedTodos) {
      try {
        await _repository.deleteTodo(todo.id);
      } catch (e) {
        // Handle error
      }
    }
    
    // Remove completed todos from local state
    state = state.where((todo) => !todo.done).toList();
  }

  // Mark all todos as completed
  Future<void> markAllCompleted() async {
    final todosToUpdate = state.where((todo) => !todo.done).toList();
    
    for (final todo in todosToUpdate) {
      try {
        await _repository.updateTodo(todo.copyWith(done: true));
      } catch (e) {
        // Handle error
      }
    }
    
    // Update local state
    state = state.map((todo) => todo.copyWith(done: true)).toList();
  }

  // Mark all todos as active
  Future<void> markAllActive() async {
    final todosToUpdate = state.where((todo) => todo.done).toList();
    
    for (final todo in todosToUpdate) {
      try {
        await _repository.updateTodo(todo.copyWith(done: false));
      } catch (e) {
        // Handle error
      }
    }
    
    // Update local state
    state = state.map((todo) => todo.copyWith(done: false)).toList();
  }
}
