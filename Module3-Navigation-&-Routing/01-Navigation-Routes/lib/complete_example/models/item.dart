/// Model class representing an item in the app
class Item {
  final String id;
  final String title;
  final String description;
  final bool isFavorite;
  final DateTime createdAt;
  final String? imageUrl;

  const Item({
    required this.id,
    required this.title,
    required this.description,
    this.isFavorite = false,
    required this.createdAt,
    this.imageUrl,
  });

  /// Create a copy of this item with updated properties
  Item copyWith({
    String? id,
    String? title,
    String? description,
    bool? isFavorite,
    DateTime? createdAt,
    String? imageUrl,
  }) {
    return Item(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  /// Convert item to a map for serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isFavorite': isFavorite,
      'createdAt': createdAt.toIso8601String(),
      'imageUrl': imageUrl,
    };
  }

  /// Create an item from a map
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      isFavorite: map['isFavorite'] as bool? ?? false,
      createdAt: DateTime.parse(map['createdAt'] as String),
      imageUrl: map['imageUrl'] as String?,
    );
  }

  @override
  String toString() {
    return 'Item(id: $id, title: $title, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Item && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
