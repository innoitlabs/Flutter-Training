import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo_model.dart';
import 'todo_repository.dart';
import 'todos_notifier.dart';

// Provider for the repository - this is dependency injection
// We can easily override this in tests or for different environments
final todosRepoProvider = Provider<TodoRepository>((ref) {
  return InMemoryTodoRepository();
});

// StateNotifierProvider for managing todos state
// Uses the repository from the provider above
final todosNotifierProvider = StateNotifierProvider<TodosNotifier, List<TodoModel>>(
  (ref) {
    // Get the repository from the provider
    final repository = ref.watch(todosRepoProvider);
    return TodosNotifier(repository);
  },
);

// Derived provider for filtered todos
// This demonstrates how to create computed values based on other providers
final filteredTodosProvider = Provider<List<TodoModel>>((ref) {
  final todos = ref.watch(todosNotifierProvider);
  final filter = ref.watch(todoFilterProvider);
  
  switch (filter) {
    case TodoFilter.all:
      return todos;
    case TodoFilter.active:
      return todos.where((todo) => !todo.done).toList();
    case TodoFilter.completed:
      return todos.where((todo) => todo.done).toList();
  }
});

// Provider for the current filter
final todoFilterProvider = StateProvider<TodoFilter>((ref) => TodoFilter.all);

// Derived provider for statistics
final todoStatsProvider = Provider<TodoStats>((ref) {
  final todos = ref.watch(todosNotifierProvider);
  final total = todos.length;
  final completed = todos.where((todo) => todo.done).length;
  final active = total - completed;
  
  return TodoStats(
    total: total,
    completed: completed,
    active: active,
  );
});

// Enum for filter options
enum TodoFilter { all, active, completed }

// Data class for todo statistics
class TodoStats {
  final int total;
  final int completed;
  final int active;

  const TodoStats({
    required this.total,
    required this.completed,
    required this.active,
  });
}
