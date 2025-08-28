class Note {
  final String id;
  final String title;
  final String content;
  final DateTime timestamp;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.timestamp,
  });

  String get formattedTimestamp {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }

  Note copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? timestamp,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Note && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Note(id: $id, title: $title, content: $content, timestamp: $timestamp)';
  }
}
