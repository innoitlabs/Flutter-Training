import 'package:equatable/equatable.dart';

/// Events that can be dispatched to the FeedBloc
/// This demonstrates async event handling with pagination
abstract class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object?> get props => [];
}

/// Event to fetch the first page of feed items
class FeedFetchFirstPage extends FeedEvent {
  const FeedFetchFirstPage();
}

/// Event to fetch the next page of feed items
class FeedFetchNextPage extends FeedEvent {
  const FeedFetchNextPage();
}

/// Event to refresh the feed (reset to first page)
class FeedRefresh extends FeedEvent {
  const FeedRefresh();
}

/// Event to retry after an error
class FeedRetry extends FeedEvent {
  const FeedRetry();
}
