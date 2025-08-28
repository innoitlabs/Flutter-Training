import '../../../core/result.dart';
import '../../../core/exceptions.dart';

/// Feed item model
class FeedItem {
  final String id;
  final String title;
  final String content;
  final DateTime publishedAt;
  final String author;

  FeedItem({
    required this.id,
    required this.title,
    required this.content,
    DateTime? publishedAt,
    required this.author,
  }) : publishedAt = publishedAt ?? DateTime.now();

  @override
  String toString() => 'FeedItem(id: $id, title: $title)';
}

/// Abstract repository for feed operations
abstract class FeedRepository {
  /// Fetch feed items for a specific page
  Future<Result<List<FeedItem>>> fetchFeed(int page, {int pageSize = 10});
}

/// Mock implementation of FeedRepository
/// This demonstrates async operations with pagination and error simulation
class MockFeedRepository implements FeedRepository {
  static const int _totalItems = 50;
  static const int _pageSize = 10;
  static const Duration _delay = Duration(milliseconds: 800);
  
  // Simulate network failures
  static const double _errorRate = 0.1; // 10% chance of error

  @override
  Future<Result<List<FeedItem>>> fetchFeed(int page, {int pageSize = 10}) async {
    await Future.delayed(_delay);
    
    // Simulate network errors
    if (page > 1 && _shouldSimulateError()) {
      return const Result.error(NetworkException('Network error occurred'));
    }
    
    // Simulate server errors for specific pages
    if (page == 3) {
      return const Result.error(ServerException('Server temporarily unavailable'));
    }
    
    // Calculate pagination
    final startIndex = (page - 1) * pageSize;
    final endIndex = startIndex + pageSize;
    
    if (startIndex >= _totalItems) {
      return const Result.success([]); // No more items
    }
    
    // Generate mock feed items
    final items = <FeedItem>[];
    for (int i = startIndex; i < endIndex && i < _totalItems; i++) {
      items.add(FeedItem(
        id: 'feed_$i',
        title: 'Feed Item ${i + 1}',
        content: 'This is the content for feed item ${i + 1}. '
            'It contains some sample text to demonstrate pagination '
            'and async loading in the BLoC pattern.',
        publishedAt: DateTime.now().subtract(Duration(hours: i)),
        author: 'Author ${(i % 5) + 1}',
      ));
    }
    
    return Result.success(items);
  }
  
  /// Simulate random network errors
  bool _shouldSimulateError() {
    return (DateTime.now().millisecondsSinceEpoch % 100) < (_errorRate * 100);
  }
}
