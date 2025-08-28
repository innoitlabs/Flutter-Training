import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_hub/features/todos/ui/todos_page.dart';
import 'package:bloc_hub/features/todos/bloc/todos_bloc.dart';
import 'package:bloc_hub/features/todos/bloc/todos_state.dart';
import 'package:bloc_hub/features/todos/bloc/todo_stats_bloc.dart';
import 'package:bloc_hub/features/todos/data/todo_repository.dart';
import 'package:bloc_hub/features/todos/data/todo_model.dart';
import 'package:bloc_hub/features/todos/bloc/todos_event.dart';

/// Mock BLoCs for testing
class MockTodosBloc extends Mock implements TodosBloc {}
class MockTodoStatsBloc extends Mock implements TodoStatsBloc {}

/// Widget tests for TodosPage
/// This demonstrates UI testing with BLoC integration
void main() {
  group('TodosPage', () {
    late MockTodosBloc mockTodosBloc;
    late MockTodoStatsBloc mockTodoStatsBloc;

    setUp(() {
      mockTodosBloc = MockTodosBloc();
      mockTodoStatsBloc = MockTodoStatsBloc();
    });

    Widget createTestWidget() {
      return MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<TodosBloc>.value(value: mockTodosBloc),
            BlocProvider<TodoStatsBloc>.value(value: mockTodoStatsBloc),
          ],
          child: const TodosPage(),
        ),
      );
    }

    testWidgets('shows loading indicator when state is loading', (tester) async {
      when(() => mockTodosBloc.state).thenReturn(const TodosState.loading());
      when(() => mockTodoStatsBloc.state).thenReturn(const TodoStatsState.initial());

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading feed...'), findsNothing); // Different loading text
    });

    testWidgets('shows error message when state is failure', (tester) async {
      when(() => mockTodosBloc.state).thenReturn(
        const TodosState.failure(
          errorMessage: 'Failed to load todos',
          todos: [],
        ),
      );
      when(() => mockTodoStatsBloc.state).thenReturn(const TodoStatsState.initial());

      await tester.pumpWidget(createTestWidget());

      expect(find.text('Failed to load todos'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('shows empty state when no todos', (tester) async {
      when(() => mockTodosBloc.state).thenReturn(const TodosState.success(todos: []));
      when(() => mockTodoStatsBloc.state).thenReturn(const TodoStatsState.initial());

      await tester.pumpWidget(createTestWidget());

      expect(find.text('No todos yet'), findsOneWidget);
      expect(find.text('Add your first todo'), findsOneWidget);
    });

    testWidgets('shows todos list when todos exist', (tester) async {
      final todos = [
        Todo(
          id: '1',
          title: 'Test Todo 1',
          description: 'Description 1',
        ),
        Todo(
          id: '2',
          title: 'Test Todo 2',
          description: 'Description 2',
          isCompleted: true,
        ),
      ];

      when(() => mockTodosBloc.state).thenReturn(
        TodosState.success(todos: todos),
      );
      when(() => mockTodoStatsBloc.state).thenReturn(
        const TodoStatsState(
          totalTodos: 2,
          activeTodos: 1,
          completedTodos: 1,
          completionRate: 50.0,
          hasTodos: true,
          hasCompletedTodos: true,
        ),
      );

      await tester.pumpWidget(createTestWidget());

      expect(find.text('Test Todo 1'), findsOneWidget);
      expect(find.text('Test Todo 2'), findsOneWidget);
      expect(find.text('Description 1'), findsOneWidget);
      expect(find.text('Description 2'), findsOneWidget);
    });

    testWidgets('shows stats section when todos exist', (tester) async {
      final todos = [
        Todo(
          id: '1',
          title: 'Test Todo',
        ),
      ];

      when(() => mockTodosBloc.state).thenReturn(
        TodosState.success(todos: todos),
      );
      when(() => mockTodoStatsBloc.state).thenReturn(
        const TodoStatsState(
          totalTodos: 1,
          activeTodos: 1,
          completedTodos: 0,
          completionRate: 0.0,
          hasTodos: true,
          hasCompletedTodos: false,
        ),
      );

      await tester.pumpWidget(createTestWidget());

      expect(find.text('Progress'), findsOneWidget);
      expect(find.text('1'), findsNWidgets(3)); // Total, Active, Completed
      expect(find.text('0.0% Complete'), findsOneWidget);
    });

    testWidgets('shows filter tabs', (tester) async {
      when(() => mockTodosBloc.state).thenReturn(const TodosState.success(todos: []));
      when(() => mockTodoStatsBloc.state).thenReturn(const TodoStatsState.initial());

      await tester.pumpWidget(createTestWidget());

      expect(find.text('All'), findsOneWidget);
      expect(find.text('Active'), findsOneWidget);
      expect(find.text('Completed'), findsOneWidget);
    });

    testWidgets('shows clear completed button when completed todos exist', (tester) async {
      final todos = [
        Todo(
          id: '1',
          title: 'Completed Todo',
          isCompleted: true,
        ),
      ];

      when(() => mockTodosBloc.state).thenReturn(
        TodosState.success(todos: todos),
      );
      when(() => mockTodoStatsBloc.state).thenReturn(
        const TodoStatsState(
          totalTodos: 1,
          activeTodos: 0,
          completedTodos: 1,
          completionRate: 100.0,
          hasTodos: true,
          hasCompletedTodos: true,
        ),
      );

      await tester.pumpWidget(createTestWidget());

      expect(find.byIcon(Icons.clear_all), findsOneWidget);
    });

    testWidgets('does not show clear completed button when no completed todos', (tester) async {
      final todos = [
        Todo(
          id: '1',
          title: 'Active Todo',
          isCompleted: false,
        ),
      ];

      when(() => mockTodosBloc.state).thenReturn(
        TodosState.success(todos: todos),
      );
      when(() => mockTodoStatsBloc.state).thenReturn(
        const TodoStatsState(
          totalTodos: 1,
          activeTodos: 1,
          completedTodos: 0,
          completionRate: 0.0,
          hasTodos: true,
          hasCompletedTodos: false,
        ),
      );

      await tester.pumpWidget(createTestWidget());

      expect(find.byIcon(Icons.clear_all), findsNothing);
    });

    testWidgets('shows filtered todos based on active filter', (tester) async {
      final todos = [
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
      ];

      when(() => mockTodosBloc.state).thenReturn(
        TodosState.success(
          todos: todos,
          activeFilter: TodoFilter.active,
        ),
      );
      when(() => mockTodoStatsBloc.state).thenReturn(
        const TodoStatsState(
          totalTodos: 2,
          activeTodos: 1,
          completedTodos: 1,
          completionRate: 50.0,
          hasTodos: true,
          hasCompletedTodos: true,
        ),
      );

      await tester.pumpWidget(createTestWidget());

      expect(find.text('Active Todo'), findsOneWidget);
      expect(find.text('Completed Todo'), findsNothing);
    });

    testWidgets('shows floating action button', (tester) async {
      when(() => mockTodosBloc.state).thenReturn(const TodosState.success(todos: []));
      when(() => mockTodoStatsBloc.state).thenReturn(const TodoStatsState.initial());

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('dispatches load event on init', (tester) async {
      when(() => mockTodosBloc.state).thenReturn(const TodosState.success(todos: []));
      when(() => mockTodoStatsBloc.state).thenReturn(const TodoStatsState.initial());

      await tester.pumpWidget(createTestWidget());

      verify(() => mockTodosBloc.add(const TodosLoad())).called(1);
    });

    testWidgets('shows snackbar when error occurs', (tester) async {
      when(() => mockTodosBloc.state).thenReturn(
        const TodosState.failure(
          errorMessage: 'Test error',
          todos: [],
        ),
      );
      when(() => mockTodoStatsBloc.state).thenReturn(const TodoStatsState.initial());

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Test error'), findsOneWidget);
    });
  });
}
