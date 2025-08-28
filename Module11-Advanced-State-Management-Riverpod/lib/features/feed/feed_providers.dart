import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'feed_controller.dart';

// FutureProvider for one-time async operations
// Simulates fetching data from an API
final feedItemsProvider = FutureProvider<List<String>>((ref) async {
  // Simulate network delay
  await Future.delayed(const Duration(seconds: 2));
  
  // Simulate random error (10% chance)
  if (DateTime.now().millisecond % 10 == 0) {
    throw Exception('Failed to load feed items');
  }
  
  return [
    '🚀 Welcome to RiverpodHub!',
    '📚 Learn state management with Riverpod',
    '⚡ Build reactive Flutter apps',
    '🎯 Master dependency injection',
    '🧪 Write better tests',
    '🔥 Create amazing user experiences',
  ];
});

// StreamProvider for continuous data streams
// Simulates a real-time ticker or live data
final tickerProvider = StreamProvider<int>((ref) {
  return Stream.periodic(
    const Duration(seconds: 1),
    (computationCount) => computationCount,
  );
});

// Auto-dispose FutureProvider that cancels when not in use
// Demonstrates resource management and cancellation
final autoDisposeFeedProvider = FutureProvider.autoDispose<List<String>>((ref) async {
  // This provider will be disposed when no longer watched
  // Useful for expensive operations or when you want fresh data each time
  
  // Simulate network delay
  await Future.delayed(const Duration(seconds: 1));
  
  return [
    '🔄 Auto-dispose provider',
    '🗑️ Will be disposed when not used',
    '🆕 Fresh data each time',
  ];
});

// AsyncNotifierProvider for complex async state management
// Provides more control over loading, error, and success states
final feedControllerProvider = AsyncNotifierProvider<FeedController, List<String>>(
  () => FeedController(),
);

// Derived provider that combines multiple async sources
final combinedFeedProvider = Provider<AsyncValue<Map<String, dynamic>>>((ref) {
  final feedItems = ref.watch(feedItemsProvider);
  final ticker = ref.watch(tickerProvider);
  
  // Combine both async values
  return feedItems.when(
    data: (items) => ticker.when(
      data: (count) => AsyncValue.data({
        'items': items,
        'ticker': count,
        'timestamp': DateTime.now().toIso8601String(),
      }),
      loading: () => const AsyncValue.loading(),
      error: (error, stack) => AsyncValue.error(error, stack),
    ),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

// Provider for feed statistics
final feedStatsProvider = Provider<AsyncValue<Map<String, int>>>((ref) {
  final feedItems = ref.watch(feedItemsProvider);
  
  return feedItems.when(
    data: (items) => AsyncValue.data({
      'total_items': items.length,
      'characters': items.fold(0, (sum, item) => sum + item.length),
      'emojis': items.where((item) => item.contains('🚀') || 
                                      item.contains('📚') || 
                                      item.contains('⚡') ||
                                      item.contains('🎯') ||
                                      item.contains('🧪') ||
                                      item.contains('🔥') ||
                                      item.contains('🔄') ||
                                      item.contains('🗑️') ||
                                      item.contains('🆕')).length,
    }),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});
