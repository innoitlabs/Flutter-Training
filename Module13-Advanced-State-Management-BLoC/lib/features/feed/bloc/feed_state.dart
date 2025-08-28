import 'package:equatable/equatable.dart';
import '../data/feed_repository.dart';

/// Status of the feed operation
enum FeedStatus {
  initial,
  loading,
  moreLoading,
  success,
  failure,
  endReached,
}

/// State representing the feed with pagination support
/// This demonstrates complex state management for async operations
class FeedState extends Equatable {
  final FeedStatus status;
  final List<FeedItem> items;
  final int currentPage;
  final bool hasReachedEnd;
  final String? errorMessage;
  final bool canLoadMore;

  const FeedState({
    this.status = FeedStatus.initial,
    this.items = const [],
    this.currentPage = 0,
    this.hasReachedEnd = false,
    this.errorMessage,
    this.canLoadMore = true,
  });

  /// Factory constructor for initial state
  const FeedState.initial() : this();

  /// Factory constructor for loading state
  const FeedState.loading() : this(status: FeedStatus.loading);

  /// Factory constructor for more loading state
  const FeedState.moreLoading({
    required List<FeedItem> items,
    required int currentPage,
  }) : this(
          status: FeedStatus.moreLoading,
          items: items,
          currentPage: currentPage,
        );

  /// Factory constructor for success state
  const FeedState.success({
    required List<FeedItem> items,
    required int currentPage,
    bool hasReachedEnd = false,
  }) : this(
          status: FeedStatus.success,
          items: items,
          currentPage: currentPage,
          hasReachedEnd: hasReachedEnd,
          canLoadMore: !hasReachedEnd,
        );

  /// Factory constructor for failure state
  const FeedState.failure({
    required String errorMessage,
    List<FeedItem> items = const [],
    int currentPage = 0,
  }) : this(
          status: FeedStatus.failure,
          items: items,
          currentPage: currentPage,
          errorMessage: errorMessage,
        );

  /// Factory constructor for end reached state
  const FeedState.endReached({
    required List<FeedItem> items,
    required int currentPage,
  }) : this(
          status: FeedStatus.endReached,
          items: items,
          currentPage: currentPage,
          hasReachedEnd: true,
          canLoadMore: false,
        );

  /// Check if the feed is empty
  bool get isEmpty => items.isEmpty;

  /// Check if the feed has items
  bool get hasItems => items.isNotEmpty;

  /// Check if currently loading
  bool get isLoading => status == FeedStatus.loading;

  /// Check if loading more items
  bool get isLoadingMore => status == FeedStatus.moreLoading;

  /// Check if in error state
  bool get hasError => status == FeedStatus.failure;

  /// Creates a copy of this state with updated values
  FeedState copyWith({
    FeedStatus? status,
    List<FeedItem>? items,
    int? currentPage,
    bool? hasReachedEnd,
    String? errorMessage,
    bool? canLoadMore,
  }) {
    return FeedState(
      status: status ?? this.status,
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      errorMessage: errorMessage ?? this.errorMessage,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }

  @override
  List<Object?> get props => [
        status,
        items,
        currentPage,
        hasReachedEnd,
        errorMessage,
        canLoadMore,
      ];

  @override
  String toString() => 'FeedState(status: $status, items: ${items.length}, currentPage: $currentPage, hasReachedEnd: $hasReachedEnd, errorMessage: $errorMessage)';
}
