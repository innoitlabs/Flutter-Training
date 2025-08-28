import 'package:flutter/material.dart';
import '../widgets/styled_widgets.dart';
import '../widgets/theme_switcher.dart';
import '../models/note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Note> _notes = [];
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Add some sample notes
    _notes.addAll([
      Note(
        id: '1',
        title: 'Welcome to Flutter Theming!',
        content: 'This app demonstrates various styling and theming concepts in Flutter.',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Note(
        id: '2',
        title: 'Styling vs Theming',
        content: 'Styling is widget-specific, while theming is app-wide. Use theming for consistency!',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      Note(
        id: '3',
        title: 'Dark Mode Support',
        content: 'Always support both light and dark themes for better user experience.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
    ]);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _addNote() {
    if (_noteController.text.trim().isNotEmpty) {
      setState(() {
        _notes.insert(
          0,
          Note(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: _noteController.text.trim(),
            content: 'New note created at ${DateTime.now().toString().substring(0, 16)}',
            timestamp: DateTime.now(),
          ),
        );
      });
      _noteController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Note added successfully!'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    }
  }

  void _deleteNote(String id) {
    setState(() {
      _notes.removeWhere((note) => note.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Note deleted'),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Styling & Theming'),
        actions: [
          // Theme switcher in app bar
          // const ThemeSwitcher(),
        ],
      ),
      
      body: Column(
        children: [
          // Header section with styled widgets demonstration
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                                 colors: [
                   theme.colorScheme.primary,
                   theme.colorScheme.primary.withValues(alpha: 0.8),
                 ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Styled text example
                Text(
                  'Styling & Theming Demo',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Explore different styling techniques and theme configurations',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Styled buttons demonstration
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Elevated'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: theme.colorScheme.onPrimary,
                          side: BorderSide(color: theme.colorScheme.onPrimary),
                        ),
                        child: const Text('Outlined'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: theme.colorScheme.onPrimary,
                        ),
                        child: const Text('Text'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Notes section
          Expanded(
            child: _notes.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.note_add,
                          size: 64,
                          color: theme.colorScheme.primary.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No notes yet',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Add your first note below',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _notes.length,
                    itemBuilder: (context, index) {
                      final note = _notes[index];
                      return StyledNoteCard(
                        note: note,
                        onDelete: () => _deleteNote(note.id),
                      );
                    },
                  ),
          ),
        ],
      ),
      
      // Add note section
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withValues(alpha: 0.1),
              offset: const Offset(0, -2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _noteController,
                decoration: InputDecoration(
                  hintText: 'Add a new note...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),

              ),
            ),
            const SizedBox(width: 12),
            FloatingActionButton(
              onPressed: _addNote,
              mini: true,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
