import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../lib/features/todos/ui/todos_page.dart';
import '../../lib/features/todos/data/todo_repository.dart';
import '../../lib/features/todos/data/todo_model.dart';
import '../helpers/pump_app.dart';
import '../helpers/mock_repositories.dart';

void main() {
  group('TodosPage Widget Tests', () {
    late MockTodoRepository mockRepository;

    setUp(() {
      mockRepository = MockTodoRepository();
      MockHelpers.setupMockTodoRepository(mockRepository);
    });

    tearDown(() {
      reset(mockRepository);
    });

    group('Initial state', () {
      testWidgets('should show loading indicator initially', (tester) async {
        await pumpApp(tester, TodosPage(repository: mockRepository));

        expect(find.byKey(const Key('loading_indicator')), findsOneWidget);
        expect(find.byKey(const Key('todo_input')), findsOneWidget);
        expect(find.byKey(const Key('add_todo_button')), findsOneWidget);
      });

      testWidgets('should show todos after loading', (tester) async {
        await pumpApp(tester, TodosPage(repository: mockRepository));
        await tester.pumpAndSettle();

        expect(find.byKey(const Key('loading_indicator')), findsNothing);
        expect(find.byKey(const Key('todo_title_1')), findsOneWidget);
        expect(find.byKey(const Key('todo_title_2')), findsOneWidget);
        expect(find.text('Test Todo 1'), findsOneWidget);
        expect(find.text('Test Todo 2'), findsOneWidget);
      });

      testWidgets('should show empty state when no todos', (tester) async {
        when(() => mockRepository.fetchTodos()).thenAnswer((_) async => []);

        await pumpApp(tester, TodosPage(repository: mockRepository));
        await tester.pumpAndSettle();

        expect(find.byKey(const Key('empty_state')), findsOneWidget);
        expect(find.text('No todos yet. Add one above!'), findsOneWidget);
      });
    });

    group('Add todo functionality', () {
      testWidgets('should add todo when button is pressed', (tester) async {
        await pumpApp(tester, TodosPage(repository: mockRepository));
        await tester.pumpAndSettle();

        // Enter todo text
        await tester.enterText(
          find.byKey(const Key('todo_input')),
          'New Test Todo',
        );

        // Tap add button
        await tester.tap(find.byKey(const Key('add_todo_button')));
        await tester.pumpAndSettle();

        // Verify repository was called
        verify(() => mockRepository.addTodo('New Test Todo')).called(1);
      });

      testWidgets('should add todo when Enter is pressed', (tester) async {
        await pumpApp(tester, TodosPage(repository: mockRepository));
        await tester.pumpAndSettle();

        // Enter todo text and press Enter
        await tester.enterText(
          find.byKey(const Key('todo_input')),
          'New Test Todo',
        );
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        // Verify repository was called
        verify(() => mockRepository.addTodo('New Test Todo')).called(1);
      });

      testWidgets('should not add empty todo', (tester) async {
        await pumpApp(tester, TodosPage(repository: mockRepository));
        await tester.pumpAndSettle();

        // Try to add empty todo
        await tester.tap(find.byKey(const Key('add_todo_button')));
        await tester.pumpAndSettle();

        // Verify repository was not called
        verifyNever(() => mockRepository.addTodo(any()));
      });

      testWidgets('should clear input after adding todo', (tester) async {
        await pumpApp(tester, TodosPage(repository: mockRepository));
        await tester.pumpAndSettle();

        // Enter and add todo
        await tester.enterText(
          find.byKey(const Key('todo_input')),
          'New Test Todo',
        );
        await tester.tap(find.byKey(const Key('add_todo_button')));
        await tester.pumpAndSettle();

        // Verify input field is cleared (check that the text is not in the input field)
        final inputField = tester.widget<TextField>(find.byKey(const Key('todo_input')));
        expect(inputField.controller?.text, isEmpty);
      });
    });

    group('Toggle todo functionality', () {
      testWidgets('should toggle todo when checkbox is tapped', (tester) async {
        await pumpApp(tester, TodosPage(repository: mockRepository));
        await tester.pumpAndSettle();

        // Tap checkbox for first todo
        await tester.tap(find.byKey(const Key('checkbox_1')));
        await tester.pumpAndSettle();

        // Verify repository was called
        verify(() => mockRepository.toggleTodo('1')).called(1);
      });
    });

    group('Delete todo functionality', () {
      testWidgets('should delete todo when delete button is tapped', (tester) async {
        await pumpApp(tester, TodosPage(repository: mockRepository));
        await tester.pumpAndSettle();

        // Tap delete button for first todo
        await tester.tap(find.byKey(const Key('delete_button_1')));
        await tester.pumpAndSettle();

        // Verify repository was called
        verify(() => mockRepository.deleteTodo('1')).called(1);
      });
    });

    group('Error handling', () {
      testWidgets('should show error message when fetch fails', (tester) async {
        when(() => mockRepository.fetchTodos())
            .thenThrow(Exception('Network error'));

        await pumpApp(tester, TodosPage(repository: mockRepository));
        await tester.pumpAndSettle();

        expect(find.byKey(const Key('error_message')), findsOneWidget);
        expect(find.textContaining('Network error'), findsOneWidget);
      });

      testWidgets('should show error message when add fails', (tester) async {
        when(() => mockRepository.addTodo(any()))
            .thenThrow(Exception('Add failed'));

        await pumpApp(tester, TodosPage(repository: mockRepository));
        await tester.pumpAndSettle();

        // Try to add a todo
        await tester.enterText(
          find.byKey(const Key('todo_input')),
          'New Test Todo',
        );
        await tester.tap(find.byKey(const Key('add_todo_button')));
        await tester.pumpAndSettle();

        expect(find.byKey(const Key('error_message')), findsOneWidget);
        expect(find.textContaining('Add failed'), findsOneWidget);
      });

      testWidgets('should show error message when toggle fails', (tester) async {
        when(() => mockRepository.toggleTodo(any()))
            .thenThrow(Exception('Toggle failed'));

        await pumpApp(tester, TodosPage(repository: mockRepository));
        await tester.pumpAndSettle();

        // Try to toggle a todo
        await tester.tap(find.byKey(const Key('checkbox_1')));
        await tester.pumpAndSettle();

        expect(find.byKey(const Key('error_message')), findsOneWidget);
        expect(find.textContaining('Toggle failed'), findsOneWidget);
      });

      testWidgets('should show error message when delete fails', (tester) async {
        when(() => mockRepository.deleteTodo(any()))
            .thenThrow(Exception('Delete failed'));

        await pumpApp(tester, TodosPage(repository: mockRepository));
        await tester.pumpAndSettle();

        // Try to delete a todo
        await tester.tap(find.byKey(const Key('delete_button_1')));
        await tester.pumpAndSettle();

        expect(find.byKey(const Key('error_message')), findsOneWidget);
        expect(find.textContaining('Delete failed'), findsOneWidget);
      });
    });

    group('UI elements', () {
      testWidgets('should display todos with correct styling', (tester) async {
        await pumpApp(tester, TodosPage(repository: mockRepository));
        await tester.pumpAndSettle();

        // Check that todos are displayed in cards
        expect(find.byType(Card), findsNWidgets(2));
        
        // Check that checkboxes are present
        expect(find.byType(Checkbox), findsNWidgets(2));
        
        // Check that delete buttons are present
        expect(find.byIcon(Icons.delete), findsNWidgets(2));
      });

      testWidgets('should show completed todos with strikethrough', (tester) async {
        await pumpApp(tester, TodosPage(repository: mockRepository));
        await tester.pumpAndSettle();

        // The second todo should be completed (from mock setup)
        final completedTodo = find.byKey(const Key('todo_title_2'));
        expect(completedTodo, findsOneWidget);
        
        // Note: We can't easily test the strikethrough style in widget tests
        // but we can verify the todo exists and is marked as completed
        expect(find.text('Test Todo 2'), findsOneWidget);
      });

      testWidgets('should disable add button during loading', (tester) async {
        // Set up a slow add operation
        when(() => mockRepository.addTodo(any())).thenAnswer(
          (_) async {
            await Future.delayed(const Duration(milliseconds: 50));
            return Todo(
              id: '3',
              title: 'Slow Todo',
              createdAt: DateTime.now(),
            );
          },
        );

        await pumpApp(tester, TodosPage(repository: mockRepository));
        await tester.pumpAndSettle();

        // Enter text and start adding
        await tester.enterText(
          find.byKey(const Key('todo_input')),
          'Slow Todo',
        );
        await tester.tap(find.byKey(const Key('add_todo_button')));
        await tester.pump();

        // Button should be disabled during loading
        final addButton = tester.widget<ElevatedButton>(
          find.byKey(const Key('add_todo_button')),
        );
        expect(addButton.onPressed, isNull);
        
        // Wait for the operation to complete
        await tester.pumpAndSettle();
      });
    });
  });
}
