import '../data/task_model.dart';
import '../data/tasks_dao.dart';
import '../../../core/cache/memory_cache.dart';
import '../../../core/utils/result.dart';

/// Repository for Tasks that implements caching strategy
/// Provides a clean interface for task operations with in-memory caching
class TasksRepository {
  final TasksDao _tasksDao = TasksDao();
  final MemoryCache<List<Task>> _tasksCache = MemoryCache<List<Task>>(
    ttl: const Duration(seconds: 30), // Cache for 30 seconds
  );

  /// Get all tasks with caching
  /// Returns cached data if valid, otherwise fetches from database
  Future<Result<List<Task>>> getAllTasks({bool? isDone, bool forceRefresh = false}) async {
    try {
      // Check cache first (unless force refresh is requested)
      if (!forceRefresh && _tasksCache.isValid) {
        final cachedTasks = _tasksCache.value;
        if (cachedTasks != null) {
          // Filter cached tasks if needed
          if (isDone != null) {
            final filteredTasks = cachedTasks.where((task) => task.isDone == isDone).toList();
            return Result.success(filteredTasks);
          }
          return Result.success(cachedTasks);
        }
      }

      // Fetch from database
      final result = await _tasksDao.getAllTasks(isDone: isDone);
      
      if (result.isSuccess) {
        // Update cache with fresh data
        _tasksCache.set(result.data!);
      }

      return result;
    } catch (e) {
      return Result.error('Failed to get tasks: $e');
    }
  }

  /// Get a task by ID (no caching for individual tasks)
  Future<Result<Task?>> getTaskById(int taskId) async {
    try {
      return await _tasksDao.getTaskById(taskId);
    } catch (e) {
      return Result.error('Failed to get task: $e');
    }
  }

  /// Create a new task
  Future<Result<Task>> createTask(String title, {String? notes}) async {
    try {
      final task = Task.create(title: title, notes: notes);
      final result = await _tasksDao.insertTask(task);
      
      if (result.isSuccess) {
        // Invalidate cache to ensure fresh data on next fetch
        _tasksCache.invalidate();
      }

      return result;
    } catch (e) {
      return Result.error('Failed to create task: $e');
    }
  }

  /// Update an existing task
  Future<Result<bool>> updateTask(Task task) async {
    try {
      final result = await _tasksDao.updateTask(task);
      
      if (result.isSuccess) {
        // Invalidate cache to ensure fresh data on next fetch
        _tasksCache.invalidate();
      }

      return result;
    } catch (e) {
      return Result.error('Failed to update task: $e');
    }
  }

  /// Delete a task
  Future<Result<bool>> deleteTask(int taskId) async {
    try {
      final result = await _tasksDao.deleteTask(taskId);
      
      if (result.isSuccess) {
        // Invalidate cache to ensure fresh data on next fetch
        _tasksCache.invalidate();
      }

      return result;
    } catch (e) {
      return Result.error('Failed to delete task: $e');
    }
  }

  /// Toggle task completion status
  Future<Result<Task>> toggleTaskCompletion(int taskId) async {
    try {
      final result = await _tasksDao.toggleTaskCompletion(taskId);
      
      if (result.isSuccess) {
        // Invalidate cache to ensure fresh data on next fetch
        _tasksCache.invalidate();
      }

      return result;
    } catch (e) {
      return Result.error('Failed to toggle task completion: $e');
    }
  }

  /// Search tasks by query
  Future<Result<List<Task>>> searchTasks(String query) async {
    try {
      // For search, we don't use cache as results are dynamic
      return await _tasksDao.searchTasks(query);
    } catch (e) {
      return Result.error('Failed to search tasks: $e');
    }
  }

  /// Delete all completed tasks
  Future<Result<int>> deleteCompletedTasks() async {
    try {
      final result = await _tasksDao.deleteCompletedTasks();
      
      if (result.isSuccess) {
        // Invalidate cache to ensure fresh data on next fetch
        _tasksCache.invalidate();
      }

      return result;
    } catch (e) {
      return Result.error('Failed to delete completed tasks: $e');
    }
  }

  /// Get task statistics
  Future<Result<Map<String, int>>> getTaskStats() async {
    try {
      return await _tasksDao.getTaskStats();
    } catch (e) {
      return Result.error('Failed to get task stats: $e');
    }
  }

  /// Get recent tasks (last N days)
  Future<Result<List<Task>>> getRecentTasks(int days) async {
    try {
      return await _tasksDao.getRecentTasks(days);
    } catch (e) {
      return Result.error('Failed to get recent tasks: $e');
    }
  }

  /// Force refresh the cache by fetching fresh data
  Future<Result<List<Task>>> refresh() async {
    try {
      return await getAllTasks(forceRefresh: true);
    } catch (e) {
      return Result.error('Failed to refresh tasks: $e');
    }
  }

  /// Clear the cache
  void clearCache() {
    _tasksCache.clear();
  }

  /// Get cache statistics
  Map<String, dynamic> getCacheStats() {
    return _tasksCache.stats;
  }

  /// Check if cache is valid
  bool get isCacheValid => _tasksCache.isValid;

  /// Get cached tasks (if any)
  List<Task>? get cachedTasks => _tasksCache.value;
}
