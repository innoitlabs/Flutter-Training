import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_networking_module/features/posts/post_model.dart';

void main() {
  group('Post Model Tests', () {
    test('should create Post from JSON', () {
      // Arrange
      final json = {
        'id': 1,
        'userId': 2,
        'title': 'Test Title',
        'body': 'Test Body',
      };

      // Act
      final post = Post.fromJson(json);

      // Assert
      expect(post.id, 1);
      expect(post.userId, 2);
      expect(post.title, 'Test Title');
      expect(post.body, 'Test Body');
    });

    test('should handle missing JSON fields with defaults', () {
      // Arrange
      final json = {
        'id': 1,
        // Missing userId, title, body
      };

      // Act
      final post = Post.fromJson(json);

      // Assert
      expect(post.id, 1);
      expect(post.userId, 0); // Default value
      expect(post.title, ''); // Default value
      expect(post.body, ''); // Default value
    });

    test('should convert Post to JSON', () {
      // Arrange
      const post = Post(
        id: 1,
        userId: 2,
        title: 'Test Title',
        body: 'Test Body',
      );

      // Act
      final json = post.toJson();

      // Assert
      expect(json['id'], 1);
      expect(json['userId'], 2);
      expect(json['title'], 'Test Title');
      expect(json['body'], 'Test Body');
    });

    test('should create CreatePostRequest correctly', () {
      // Arrange & Act
      const request = CreatePostRequest(
        title: 'New Post',
        body: 'New Post Body',
        userId: 5,
      );

      // Assert
      expect(request.title, 'New Post');
      expect(request.body, 'New Post Body');
      expect(request.userId, 5);
    });

    test('should convert CreatePostRequest to JSON', () {
      // Arrange
      const request = CreatePostRequest(
        title: 'New Post',
        body: 'New Post Body',
        userId: 5,
      );

      // Act
      final json = request.toJson();

      // Assert
      expect(json['title'], 'New Post');
      expect(json['body'], 'New Post Body');
      expect(json['userId'], 5);
    });
  });
}
