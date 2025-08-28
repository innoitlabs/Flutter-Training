import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/feed_repository.dart';
import 'feed_event.dart';
import 'feed_state.dart';

/// FeedBloc demonstrates advanced BLoC patterns:
/// - Async operations with pagination
/// - Error handling and retry mechanisms
/// - State management for complex loading scenarios
/// - Debouncing and duplicate request prevention
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedRepository repository;
  bool _isLoading = false;

  FeedBloc({required this.repository}) : super(const FeedState.initial()) {
    // Register event handlers
    on<FeedFetchFirstPage>(_onFetchFirstPage);
    on<FeedFetchNextPage>(_onFetchNextPage);
    on<FeedRefresh>(_onRefresh);
    on<FeedRetry>(_onRetry);
  }

  /// Handles FeedFetchFirstPage events
  /// This demonstrates initial data loading
  Future<void> _onFetchFirstPage(FeedFetchFirstPage event, Emitter<FeedState> emit) async {
    if (_isLoading) return; // Prevent duplicate requests
    
    _isLoading = true;
    emit(const FeedState.loading());
    
    try {
      final result = await repository.fetchFeed(1);
      
      if (result.isSuccess) {
        final items = result.data;
        final hasReachedEnd = items.isEmpty;
        
        emit(FeedState.success(
          items: items,
          currentPage: 1,
          hasReachedEnd: hasReachedEnd,
        ));
      } else {
        emit(FeedState.failure(
          errorMessage: result.exception.toString(),
        ));
      }
    } catch (e) {
      emit(FeedState.failure(errorMessage: e.toString()));
    } finally {
      _isLoading = false;
    }
  }

  /// Handles FeedFetchNextPage events
  /// This demonstrates pagination with proper state management
  Future<void> _onFetchNextPage(FeedFetchNextPage event, Emitter<FeedState> emit) async {
    if (_isLoading || state.hasReachedEnd || !state.canLoadMore) return;
    
    _isLoading = true;
    final nextPage = state.currentPage + 1;
    
    emit(FeedState.moreLoading(
      items: state.items,
      currentPage: state.currentPage,
    ));
    
    try {
      final result = await repository.fetchFeed(nextPage);
      
      if (result.isSuccess) {
        final newItems = result.data;
        final allItems = [...state.items, ...newItems];
        final hasReachedEnd = newItems.isEmpty;
        
        if (hasReachedEnd) {
          emit(FeedState.endReached(
            items: allItems,
            currentPage: nextPage,
          ));
        } else {
          emit(FeedState.success(
            items: allItems,
            currentPage: nextPage,
            hasReachedEnd: false,
          ));
        }
      } else {
        // On error, revert to previous state but keep existing items
        emit(FeedState.failure(
          errorMessage: result.exception.toString(),
          items: state.items,
          currentPage: state.currentPage,
        ));
      }
    } catch (e) {
      emit(FeedState.failure(
        errorMessage: e.toString(),
        items: state.items,
        currentPage: state.currentPage,
      ));
    } finally {
      _isLoading = false;
    }
  }

  /// Handles FeedRefresh events
  /// This demonstrates refresh functionality that resets to first page
  Future<void> _onRefresh(FeedRefresh event, Emitter<FeedState> emit) async {
    // Reset to initial state and fetch first page
    emit(const FeedState.initial());
    add(const FeedFetchFirstPage());
  }

  /// Handles FeedRetry events
  /// This demonstrates retry functionality for error recovery
  Future<void> _onRetry(FeedRetry event, Emitter<FeedState> emit) async {
    if (state.hasItems) {
      // Retry loading next page if we have existing items
      add(const FeedFetchNextPage());
    } else {
      // Retry loading first page if we have no items
      add(const FeedFetchFirstPage());
    }
  }

  @override
  void onTransition(Transition<FeedEvent, FeedState> transition) {
    super.onTransition(transition);
    // Optional: Log transitions for debugging
    // print('${transition.event} -> ${transition.currentState}');
  }
}
