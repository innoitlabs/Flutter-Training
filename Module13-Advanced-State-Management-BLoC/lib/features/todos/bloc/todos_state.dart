import 'package:equatable/equatable.dart';
import '../data/todo_model.dart';
import 'todos_event.dart';

/// Status of the todos operation
enum TodosStatus {
  initial,
  loading,
  success,
  failure,
}

/// State representing the todos list and its status
/// This demonstrates complex state management with status and filtered data
class TodosState extends Equatable {
  final TodosStatus status;
  final List<Todo> todos;
  final TodoFilter activeFilter;
  final String? errorMessage;

  const TodosState({
    this.status = TodosStatus.initial,
    this.todos = const [],
    this.activeFilter = TodoFilter.all,
    this.errorMessage,
  });

  /// Factory constructor for initial state
  const TodosState.initial() : this();

  /// Factory constructor for loading state
  const TodosState.loading() : this(status: TodosStatus.loading);

  /// Factory constructor for success state
  const TodosState.success({
    required List<Todo> todos,
    TodoFilter activeFilter = TodoFilter.all,
  }) : this(
          status: TodosStatus.success,
          todos: todos,
          activeFilter: activeFilter,
        );

  /// Factory constructor for failure state
  const TodosState.failure({
    required String errorMessage,
    List<Todo> todos = const [],
    TodoFilter activeFilter = TodoFilter.all,
  }) : this(
          status: TodosStatus.failure,
          todos: todos,
          activeFilter: activeFilter,
          errorMessage: errorMessage,
        );

  /// Get filtered todos based on active filter
  List<Todo> get filteredTodos {
    switch (activeFilter) {
      case TodoFilter.all:
        return todos;
      case TodoFilter.active:
        return todos.where((todo) => !todo.isCompleted).toList();
      case TodoFilter.completed:
        return todos.where((todo) => todo.isCompleted).toList();
    }
  }

  /// Get count of active todos
  int get activeCount => todos.where((todo) => !todo.isCompleted).length;

  /// Get count of completed todos
  int get completedCount => todos.where((todo) => todo.isCompleted).length;

  /// Get total count of todos
  int get totalCount => todos.length;

  /// Check if there are any completed todos
  bool get hasCompletedTodos => completedCount > 0;

  /// Creates a copy of this state with updated values
  TodosState copyWith({
    TodosStatus? status,
    List<Todo>? todos,
    TodoFilter? activeFilter,
    String? errorMessage,
  }) {
    return TodosState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      activeFilter: activeFilter ?? this.activeFilter,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, todos, activeFilter, errorMessage];

  @override
  String toString() => 'TodosState(status: $status, todos: ${todos.length}, activeFilter: $activeFilter, errorMessage: $errorMessage)';
}
