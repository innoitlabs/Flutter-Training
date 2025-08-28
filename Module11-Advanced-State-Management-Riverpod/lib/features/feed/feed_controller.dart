import 'package:flutter_riverpod/flutter_riverpod.dart';

// AsyncNotifier for complex async state management
// Provides more control over loading, error, and success states
// Useful when you need to handle complex async operations with custom logic
class FeedController extends AsyncNotifier<List<String>> {
  @override
  Future<List<String>> build() async {
    // This method is called when the provider is first created
    // or when the provider is refreshed
    return _fetchFeedItems();
  }

  // Fetch feed items with simulated network delay
  Future<List<String>> _fetchFeedItems() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Simulate random error (5% chance)
    if (DateTime.now().millisecond % 20 == 0) {
      throw Exception('Network error: Failed to fetch feed items');
    }
    
    return [
      '🎯 AsyncNotifier Example',
      '🔄 Pull to refresh supported',
      '⚡ Optimistic updates',
      '🛡️ Error handling',
      '📊 Loading states',
      '🎨 Custom UI states',
    ];
  }

  // Refresh the feed data
  Future<void> refresh() async {
    // Set loading state
    state = const AsyncValue.loading();
    
    try {
      // Fetch new data
      final items = await _fetchFeedItems();
      state = AsyncValue.data(items);
    } catch (error, stackTrace) {
      // Handle error
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Add a new item to the feed
  Future<void> addItem(String item) async {
    if (item.trim().isEmpty) return;

    // Get current data
    final currentData = state.value;
    if (currentData == null) return;

    // Optimistic update - add item immediately
    state = AsyncValue.data([...currentData, item]);

    try {
      // Simulate API call to add item
      await Future.delayed(const Duration(milliseconds: 500));
      
      // In a real app, you would make an API call here
      // If the API call fails, you might want to revert the optimistic update
      
    } catch (error, _) {
      // Revert optimistic update on error
      state = AsyncValue.data(currentData);
      // You might want to show an error message here
    }
  }

  // Remove an item from the feed
  Future<void> removeItem(int index) async {
    final currentData = state.value;
    if (currentData == null || index < 0 || index >= currentData.length) return;

    // Optimistic update - remove item immediately
    final newData = List<String>.from(currentData);
    newData.removeAt(index);
    state = AsyncValue.data(newData);

    try {
      // Simulate API call to remove item
      await Future.delayed(const Duration(milliseconds: 300));
      
      // In a real app, you would make an API call here
      
    } catch (error, _) {
      // Revert optimistic update on error
      state = AsyncValue.data(currentData);
    }
  }

  // Clear all items
  Future<void> clearAll() async {
    final currentData = state.value;
    if (currentData == null) return;

    // Optimistic update
    state = const AsyncValue.data([]);

    try {
      // Simulate API call to clear all items
      await Future.delayed(const Duration(milliseconds: 400));
      
    } catch (error, _) {
      // Revert optimistic update on error
      state = AsyncValue.data(currentData);
    }
  }

  // Get current item count
  int get itemCount => state.value?.length ?? 0;

  // Check if feed is empty
  bool get isEmpty => itemCount == 0;

  // Check if feed is loading
  bool get isLoading => state.isLoading;

  // Check if feed has error
  bool get hasError => state.hasError;
}
