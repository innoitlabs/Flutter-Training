import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_hub/features/todos/todo_providers.dart';
import 'package:riverpod_hub/features/todos/todo_repository.dart';
import 'package:riverpod_hub/features/todos/todos_page.dart';

void main() {
  group('TodosPage Widget Tests', () {
    testWidgets('should display todos from fake repository', (tester) async {
      final fakeRepository = FakeTodoRepository();
      
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            todosRepoProvider.overrideWithValue(fakeRepository),
          ],
          child: const MaterialApp(
            home: TodosPage(),
          ),
        ),
      );

      // Wait for initial load
      await tester.pumpAndSettle();

      // Should display the fake todos
      expect(find.text('Learn Riverpod'), findsOneWidget);
      expect(find.text('Build awesome app'), findsOneWidget);
      expect(find.text('Write tests'), findsOneWidget);
    });

    testWidgets('should add new todo', (tester) async {
      final fakeRepository = FakeTodoRepository();
      
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            todosRepoProvider.overrideWithValue(fakeRepository),
          ],
          child: const MaterialApp(
            home: TodosPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap the FAB to add a new todo
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Enter todo text
      await tester.enterText(find.byType(TextField), 'New test todo');
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      // Should display the new todo
      expect(find.text('New test todo'), findsOneWidget);
    });

    testWidgets('should toggle todo completion', (tester) async {
      final fakeRepository = FakeTodoRepository();
      
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            todosRepoProvider.overrideWithValue(fakeRepository),
          ],
          child: const MaterialApp(
            home: TodosPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find the first todo's checkbox
      final checkbox = find.byType(Checkbox).first;
      
      // Toggle the checkbox
      await tester.tap(checkbox);
      await tester.pumpAndSettle();

      // The todo should now be completed (strikethrough text)
      expect(find.text('Learn Riverpod'), findsOneWidget);
    });

    testWidgets('should delete todo', (tester) async {
      final fakeRepository = FakeTodoRepository();
      
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            todosRepoProvider.overrideWithValue(fakeRepository),
          ],
          child: const MaterialApp(
            home: TodosPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find and tap the delete button for the first todo
      final deleteButton = find.byIcon(Icons.delete).first;
      await tester.tap(deleteButton);
      await tester.pumpAndSettle();

      // The first todo should be removed
      expect(find.text('Learn Riverpod'), findsNothing);
      expect(find.text('Build awesome app'), findsOneWidget);
      expect(find.text('Write tests'), findsOneWidget);
    });

    testWidgets('should filter todos', (tester) async {
      final fakeRepository = FakeTodoRepository();
      
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            todosRepoProvider.overrideWithValue(fakeRepository),
          ],
          child: const MaterialApp(
            home: TodosPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap the "Active" filter
      await tester.tap(find.text('Active'));
      await tester.pumpAndSettle();

      // Should only show active todos
      expect(find.text('Learn Riverpod'), findsNothing); // This one is completed
      expect(find.text('Build awesome app'), findsOneWidget);
      expect(find.text('Write tests'), findsOneWidget);

      // Tap the "Completed" filter
      await tester.tap(find.text('Completed'));
      await tester.pumpAndSettle();

      // Should only show completed todos
      expect(find.text('Learn Riverpod'), findsOneWidget);
      expect(find.text('Build awesome app'), findsNothing);
      expect(find.text('Write tests'), findsNothing);
    });

    testWidgets('should display correct statistics', (tester) async {
      final fakeRepository = FakeTodoRepository();
      
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            todosRepoProvider.overrideWithValue(fakeRepository),
          ],
          child: const MaterialApp(
            home: TodosPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should display correct statistics
      expect(find.text('3'), findsOneWidget); // Total
      expect(find.text('2'), findsOneWidget); // Active
      expect(find.text('1'), findsOneWidget); // Completed
    });

    testWidgets('should mark all todos as completed', (tester) async {
      final fakeRepository = FakeTodoRepository();
      
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            todosRepoProvider.overrideWithValue(fakeRepository),
          ],
          child: const MaterialApp(
            home: TodosPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap "Mark All Complete" button
      await tester.tap(find.text('Mark All Complete'));
      await tester.pumpAndSettle();

      // All todos should now be completed
      expect(find.text('0'), findsOneWidget); // Active count should be 0
      expect(find.text('3'), findsOneWidget); // Completed count should be 3
    });

    testWidgets('should clear completed todos', (tester) async {
      final fakeRepository = FakeTodoRepository();
      
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            todosRepoProvider.overrideWithValue(fakeRepository),
          ],
          child: const MaterialApp(
            home: TodosPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap "Clear Completed" button
      await tester.tap(find.text('Clear Completed'));
      await tester.pumpAndSettle();

      // Completed todo should be removed
      expect(find.text('Learn Riverpod'), findsNothing);
      expect(find.text('Build awesome app'), findsOneWidget);
      expect(find.text('Write tests'), findsOneWidget);
    });
  });
}
