/// Task model representing a user task with all necessary fields
/// Includes JSON serialization and database mapping methods
class Task {
  final int? id;
  final String title;
  final String? notes;
  final bool isDone;
  final DateTime createdAt;

  const Task({
    this.id,
    required this.title,
    this.notes,
    this.isDone = false,
    required this.createdAt,
  });

  /// Create a Task from a database row (Map)
  /// Handles null safety and type conversion
  factory Task.fromMap(Map<String, Object?> row) {
    return Task(
      id: row['id'] as int?,
      title: row['title'] as String,
      notes: row['notes'] as String?,
      isDone: (row['isDone'] as int) == 1, // SQLite stores bool as int
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        row['createdAt'] as int,
      ),
    );
  }

  /// Convert Task to a database row (Map)
  /// Handles type conversion for SQLite storage
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'notes': notes,
      'isDone': isDone ? 1 : 0, // Convert bool to int for SQLite
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  /// Create a copy of this Task with updated fields
  /// Useful for updating individual fields without creating a new instance
  Task copyWith({
    int? id,
    String? title,
    String? notes,
    bool? isDone,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Create a Task from JSON (for API responses or file storage)
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int?,
      title: json['title'] as String,
      notes: json['notes'] as String?,
      isDone: json['isDone'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  /// Convert Task to JSON (for API requests or file storage)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'notes': notes,
      'isDone': isDone,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Create a new Task with current timestamp
  /// Convenience factory for creating new tasks
  factory Task.create({
    required String title,
    String? notes,
  }) {
    return Task(
      title: title,
      notes: notes,
      createdAt: DateTime.now(),
    );
  }

  /// Check if the task is completed
  bool get isCompleted => isDone;

  /// Check if the task is pending
  bool get isPending => !isDone;

  /// Get a short preview of the task title
  String get titlePreview {
    if (title.length <= 50) return title;
    return '${title.substring(0, 47)}...';
  }

  /// Get a short preview of the task notes
  String? get notesPreview {
    if (notes == null || notes!.isEmpty) return null;
    if (notes!.length <= 100) return notes;
    return '${notes!.substring(0, 97)}...';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Task &&
        other.id == id &&
        other.title == title &&
        other.notes == notes &&
        other.isDone == isDone &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return Object.hash(id, title, notes, isDone, createdAt);
  }

  @override
  String toString() {
    return 'Task(id: $id, title: $title, isDone: $isDone, createdAt: $createdAt)';
  }
}
