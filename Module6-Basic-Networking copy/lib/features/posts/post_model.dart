/// Post model representing a blog post
class Post {
  final int id;
  final int userId;
  final String title;
  final String body;
  
  const Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });
  
  /// Create Post from JSON with null safety
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
    );
  }
  
  /// Convert Post to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }
  
  /// Create a copy of this Post with updated fields
  Post copyWith({
    int? id,
    int? userId,
    String? title,
    String? body,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Post &&
        other.id == id &&
        other.userId == userId &&
        other.title == title &&
        other.body == body;
  }
  
  @override
  int get hashCode {
    return Object.hash(id, userId, title, body);
  }
  
  @override
  String toString() {
    return 'Post(id: $id, userId: $userId, title: $title, body: $body)';
  }
}

/// Create Post request model (for POST requests)
class CreatePostRequest {
  final String title;
  final String body;
  final int userId;
  
  const CreatePostRequest({
    required this.title,
    required this.body,
    this.userId = 1, // Default user ID
  });
  
  /// Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'userId': userId,
    };
  }
  
  @override
  String toString() {
    return 'CreatePostRequest(title: $title, body: $body, userId: $userId)';
  }
}
