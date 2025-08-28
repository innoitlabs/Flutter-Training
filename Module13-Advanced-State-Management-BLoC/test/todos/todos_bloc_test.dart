import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_hub/features/todos/bloc/todos_bloc.dart';
import 'package:bloc_hub/features/todos/bloc/todos_event.dart';
import 'package:bloc_hub/features/todos/bloc/todos_state.dart';
import 'package:bloc_hub/features/todos/data/todo_repository.dart';
import 'package:bloc_hub/features/todos/data/todo_model.dart';
import 'package:bloc_hub/core/result.dart';
import 'package:bloc_hub/core/exceptions.dart';

/// Mock repository for testing
class MockTodoRepository extends Mock implements TodoRepository {}

/// Unit tests for TodosBloc
/// This demonstrates BLoC testing with repository integration
void main() {
  group('TodosBloc', () {
    late TodosBloc todosBloc;
    late MockTodoRepository mockRepository;

    setUp(() {
      mockRepository = MockTodoRepository();
      todosBloc = TodosBloc(repository: mockRepository);
    });

    tearDown(() {
      todosBloc.close();
    });

    test('initial state is correct', () {
      expect(todosBloc.state, const TodosState.initial());
      expect(todosBloc.state.status, TodosStatus.initial);
      expect(todosBloc.state.todos, isEmpty);
      expect(todosBloc.state.activeFilter, TodoFilter.all);
      expect(todosBloc.state.errorMessage, isNull);
    });

    group('TodosLoad', () {
      blocTest<TodosBloc, TodosState>(
        'emits [loading, success] when load succeeds',
        build: () {
          when(() => mockRepository.getTodos())
              .thenAnswer((_) async => Result.success([
                    Todo(
                      id: '1',
                      title: 'Test Todo',
                    ),
                  ]));
          return todosBloc;
        },
        act: (bloc) => bloc.add(const TodosLoad()),
        expect: () => [
          const TodosState.loading(),
          TodosState.success(
            todos: [
              Todo(
                id: '1',
                title: 'Test Todo',
              ),
            ],
          ),
        ],
      );

      blocTest<TodosBloc, TodosState>(
        'emits [loading, failure] when load fails',
        build: () {
          when(() => mockRepository.getTodos())
              .thenAnswer((_) async => const Result.error(
                    NetworkException('Network error'),
                  ));
          return todosBloc;
        },
        act: (bloc) => bloc.add(const TodosLoad()),
        expect: () => [
          const TodosState.loading(),
          const TodosState.failure(errorMessage: 'NetworkException: Network error'),
        ],
      );
    });

    group('TodoAdd', () {
      blocTest<TodosBloc, TodosState>(
        'emits success and reloads todos when add succeeds',
        build: () {
          when(() => mockRepository.addTodo(any()))
              .thenAnswer((_) async => Result.success(
                    Todo(
                      id: '1',
                      title: 'New Todo',
                    ),
                  ));
          when(() => mockRepository.getTodos())
              .thenAnswer((_) async => Result.success([
                    Todo(
                      id: '1',
                      title: 'New Todo',
                    ),
                  ]));
          return todosBloc;
        },
        act: (bloc) => bloc.add(const TodoAdd(title: 'New Todo')),
        expect: () => [
          const TodosState.loading(),
          TodosState.success(
            todos: [
              Todo(
                id: '1',
                title: 'New Todo',
              ),
            ],
          ),
        ],
      );

      blocTest<TodosBloc, TodosState>(
        'emits failure when add fails',
        build: () {
          when(() => mockRepository.addTodo(any()))
              .thenAnswer((_) async => const Result.error(
                    ValidationException('Title cannot be empty'),
                  ));
          return todosBloc;
        },
        act: (bloc) => bloc.add(const TodoAdd(title: '')),
        expect: () => [
          const TodosState.failure(
            errorMessage: 'ValidationException: Title cannot be empty',
          ),
        ],
      );
    });

    group('TodoToggle', () {
      blocTest<TodosBloc, TodosState>(
        'emits success and reloads todos when toggle succeeds',
        build: () {
          when(() => mockRepository.toggleTodo('1'))
              .thenAnswer((_) async => Result.success(
                    Todo(
                      id: '1',
                      title: 'Test Todo',
                      isCompleted: true,
                    ),
                  ));
          when(() => mockRepository.getTodos())
              .thenAnswer((_) async => Result.success([
                    Todo(
                      id: '1',
                      title: 'Test Todo',
                      isCompleted: true,
                    ),
                  ]));
          return todosBloc;
        },
        act: (bloc) => bloc.add(const TodoToggle('1')),
        expect: () => [
          const TodosState.loading(),
          TodosState.success(
            todos: [
              Todo(
                id: '1',
                title: 'Test Todo',
                isCompleted: true,
              ),
            ],
          ),
        ],
      );
    });

    group('TodoDelete', () {
      blocTest<TodosBloc, TodosState>(
        'emits success and reloads todos when delete succeeds',
        build: () {
          when(() => mockRepository.deleteTodo('1'))
              .thenAnswer((_) async => const Result.success(null));
          when(() => mockRepository.getTodos())
              .thenAnswer((_) async => const Result.success([]));
          return todosBloc;
        },
        act: (bloc) => bloc.add(const TodoDelete('1')),
        expect: () => [
          const TodosState.loading(),
          const TodosState.success(todos: []),
        ],
      );
    });

    group('TodosFilterChanged', () {
      blocTest<TodosBloc, TodosState>(
        'emits state with updated filter',
        build: () => todosBloc,
        act: (bloc) => bloc.add(const TodosFilterChanged(TodoFilter.active)),
        expect: () => [
          const TodosState(activeFilter: TodoFilter.active),
        ],
      );

      blocTest<TodosBloc, TodosState>(
        'emits state with completed filter',
        build: () => todosBloc,
        act: (bloc) => bloc.add(const TodosFilterChanged(TodoFilter.completed)),
        expect: () => [
          const TodosState(activeFilter: TodoFilter.completed),
        ],
      );
    });

    group('TodosClearCompleted', () {
      blocTest<TodosBloc, TodosState>(
        'emits success and reloads todos when clear completed succeeds',
        build: () {
          when(() => mockRepository.clearCompleted())
              .thenAnswer((_) async => const Result.success(null));
          when(() => mockRepository.getTodos())
              .thenAnswer((_) async => const Result.success([]));
          return todosBloc;
        },
        act: (bloc) => bloc.add(const TodosClearCompleted()),
        expect: () => [
          const TodosState.loading(),
          const TodosState.success(todos: []),
        ],
      );
    });

    group('State properties', () {
      test('filteredTodos returns correct items based on filter', () {
        final state = TodosState.success(
          todos: [
            Todo(
              id: '1',
              title: 'Active Todo',
              isCompleted: false,
            ),
            Todo(
              id: '2',
              title: 'Completed Todo',
              isCompleted: true,
            ),
          ],
          activeFilter: TodoFilter.all,
        );

        expect(state.filteredTodos.length, 2);
        expect(state.activeCount, 1);
        expect(state.completedCount, 1);
        expect(state.totalCount, 2);
        expect(state.hasCompletedTodos, true);
      });

      test('filteredTodos filters active todos correctly', () {
        final state = TodosState.success(
          todos: [
            Todo(
              id: '1',
              title: 'Active Todo',
              isCompleted: false,
            ),
            Todo(
              id: '2',
              title: 'Completed Todo',
              isCompleted: true,
            ),
          ],
          activeFilter: TodoFilter.active,
        );

        expect(state.filteredTodos.length, 1);
        expect(state.filteredTodos.first.title, 'Active Todo');
      });

      test('filteredTodos filters completed todos correctly', () {
        final state = TodosState.success(
          todos: [
            Todo(
              id: '1',
              title: 'Active Todo',
              isCompleted: false,
            ),
            Todo(
              id: '2',
              title: 'Completed Todo',
              isCompleted: true,
            ),
          ],
          activeFilter: TodoFilter.completed,
        );

        expect(state.filteredTodos.length, 1);
        expect(state.filteredTodos.first.title, 'Completed Todo');
      });
    });
  });
}
