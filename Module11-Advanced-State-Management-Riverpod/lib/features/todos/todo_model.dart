// Simple data model for a todo item
class TodoModel {
  final String id;
  final String title;
  final bool done;

  const TodoModel({
    required this.id,
    required this.title,
    this.done = false,
  });

  // Create a copy of this todo with updated fields
  TodoModel copyWith({
    String? id,
    String? title,
    bool? done,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      done: done ?? this.done,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TodoModel &&
        other.id == id &&
        other.title == title &&
        other.done == done;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ done.hashCode;

  @override
  String toString() {
    return 'TodoModel(id: $id, title: $title, done: $done)';
  }
}
