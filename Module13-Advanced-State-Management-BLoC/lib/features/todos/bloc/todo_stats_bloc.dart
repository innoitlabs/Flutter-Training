import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'todos_bloc.dart';
import 'todos_state.dart';

/// TodoStatsBloc demonstrates BLoC composition:
/// - Listens to another BLoC's stream
/// - Computes derived state from parent BLoC
/// - Maintains its own state based on parent state changes
class TodoStatsBloc extends Bloc<TodoStatsEvent, TodoStatsState> {
  final TodosBloc todosBloc;

  TodoStatsBloc({required this.todosBloc}) : super(const TodoStatsState.initial()) {
    // Listen to todos state changes
    todosBloc.stream.listen((todosState) {
      if (todosState.status == TodosStatus.success) {
        add(TodoStatsUpdated(todosState));
      }
    });

    // Register event handlers
    on<TodoStatsUpdated>(_onStatsUpdated);
  }

  /// Handles TodoStatsUpdated events
  /// This demonstrates how to compute derived state from parent BLoC
  void _onStatsUpdated(TodoStatsUpdated event, Emitter<TodoStatsState> emit) {
    final todosState = event.todosState;
    
    // Compute statistics from todos
    final totalTodos = todosState.totalCount;
    final completedTodos = todosState.completedCount;
    final activeTodos = todosState.activeCount;
    final completionRate = totalTodos > 0 ? (completedTodos / totalTodos) * 100 : 0.0;
    
    emit(TodoStatsState(
      totalTodos: totalTodos,
      completedTodos: completedTodos,
      activeTodos: activeTodos,
      completionRate: completionRate,
      hasTodos: totalTodos > 0,
      hasCompletedTodos: completedTodos > 0,
    ));
  }
}

/// Events for TodoStatsBloc
abstract class TodoStatsEvent extends Equatable {
  const TodoStatsEvent();

  @override
  List<Object?> get props => [];
}

/// Event when todos state is updated
class TodoStatsUpdated extends TodoStatsEvent {
  final TodosState todosState;

  const TodoStatsUpdated(this.todosState);

  @override
  List<Object?> get props => [todosState];
}

/// State for TodoStatsBloc
class TodoStatsState extends Equatable {
  final int totalTodos;
  final int completedTodos;
  final int activeTodos;
  final double completionRate;
  final bool hasTodos;
  final bool hasCompletedTodos;

  const TodoStatsState({
    this.totalTodos = 0,
    this.completedTodos = 0,
    this.activeTodos = 0,
    this.completionRate = 0.0,
    this.hasTodos = false,
    this.hasCompletedTodos = false,
  });

  /// Factory constructor for initial state
  const TodoStatsState.initial() : this();

  @override
  List<Object?> get props => [
        totalTodos,
        completedTodos,
        activeTodos,
        completionRate,
        hasTodos,
        hasCompletedTodos,
      ];

  @override
  String toString() => 'TodoStatsState(total: $totalTodos, completed: $completedTodos, active: $activeTodos, completionRate: ${completionRate.toStringAsFixed(1)}%)';
}
