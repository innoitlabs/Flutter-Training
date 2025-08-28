import 'package:flutter/material.dart';
import '../data/todo_repository.dart';
import '../data/todo_model.dart';
import '../../../shared/widgets/app_scaffold.dart';

class TodosPage extends StatefulWidget {
  final TodoRepository? repository;
  
  const TodosPage({super.key, this.repository});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  late final TodoRepository _repository;
  final TextEditingController _textController = TextEditingController();
  
  List<Todo> _todos = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _repository = widget.repository ?? InMemoryTodoRepository();
    _loadTodos();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _loadTodos() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final todos = await _repository.fetchTodos();
      setState(() {
        _todos = todos;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _addTodo() async {
    final title = _textController.text.trim();
    if (title.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final todo = await _repository.addTodo(title);
      setState(() {
        _todos.add(todo);
        _isLoading = false;
      });
      _textController.clear();
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleTodo(String id) async {
    try {
      final updatedTodo = await _repository.toggleTodo(id);
      setState(() {
        final index = _todos.indexWhere((todo) => todo.id == id);
        if (index != -1) {
          _todos[index] = updatedTodo;
        }
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  Future<void> _deleteTodo(String id) async {
    try {
      final success = await _repository.deleteTodo(id);
      if (success) {
        setState(() {
          _todos.removeWhere((todo) => todo.id == id);
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Add todo section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Enter a new todo',
                      border: OutlineInputBorder(),
                    ),
                    key: const Key('todo_input'),
                    onSubmitted: (_) => _addTodo(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _isLoading ? null : _addTodo,
                  key: const Key('add_todo_button'),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          
          // Error display
          if (_error != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _error!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
                key: const Key('error_message'),
              ),
            ),
          
          // Loading indicator
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                key: Key('loading_indicator'),
              ),
            ),
          
          // Todos list
          Expanded(
            child: _todos.isEmpty && !_isLoading
                ? const Center(
                    child: Text(
                      'No todos yet. Add one above!',
                      style: TextStyle(fontSize: 16),
                      key: Key('empty_state'),
                    ),
                  )
                : ListView.builder(
                    itemCount: _todos.length,
                    itemBuilder: (context, index) {
                      final todo = _todos[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 4.0,
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: todo.isCompleted,
                            onChanged: (_) => _toggleTodo(todo.id),
                            key: Key('checkbox_${todo.id}'),
                          ),
                          title: Text(
                            todo.title,
                            style: TextStyle(
                              decoration: todo.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                            key: Key('todo_title_${todo.id}'),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteTodo(todo.id),
                            key: Key('delete_button_${todo.id}'),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
