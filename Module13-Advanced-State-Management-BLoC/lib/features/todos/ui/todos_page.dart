import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todos_bloc.dart';
import '../bloc/todos_event.dart';
import '../bloc/todos_state.dart';
import '../bloc/todo_stats_bloc.dart';
import '../bloc/todo_stats_bloc.dart' as stats;
import '../data/todo_model.dart';
import 'todo_editor_sheet.dart';

/// Todos page demonstrates complex BLoC UI patterns:
/// - MultiBlocBuilder for multiple BLoCs
/// - Filtering and state management
/// - CRUD operations with proper error handling
/// - BLoC composition with stats
class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  @override
  void initState() {
    super.initState();
    // Load todos when page is initialized
    context.read<TodosBloc>().add(const TodosLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos BLoC'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          BlocBuilder<TodosBloc, TodosState>(
            buildWhen: (previous, current) => 
                previous.hasCompletedTodos != current.hasCompletedTodos,
            builder: (context, state) {
              if (state.hasCompletedTodos) {
                return IconButton(
                  onPressed: () {
                    context.read<TodosBloc>().add(const TodosClearCompleted());
                  },
                  icon: const Icon(Icons.clear_all),
                  tooltip: 'Clear completed',
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocListener<TodosBloc, TodosState>(
        listener: (context, state) {
          // Show error messages
          if (state.status == TodosStatus.failure && state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Column(
          children: [
            // Stats section
            _buildStatsSection(),
            // Filter tabs
            _buildFilterTabs(),
            // Todos list
            Expanded(child: _buildTodosList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final todosBloc = context.read<TodosBloc>();
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => BlocProvider.value(
              value: todosBloc,
              child: const TodoEditorSheet(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Builds the statistics section using TodoStatsBloc
  Widget _buildStatsSection() {
    return BlocBuilder<stats.TodoStatsBloc, stats.TodoStatsState>(
      builder: (context, statsState) {
        if (!statsState.hasTodos) {
          return const SizedBox.shrink();
        }

        return Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Progress',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: statsState.completionRate / 100,
                  backgroundColor: Colors.grey[300],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('Total', statsState.totalTodos, Icons.list),
                    _buildStatItem('Active', statsState.activeTodos, Icons.pending),
                    _buildStatItem('Completed', statsState.completedTodos, Icons.check_circle),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${statsState.completionRate.toStringAsFixed(1)}% Complete',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds a single stat item
  Widget _buildStatItem(String label, int count, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20),
        const SizedBox(height: 4),
        Text(
          '$count',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  /// Builds the filter tabs
  Widget _buildFilterTabs() {
    return BlocBuilder<TodosBloc, TodosState>(
      buildWhen: (previous, current) => 
          previous.activeFilter != current.activeFilter,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SegmentedButton<TodoFilter>(
            segments: const [
              ButtonSegment(
                value: TodoFilter.all,
                label: Text('All'),
                icon: Icon(Icons.list),
              ),
              ButtonSegment(
                value: TodoFilter.active,
                label: Text('Active'),
                icon: Icon(Icons.pending),
              ),
              ButtonSegment(
                value: TodoFilter.completed,
                label: Text('Completed'),
                icon: Icon(Icons.check_circle),
              ),
            ],
            selected: {state.activeFilter},
            onSelectionChanged: (Set<TodoFilter> selection) {
              final filter = selection.first;
              context.read<TodosBloc>().add(TodosFilterChanged(filter));
            },
          ),
        );
      },
    );
  }

  /// Builds the todos list
  Widget _buildTodosList() {
    return BlocBuilder<TodosBloc, TodosState>(
      buildWhen: (previous, current) => 
          previous.filteredTodos != current.filteredTodos ||
          previous.status != current.status,
      builder: (context, state) {
        if (state.status == TodosStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == TodosStatus.failure && state.todos.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'Failed to load todos',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    context.read<TodosBloc>().add(const TodosLoad());
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state.filteredTodos.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  state.todos.isEmpty ? Icons.note_add : Icons.filter_list,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  state.todos.isEmpty 
                      ? 'No todos yet'
                      : 'No ${state.activeFilter.name} todos',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                if (state.todos.isEmpty)
                  ElevatedButton(
                    onPressed: () {
                      final todosBloc = context.read<TodosBloc>();
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => BlocProvider.value(
                          value: todosBloc,
                          child: const TodoEditorSheet(),
                        ),
                      );
                    },
                    child: const Text('Add your first todo'),
                  ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: state.filteredTodos.length,
          itemBuilder: (context, index) {
            final todo = state.filteredTodos[index];
            return _buildTodoItem(todo);
          },
        );
      },
    );
  }

  /// Builds a single todo item
  Widget _buildTodoItem(Todo todo) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (value) {
            context.read<TodosBloc>().add(TodoToggle(todo.id));
          },
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted 
                ? TextDecoration.lineThrough 
                : null,
            color: todo.isCompleted 
                ? Colors.grey[600] 
                : null,
          ),
        ),
        subtitle: todo.description != null
            ? Text(
                todo.description!,
                style: TextStyle(
                  decoration: todo.isCompleted 
                      ? TextDecoration.lineThrough 
                      : null,
                  color: todo.isCompleted 
                      ? Colors.grey[500] 
                      : null,
                ),
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                final todosBloc = context.read<TodosBloc>();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => BlocProvider.value(
                    value: todosBloc,
                    child: TodoEditorSheet(todo: todo),
                  ),
                );
              },
              icon: const Icon(Icons.edit),
              tooltip: 'Edit',
            ),
            IconButton(
              onPressed: () {
                context.read<TodosBloc>().add(TodoDelete(todo.id));
              },
              icon: const Icon(Icons.delete),
              tooltip: 'Delete',
            ),
          ],
        ),
      ),
    );
  }
}
