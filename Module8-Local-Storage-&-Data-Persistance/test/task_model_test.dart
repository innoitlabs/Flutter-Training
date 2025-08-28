import 'package:flutter_test/flutter_test.dart';
import 'package:localbox/features/tasks/data/task_model.dart';

void main() {
  group('Task Model Tests', () {
    test('should create a task with required fields', () {
      final task = Task(
        id: 1,
        title: 'Test Task',
        notes: 'Test notes',
        isDone: false,
        createdAt: DateTime(2024, 1, 15, 10, 30),
      );

      expect(task.id, 1);
      expect(task.title, 'Test Task');
      expect(task.notes, 'Test notes');
      expect(task.isDone, false);
      expect(task.createdAt, DateTime(2024, 1, 15, 10, 30));
    });

    test('should create a task using factory method', () {
      final task = Task.create(
        title: 'New Task',
        notes: 'New notes',
      );

      expect(task.id, isNull);
      expect(task.title, 'New Task');
      expect(task.notes, 'New notes');
      expect(task.isDone, false);
      expect(task.createdAt, isA<DateTime>());
    });

    test('should convert task to map for database storage', () {
      final task = Task(
        id: 1,
        title: 'Test Task',
        notes: 'Test notes',
        isDone: true,
        createdAt: DateTime(2024, 1, 15, 10, 30),
      );

      final map = task.toMap();

      expect(map['id'], 1);
      expect(map['title'], 'Test Task');
      expect(map['notes'], 'Test notes');
      expect(map['isDone'], 1); // SQLite stores bool as int
      expect(map['createdAt'], DateTime(2024, 1, 15, 10, 30).millisecondsSinceEpoch);
    });

    test('should create task from map (database row)', () {
      final map = {
        'id': 1,
        'title': 'Test Task',
        'notes': 'Test notes',
        'isDone': 1, // SQLite stores bool as int
        'createdAt': DateTime(2024, 1, 15, 10, 30).millisecondsSinceEpoch,
      };

      final task = Task.fromMap(map);

      expect(task.id, 1);
      expect(task.title, 'Test Task');
      expect(task.notes, 'Test notes');
      expect(task.isDone, true);
      expect(task.createdAt, DateTime(2024, 1, 15, 10, 30));
    });

    test('should handle null notes in fromMap', () {
      final map = {
        'id': 1,
        'title': 'Test Task',
        'notes': null,
        'isDone': 0,
        'createdAt': DateTime(2024, 1, 15, 10, 30).millisecondsSinceEpoch,
      };

      final task = Task.fromMap(map);

      expect(task.notes, isNull);
      expect(task.isDone, false);
    });

    test('should create a copy of task with updated fields', () {
      final originalTask = Task(
        id: 1,
        title: 'Original Task',
        notes: 'Original notes',
        isDone: false,
        createdAt: DateTime(2024, 1, 15, 10, 30),
      );

      final updatedTask = originalTask.copyWith(
        title: 'Updated Task',
        isDone: true,
      );

      expect(updatedTask.id, 1);
      expect(updatedTask.title, 'Updated Task');
      expect(updatedTask.notes, 'Original notes'); // Unchanged
      expect(updatedTask.isDone, true);
      expect(updatedTask.createdAt, DateTime(2024, 1, 15, 10, 30)); // Unchanged
    });

    test('should convert task to JSON', () {
      final task = Task(
        id: 1,
        title: 'Test Task',
        notes: 'Test notes',
        isDone: true,
        createdAt: DateTime(2024, 1, 15, 10, 30),
      );

      final json = task.toJson();

      expect(json['id'], 1);
      expect(json['title'], 'Test Task');
      expect(json['notes'], 'Test notes');
      expect(json['isDone'], true);
      expect(json['createdAt'], '2024-01-15T10:30:00.000');
    });

    test('should create task from JSON', () {
      final json = {
        'id': 1,
        'title': 'Test Task',
        'notes': 'Test notes',
        'isDone': true,
        'createdAt': '2024-01-15T10:30:00.000',
      };

      final task = Task.fromJson(json);

      expect(task.id, 1);
      expect(task.title, 'Test Task');
      expect(task.notes, 'Test notes');
      expect(task.isDone, true);
      expect(task.createdAt, DateTime(2024, 1, 15, 10, 30));
    });

    test('should provide title preview for long titles', () {
      final longTitle = 'A' * 60; // 60 characters
      final task = Task.create(title: longTitle);

      expect(task.titlePreview.length, 50); // Max 50 characters
      expect(task.titlePreview.endsWith('...'), true);
    });

    test('should provide notes preview for long notes', () {
      final longNotes = 'A' * 120; // 120 characters
      final task = Task.create(title: 'Test', notes: longNotes);

      expect(task.notesPreview!.length, 100); // Max 100 characters
      expect(task.notesPreview!.endsWith('...'), true);
    });

    test('should return null for notes preview when notes is null', () {
      final task = Task.create(title: 'Test');

      expect(task.notesPreview, isNull);
    });

    test('should check task completion status', () {
      final pendingTask = Task.create(title: 'Pending Task');
      final completedTask = Task.create(title: 'Completed Task').copyWith(isDone: true);

      expect(pendingTask.isPending, true);
      expect(pendingTask.isCompleted, false);
      expect(completedTask.isPending, false);
      expect(completedTask.isCompleted, true);
    });

    test('should implement equality correctly', () {
      final task1 = Task(
        id: 1,
        title: 'Test Task',
        notes: 'Test notes',
        isDone: false,
        createdAt: DateTime(2024, 1, 15, 10, 30),
      );

      final task2 = Task(
        id: 1,
        title: 'Test Task',
        notes: 'Test notes',
        isDone: false,
        createdAt: DateTime(2024, 1, 15, 10, 30),
      );

      final task3 = Task(
        id: 2,
        title: 'Different Task',
        notes: 'Different notes',
        isDone: true,
        createdAt: DateTime(2024, 1, 16, 11, 45),
      );

      expect(task1, equals(task2));
      expect(task1, isNot(equals(task3)));
      expect(task1.hashCode, equals(task2.hashCode));
      expect(task1.hashCode, isNot(equals(task3.hashCode)));
    });
  });
}
