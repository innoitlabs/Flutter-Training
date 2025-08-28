import 'package:flutter/material.dart';
import '../data/task_model.dart';
import '../data/tasks_repository.dart';
import 'task_editor_sheet.dart';
import '../../../core/utils/date_formats.dart';

/// Tasks page that displays and manages the list of tasks
/// Implements CRUD operations, search, and caching
class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final TasksRepository _repository = TasksRepository();
  final TextEditingController _searchController = TextEditingController();

  List<Task> _tasks = [];
  List<Task> _filteredTasks = [];
  bool _isLoading = true;

  String? _errorMessage;
  String _searchQuery = '';
  bool _showCompleted = true; // Toggle to show/hide completed tasks

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Load tasks from repository with caching
  Future<void> _loadTasks() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await _repository.getAllTasks();
      
      if (result.isSuccess) {
        setState(() {
          _tasks = result.data!;
          _filterTasks();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = result.errorMessage;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load tasks: $e';
        _isLoading = false;
      });
    }
  }

  /// Filter tasks based on search query and completion status
  void _filterTasks() {
    List<Task> filtered = _tasks;

    // Filter by completion status
    if (!_showCompleted) {
      filtered = filtered.where((task) => !task.isDone).toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((task) {
        final title = task.title.toLowerCase();
        final notes = task.notes?.toLowerCase() ?? '';
        final query = _searchQuery.toLowerCase();
        return title.contains(query) || notes.contains(query);
      }).toList();
    }

    setState(() {
      _filteredTasks = filtered;
    });
  }

  /// Search tasks
  Future<void> _searchTasks(String query) async {
    setState(() {
      _searchQuery = query;
    });

    try {
      if (query.trim().isEmpty) {
        _filterTasks();
        return;
      }

      final result = await _repository.searchTasks(query);
      
      if (result.isSuccess) {
        setState(() {
          _filteredTasks = result.data!;
        });
      } else {
        setState(() {
          _errorMessage = result.errorMessage;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Search failed: $e';
      });
    }
  }

  /// Toggle task completion status
  Future<void> _toggleTaskCompletion(Task task) async {
    if (task.id == null) return;

    final result = await _repository.toggleTaskCompletion(task.id!);
    
    if (result.isSuccess) {
      // Update the task in the list
      setState(() {
        final index = _tasks.indexWhere((t) => t.id == task.id);
        if (index != -1) {
          _tasks[index] = result.data!;
          _filterTasks();
        }
      });
      
      _showSnackBar(
        result.data!.isDone ? 'Task completed!' : 'Task marked as pending',
      );
    } else {
      _showSnackBar('Failed to update task: ${result.errorMessage}');
    }
  }

  /// Delete a task with undo functionality
  Future<void> _deleteTask(Task task) async {
    if (task.id == null) return;

    final deletedTask = task;
    final deletedIndex = _tasks.indexWhere((t) => t.id == task.id);

    // Remove from list immediately for better UX
    setState(() {
      _tasks.removeAt(deletedIndex);
      _filterTasks();
    });

    // Show undo snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task "${task.title}" deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => _undoDelete(deletedTask, deletedIndex),
        ),
        duration: const Duration(seconds: 3),
      ),
    );

    // Actually delete from database
    final result = await _repository.deleteTask(task.id!);
    if (!result.isSuccess) {
      _showSnackBar('Failed to delete task: ${result.errorMessage}');
    }
  }

  /// Undo task deletion
  void _undoDelete(Task task, int index) {
    setState(() {
      _tasks.insert(index, task);
      _filterTasks();
    });
  }

  /// Show task editor sheet
  Future<void> _showTaskEditor([Task? task]) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TaskEditorSheet(task: task),
    );

    if (result == true) {
      // Task was created or updated, reload the list
      _loadTasks();
    }
  }

  /// Delete all completed tasks
  Future<void> _deleteCompletedTasks() async {
    final completedTasks = _tasks.where((task) => task.isDone).toList();
    
    if (completedTasks.isEmpty) {
      _showSnackBar('No completed tasks to delete');
      return;
    }

    final confirmed = await _showConfirmDialog(
      'Delete Completed Tasks',
      'Are you sure you want to delete ${completedTasks.length} completed task(s)? This action cannot be undone.',
    );

    if (confirmed) {
      final result = await _repository.deleteCompletedTasks();
      
      if (result.isSuccess) {
        setState(() {
          _tasks.removeWhere((task) => task.isDone);
          _filterTasks();
        });
        _showSnackBar('${result.data} completed task(s) deleted');
      } else {
        _showSnackBar('Failed to delete completed tasks: ${result.errorMessage}');
      }
    }
  }

  /// Show confirmation dialog
  Future<bool> _showConfirmDialog(String title, String message) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// Show snackbar with message
  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          // Toggle completed tasks visibility
          IconButton(
            onPressed: () {
              setState(() {
                _showCompleted = !_showCompleted;
                _filterTasks();
              });
            },
            icon: Icon(_showCompleted ? Icons.visibility : Icons.visibility_off),
            tooltip: _showCompleted ? 'Hide completed' : 'Show completed',
          ),
          // Delete completed tasks
          if (_tasks.any((task) => task.isDone))
            IconButton(
              onPressed: _deleteCompletedTasks,
              icon: const Icon(Icons.delete_sweep),
              tooltip: 'Delete completed',
            ),
          // Refresh
          IconButton(
            onPressed: _loadTasks,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh tasks',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search tasks...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          _searchTasks('');
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
              ),
              onChanged: _searchTasks,
            ),
          ),

          // Tasks list
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage != null
                    ? _buildErrorView()
                    : _filteredTasks.isEmpty
                        ? _buildEmptyView()
                        : _buildTasksList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskEditor(),
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Build error view
  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to load tasks',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            _errorMessage!,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadTasks,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  /// Build empty view
  Widget _buildEmptyView() {
    final message = _searchQuery.isNotEmpty
        ? 'No tasks found for "$_searchQuery"'
        : _showCompleted
            ? 'No tasks yet. Create your first task!'
            : 'No pending tasks';

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _searchQuery.isNotEmpty ? Icons.search_off : Icons.task_alt,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          if (_searchQuery.isEmpty && _showCompleted) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _showTaskEditor(),
              child: const Text('Add Task'),
            ),
          ],
        ],
      ),
    );
  }

  /// Build tasks list with pull-to-refresh
  Widget _buildTasksList() {
    return RefreshIndicator(
      onRefresh: _loadTasks,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filteredTasks.length,
        itemBuilder: (context, index) {
          final task = _filteredTasks[index];
          return _buildTaskCard(task);
        },
      ),
    );
  }

  /// Build individual task card
  Widget _buildTaskCard(Task task) {
    return Dismissible(
      key: Key('task_${task.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) => _deleteTask(task),
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: CheckboxListTile(
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.isDone ? TextDecoration.lineThrough : null,
              color: task.isDone ? Colors.grey.shade600 : null,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (task.notes != null && task.notes!.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  task.notes!,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 4),
              Text(
                DateFormats.getFriendlyDate(task.createdAt),
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          value: task.isDone,
          onChanged: (value) => _toggleTaskCompletion(task),
          secondary: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => _showTaskEditor(task),
                icon: const Icon(Icons.edit),
                tooltip: 'Edit task',
              ),
              IconButton(
                onPressed: () => _deleteTask(task),
                icon: const Icon(Icons.delete),
                tooltip: 'Delete task',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
