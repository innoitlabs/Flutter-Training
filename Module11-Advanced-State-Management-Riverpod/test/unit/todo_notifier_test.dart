import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_hub/features/todos/todo_providers.dart';
import 'package:riverpod_hub/features/todos/todo_repository.dart';
import 'package:riverpod_hub/features/todos/todos_notifier.dart';

void main() {
  group('TodosNotifier', () {
    late ProviderContainer container;
    late TodosNotifier notifier;
    late FakeTodoRepository fakeRepository;

    setUp(() {
      fakeRepository = FakeTodoRepository();
      container = ProviderContainer(
        overrides: [
          todosRepoProvider.overrideWithValue(fakeRepository),
        ],
      );
      notifier = container.read(todosNotifierProvider.notifier);
    });

    tearDown(() {
      container.dispose();
    });

    test('should load todos from repository', () async {
      // Wait for initial load
      await Future.delayed(const Duration(milliseconds: 500));
      expect(notifier.state.length, 3); // Fake repository has 3 items
      expect(notifier.state[0].title, 'Learn Riverpod');
      expect(notifier.state[0].done, true);
    });

    test('should add todo', () async {
      // Wait for initial load first
      await Future.delayed(const Duration(milliseconds: 500));
      final initialCount = notifier.state.length;
      
      await notifier.addTodo('Test todo');
      
      expect(notifier.state.length, initialCount + 1);
      expect(notifier.state.last.title, 'Test todo');
      expect(notifier.state.last.done, false);
    });

    test('should not add empty todo', () async {
      // Wait for initial load first
      await Future.delayed(const Duration(milliseconds: 500));
      final initialCount = notifier.state.length;
      
      await notifier.addTodo('');
      await notifier.addTodo('   ');
      
      expect(notifier.state.length, initialCount); // No change
    });

    test('should toggle todo', () async {
      // Wait for initial load first
      await Future.delayed(const Duration(milliseconds: 500));
      final todoId = notifier.state.first.id;
      final initialDone = notifier.state.first.done;
      
      await notifier.toggleTodo(todoId);
      expect(notifier.state.first.done, !initialDone);
      
      await notifier.toggleTodo(todoId);
      expect(notifier.state.first.done, initialDone);
    });

    test('should delete todo', () async {
      // Wait for initial load first
      await Future.delayed(const Duration(milliseconds: 500));
      final initialCount = notifier.state.length;
      final todoId = notifier.state.first.id;
      
      await notifier.deleteTodo(todoId);
      
      expect(notifier.state.length, initialCount - 1);
    });

    test('should update todo', () async {
      // Wait for initial load first
      await Future.delayed(const Duration(milliseconds: 500));
      final originalTodo = notifier.state.first;
      
      final updatedTodo = originalTodo.copyWith(title: 'Updated title');
      await notifier.updateTodo(updatedTodo);
      
      expect(notifier.state.first.title, 'Updated title');
    });

    test('should clear completed todos', () async {
      // Wait for initial load first
      await Future.delayed(const Duration(milliseconds: 500));
      final initialCount = notifier.state.length;
      final completedCount = notifier.state.where((todo) => todo.done).length;
      
      await notifier.clearCompleted();
      
      expect(notifier.state.length, initialCount - completedCount);
      expect(notifier.state.every((todo) => !todo.done), true);
    });

    test('should mark all todos as completed', () async {
      // Wait for initial load first
      await Future.delayed(const Duration(milliseconds: 500));
      
      await notifier.markAllCompleted();
      
      expect(notifier.state.every((todo) => todo.done), true);
    });

    test('should mark all todos as active', () async {
      // Wait for initial load first
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Mark all as completed first
      await notifier.markAllCompleted();
      expect(notifier.state.every((todo) => todo.done), true);
      
      // Then mark all as active
      await notifier.markAllActive();
      expect(notifier.state.every((todo) => !todo.done), true);
    });
  });

  group('Todo Providers', () {
    late ProviderContainer container;
    late FakeTodoRepository fakeRepository;

    setUp(() {
      fakeRepository = FakeTodoRepository();
      container = ProviderContainer(
        overrides: [
          todosRepoProvider.overrideWithValue(fakeRepository),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('filteredTodosProvider should filter todos correctly', () async {
      // Wait for initial load
      await Future.delayed(const Duration(milliseconds: 500));
      
      // All todos should be shown initially
      expect(container.read(filteredTodosProvider).length, 3);
      
      // Filter to active todos
      container.read(todoFilterProvider.notifier).state = TodoFilter.active;
      expect(container.read(filteredTodosProvider).length, 2);
      
      // Filter to completed todos
      container.read(todoFilterProvider.notifier).state = TodoFilter.completed;
      expect(container.read(filteredTodosProvider).length, 1);
    });

    test('todoStatsProvider should calculate correct statistics', () async {
      // Wait for initial load
      await Future.delayed(const Duration(milliseconds: 500));
      
      final stats = container.read(todoStatsProvider);
      
      expect(stats.total, 3);
      expect(stats.completed, 1);
      expect(stats.active, 2);
    });

    test('should update statistics when todos change', () async {
      // Wait for initial load
      await Future.delayed(const Duration(milliseconds: 500));
      
      final notifier = container.read(todosNotifierProvider.notifier);
      final initialStats = container.read(todoStatsProvider);
      
      // Add a new todo
      await notifier.addTodo('New todo');
      
      final newStats = container.read(todoStatsProvider);
      expect(newStats.total, initialStats.total + 1);
      expect(newStats.active, initialStats.active + 1);
      expect(newStats.completed, initialStats.completed);
    });
  });

  group('Dependency Injection', () {
    test('should use fake repository in tests', () async {
      final fakeRepository = FakeTodoRepository();
      final container = ProviderContainer(
        overrides: [
          todosRepoProvider.overrideWithValue(fakeRepository),
        ],
      );

      // Wait for initial load
      await Future.delayed(const Duration(milliseconds: 500));
      
      final todos = container.read(todosNotifierProvider);
      
      // Should have the fake data
      expect(todos.length, 3);
      expect(todos[0].title, 'Learn Riverpod');
      expect(todos[0].done, true);
      
      container.dispose();
    });

    test('should use real repository by default', () async {
      final container = ProviderContainer();
      
      // Wait for initial load
      await Future.delayed(const Duration(milliseconds: 500));
      
      final todos = container.read(todosNotifierProvider);
      
      // Should start with empty list (real repository starts empty)
      expect(todos, isEmpty);
      
      container.dispose();
    });
  });
}
