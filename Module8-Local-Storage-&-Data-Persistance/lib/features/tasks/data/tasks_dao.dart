import 'package:sqflite/sqflite.dart';
import '../data/database_provider.dart';
import '../data/task_model.dart';
import '../../../core/utils/result.dart';

/// Data Access Object for Tasks
/// Handles all database operations for the tasks table
class TasksDao {
  final DatabaseProvider _databaseProvider = DatabaseProvider();

  /// Insert a new task into the database
  /// Returns the inserted task with generated ID
  Future<Result<Task>> insertTask(Task task) async {
    try {
      final db = await _databaseProvider.database;
      
      // Insert the task and get the generated ID
      final id = await db.insert(
        'tasks',
        task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Return the task with the generated ID
      final insertedTask = task.copyWith(id: id);
      return Result.success(insertedTask);
    } catch (e) {
      return Result.error('Failed to insert task: $e');
    }
  }

  /// Update an existing task in the database
  Future<Result<bool>> updateTask(Task task) async {
    try {
      if (task.id == null) {
        return Result.error('Cannot update task without ID');
      }

      final db = await _databaseProvider.database;
      
      final rowsAffected = await db.update(
        'tasks',
        task.toMap(),
        where: 'id = ?',
        whereArgs: [task.id],
      );

      if (rowsAffected > 0) {
        return Result.success(true);
      } else {
        return Result.error('Task not found or no changes made');
      }
    } catch (e) {
      return Result.error('Failed to update task: $e');
    }
  }

  /// Delete a task from the database
  Future<Result<bool>> deleteTask(int taskId) async {
    try {
      final db = await _databaseProvider.database;
      
      final rowsAffected = await db.delete(
        'tasks',
        where: 'id = ?',
        whereArgs: [taskId],
      );

      if (rowsAffected > 0) {
        return Result.success(true);
      } else {
        return Result.error('Task not found');
      }
    } catch (e) {
      return Result.error('Failed to delete task: $e');
    }
  }

  /// Get a task by its ID
  Future<Result<Task?>> getTaskById(int taskId) async {
    try {
      final db = await _databaseProvider.database;
      
      final List<Map<String, Object?>> results = await db.query(
        'tasks',
        where: 'id = ?',
        whereArgs: [taskId],
        limit: 1,
      );

      if (results.isNotEmpty) {
        final task = Task.fromMap(results.first);
        return Result.success(task);
      } else {
        return Result.success(null);
      }
    } catch (e) {
      return Result.error('Failed to get task: $e');
    }
  }

  /// Get all tasks from the database
  /// Optionally filter by completion status
  Future<Result<List<Task>>> getAllTasks({bool? isDone}) async {
    try {
      final db = await _databaseProvider.database;
      
      String? whereClause;
      List<Object?>? whereArgs;

      if (isDone != null) {
        whereClause = 'isDone = ?';
        whereArgs = [isDone ? 1 : 0];
      }

      final List<Map<String, Object?>> results = await db.query(
        'tasks',
        where: whereClause,
        whereArgs: whereArgs,
        orderBy: 'createdAt DESC', // Most recent first
      );

      final tasks = results.map((row) => Task.fromMap(row)).toList();
      return Result.success(tasks);
    } catch (e) {
      return Result.error('Failed to get tasks: $e');
    }
  }

  /// Search tasks by title (case-insensitive)
  Future<Result<List<Task>>> searchTasks(String query) async {
    try {
      if (query.trim().isEmpty) {
        return await getAllTasks();
      }

      final db = await _databaseProvider.database;
      
      final List<Map<String, Object?>> results = await db.query(
        'tasks',
        where: 'title LIKE ? OR notes LIKE ?',
        whereArgs: ['%$query%', '%$query%'],
        orderBy: 'createdAt DESC',
      );

      final tasks = results.map((row) => Task.fromMap(row)).toList();
      return Result.success(tasks);
    } catch (e) {
      return Result.error('Failed to search tasks: $e');
    }
  }

  /// Toggle the completion status of a task
  Future<Result<Task>> toggleTaskCompletion(int taskId) async {
    try {
      // First get the current task
      final currentTaskResult = await getTaskById(taskId);
      if (!currentTaskResult.isSuccess || currentTaskResult.data == null) {
        return Result.error('Task not found');
      }

      final currentTask = currentTaskResult.data!;
      final updatedTask = currentTask.copyWith(isDone: !currentTask.isDone);

      // Update the task
      final updateResult = await updateTask(updatedTask);
      if (!updateResult.isSuccess) {
        return Result.error(updateResult.errorMessage!);
      }

      return Result.success(updatedTask);
    } catch (e) {
      return Result.error('Failed to toggle task completion: $e');
    }
  }

  /// Delete all completed tasks
  Future<Result<int>> deleteCompletedTasks() async {
    try {
      final db = await _databaseProvider.database;
      
      final rowsAffected = await db.delete(
        'tasks',
        where: 'isDone = ?',
        whereArgs: [1],
      );

      return Result.success(rowsAffected);
    } catch (e) {
      return Result.error('Failed to delete completed tasks: $e');
    }
  }

  /// Get task statistics
  Future<Result<Map<String, int>>> getTaskStats() async {
    try {
      final db = await _databaseProvider.database;
      
      final totalTasks = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM tasks')
      ) ?? 0;
      
      final completedTasks = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM tasks WHERE isDone = 1')
      ) ?? 0;
      
      final pendingTasks = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM tasks WHERE isDone = 0')
      ) ?? 0;

      return Result.success({
        'total': totalTasks,
        'completed': completedTasks,
        'pending': pendingTasks,
      });
    } catch (e) {
      return Result.error('Failed to get task stats: $e');
    }
  }

  /// Get tasks created in the last N days
  Future<Result<List<Task>>> getRecentTasks(int days) async {
    try {
      final db = await _databaseProvider.database;
      
      final cutoffDate = DateTime.now().subtract(Duration(days: days));
      final cutoffTimestamp = cutoffDate.millisecondsSinceEpoch;

      final List<Map<String, Object?>> results = await db.query(
        'tasks',
        where: 'createdAt >= ?',
        whereArgs: [cutoffTimestamp],
        orderBy: 'createdAt DESC',
      );

      final tasks = results.map((row) => Task.fromMap(row)).toList();
      return Result.success(tasks);
    } catch (e) {
      return Result.error('Failed to get recent tasks: $e');
    }
  }
}
