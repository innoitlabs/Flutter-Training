import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo_model.dart';
import 'todo_providers.dart';

class TodosPage extends ConsumerWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos with DI'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Demo button to show dependency injection
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'fake') {
                // Note: In a real app, you would use ProviderScope.override
                // This is just for demonstration purposes
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Fake Repository selected (see README for implementation)'),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else if (value == 'real') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Real Repository selected (see README for implementation)'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'fake',
                child: Text('Use Fake Repository'),
              ),
              const PopupMenuItem(
                value: 'real',
                child: Text('Use Real Repository'),
              ),
            ],
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.settings),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Statistics section
          Consumer(
            builder: (context, ref, child) {
              final stats = ref.watch(todoStatsProvider);
              return Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatItem('Total', stats.total, Colors.blue),
                      _StatItem('Active', stats.active, Colors.orange),
                      _StatItem('Completed', stats.completed, Colors.green),
                    ],
                  ),
                ),
              );
            },
          ),
          
          // Filter section
          Consumer(
            builder: (context, ref, child) {
              final currentFilter = ref.watch(todoFilterProvider);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: SegmentedButton<TodoFilter>(
                        segments: const [
                          ButtonSegment(
                            value: TodoFilter.all,
                            label: Text('All'),
                          ),
                          ButtonSegment(
                            value: TodoFilter.active,
                            label: Text('Active'),
                          ),
                          ButtonSegment(
                            value: TodoFilter.completed,
                            label: Text('Completed'),
                          ),
                        ],
                        selected: {currentFilter},
                        onSelectionChanged: (Set<TodoFilter> selection) {
                          ref.read(todoFilterProvider.notifier).state = selection.first;
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          
          const SizedBox(height: 16),
          
          // Todos list
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final todos = ref.watch(filteredTodosProvider);
                
                if (todos.isEmpty) {
                  return const Center(
                    child: Text(
                      'No todos yet. Add one above!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }
                
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return _TodoItem(todo: todo);
                  },
                );
              },
            ),
          ),
          
          // Action buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(todosNotifierProvider.notifier).markAllCompleted();
                    },
                    child: const Text('Mark All Complete'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(todosNotifierProvider.notifier).clearCompleted();
                    },
                    child: const Text('Clear Completed'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Todo'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Todo title',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              ref.read(todosNotifierProvider.notifier).addTodo(value);
              Navigator.of(context).pop();
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                ref.read(todosNotifierProvider.notifier).addTodo(controller.text);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _StatItem(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class _TodoItem extends ConsumerWidget {
  final TodoModel todo;

  const _TodoItem({required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Checkbox(
          value: todo.done,
          onChanged: (value) {
            ref.read(todosNotifierProvider.notifier).toggleTodo(todo.id);
          },
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.done ? TextDecoration.lineThrough : null,
            color: todo.done ? Colors.grey : null,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            ref.read(todosNotifierProvider.notifier).deleteTodo(todo.id);
          },
        ),
      ),
    );
  }
}
