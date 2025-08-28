import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/todo_repository.dart';
import '../data/todo_model.dart';
import 'todos_event.dart';
import 'todos_state.dart';

/// TodosBloc demonstrates complex BLoC patterns:
/// - Repository integration for data operations
/// - Async event handling with proper error management
/// - State transitions with loading/success/failure states
/// - Business logic for filtering and data manipulation
class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoRepository repository;

  TodosBloc({required this.repository}) : super(const TodosState.initial()) {
    // Register event handlers
    on<TodosLoad>(_onLoad);
    on<TodoAdd>(_onAdd);
    on<TodoUpdate>(_onUpdate);
    on<TodoDelete>(_onDelete);
    on<TodoToggle>(_onToggle);
    on<TodosFilterChanged>(_onFilterChanged);
    on<TodosClearCompleted>(_onClearCompleted);
  }

  /// Handles TodosLoad events
  /// This demonstrates async event handling with repository
  Future<void> _onLoad(TodosLoad event, Emitter<TodosState> emit) async {
    emit(const TodosState.loading());
    
    try {
      final result = await repository.getTodos();
      
      if (result.isSuccess) {
        emit(TodosState.success(todos: result.data));
      } else {
        emit(TodosState.failure(errorMessage: result.exception.toString()));
      }
    } catch (e) {
      emit(TodosState.failure(errorMessage: e.toString()));
    }
  }

  /// Handles TodoAdd events
  /// This demonstrates async event handling with validation
  Future<void> _onAdd(TodoAdd event, Emitter<TodosState> emit) async {
    // Create new todo
    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: event.title.trim(),
      description: event.description?.trim(),
      createdAt: DateTime.now(),
    );

    try {
      final result = await repository.addTodo(todo);
      
      if (result.isSuccess) {
        // Reload todos to get updated list
        add(const TodosLoad());
      } else {
        emit(state.copyWith(
          status: TodosStatus.failure,
          errorMessage: result.exception.toString(),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: TodosStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Handles TodoUpdate events
  Future<void> _onUpdate(TodoUpdate event, Emitter<TodosState> emit) async {
    try {
      final result = await repository.updateTodo(event.todo);
      
      if (result.isSuccess) {
        // Reload todos to get updated list
        add(const TodosLoad());
      } else {
        emit(state.copyWith(
          status: TodosStatus.failure,
          errorMessage: result.exception.toString(),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: TodosStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Handles TodoDelete events
  Future<void> _onDelete(TodoDelete event, Emitter<TodosState> emit) async {
    try {
      final result = await repository.deleteTodo(event.id);
      
      if (result.isSuccess) {
        // Reload todos to get updated list
        add(const TodosLoad());
      } else {
        emit(state.copyWith(
          status: TodosStatus.failure,
          errorMessage: result.exception.toString(),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: TodosStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Handles TodoToggle events
  Future<void> _onToggle(TodoToggle event, Emitter<TodosState> emit) async {
    try {
      final result = await repository.toggleTodo(event.id);
      
      if (result.isSuccess) {
        // Reload todos to get updated list
        add(const TodosLoad());
      } else {
        emit(state.copyWith(
          status: TodosStatus.failure,
          errorMessage: result.exception.toString(),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: TodosStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Handles TodosFilterChanged events
  /// This demonstrates synchronous event handling for UI state
  void _onFilterChanged(TodosFilterChanged event, Emitter<TodosState> emit) {
    emit(state.copyWith(activeFilter: event.filter));
  }

  /// Handles TodosClearCompleted events
  Future<void> _onClearCompleted(TodosClearCompleted event, Emitter<TodosState> emit) async {
    try {
      final result = await repository.clearCompleted();
      
      if (result.isSuccess) {
        // Reload todos to get updated list
        add(const TodosLoad());
      } else {
        emit(state.copyWith(
          status: TodosStatus.failure,
          errorMessage: result.exception.toString(),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: TodosStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
