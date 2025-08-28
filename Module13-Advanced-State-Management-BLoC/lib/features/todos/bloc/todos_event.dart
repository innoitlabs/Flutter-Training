import 'package:equatable/equatable.dart';
import '../data/todo_model.dart';

/// Events that can be dispatched to the TodosBloc
/// This demonstrates complex event handling for CRUD operations
abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all todos
class TodosLoad extends TodosEvent {
  const TodosLoad();
}

/// Event to add a new todo
class TodoAdd extends TodosEvent {
  final String title;
  final String? description;

  const TodoAdd({
    required this.title,
    this.description,
  });

  @override
  List<Object?> get props => [title, description];
}

/// Event to update an existing todo
class TodoUpdate extends TodosEvent {
  final Todo todo;

  const TodoUpdate(this.todo);

  @override
  List<Object?> get props => [todo];
}

/// Event to delete a todo
class TodoDelete extends TodosEvent {
  final String id;

  const TodoDelete(this.id);

  @override
  List<Object?> get props => [id];
}

/// Event to toggle todo completion status
class TodoToggle extends TodosEvent {
  final String id;

  const TodoToggle(this.id);

  @override
  List<Object?> get props => [id];
}

/// Event to change the active filter
class TodosFilterChanged extends TodosEvent {
  final TodoFilter filter;

  const TodosFilterChanged(this.filter);

  @override
  List<Object?> get props => [filter];
}

/// Event to clear all completed todos
class TodosClearCompleted extends TodosEvent {
  const TodosClearCompleted();
}

/// Todo filter options
enum TodoFilter {
  all,
  active,
  completed,
}
