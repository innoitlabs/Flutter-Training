import 'package:equatable/equatable.dart';

/// Todo model representing a task item
/// This demonstrates data modeling for CRUD operations
class Todo extends Equatable {
  final String id;
  final String title;
  final String? description;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? completedAt;

  Todo({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    DateTime? createdAt,
    this.completedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Creates a copy of this todo with updated values
  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  /// Creates a todo with toggled completion status
  Todo toggleCompletion() {
    return copyWith(
      isCompleted: !isCompleted,
      completedAt: !isCompleted ? DateTime.now() : null,
    );
  }

  @override
  List<Object?> get props => [id, title, description, isCompleted, createdAt, completedAt];

  @override
  String toString() => 'Todo(id: $id, title: $title, isCompleted: $isCompleted)';
}
