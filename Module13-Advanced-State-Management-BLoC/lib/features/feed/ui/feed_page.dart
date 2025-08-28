import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/feed_bloc.dart';
import '../bloc/feed_event.dart';
import '../bloc/feed_state.dart';
import '../data/feed_repository.dart';

/// Feed page demonstrates advanced BLoC UI patterns:
/// - Complex async state handling
/// - Pagination with load more functionality
/// - Error handling with retry mechanisms
/// - Pull-to-refresh functionality
class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Load first page when page is initialized
    context.read<FeedBloc>().add(const FeedFetchFirstPage());
    
    // Listen for scroll events to implement infinite scroll
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Handle scroll events for infinite scroll
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final feedBloc = context.read<FeedBloc>();
      final state = feedBloc.state;
      
      if (state.canLoadMore && !state.isLoadingMore && !state.hasReachedEnd) {
        feedBloc.add(const FeedFetchNextPage());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed BLoC'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          BlocBuilder<FeedBloc, FeedState>(
            buildWhen: (previous, current) => 
                previous.hasItems != current.hasItems,
            builder: (context, state) {
              if (state.hasItems) {
                return IconButton(
                  onPressed: () {
                    context.read<FeedBloc>().add(const FeedRefresh());
                  },
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Refresh',
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<FeedBloc>().add(const FeedRefresh());
        },
        child: BlocBuilder<FeedBloc, FeedState>(
          builder: (context, state) {
            return _buildBody(state);
          },
        ),
      ),
    );
  }

  /// Builds the main body based on current state
  Widget _buildBody(FeedState state) {
    if (state.status == FeedStatus.initial) {
      return const Center(
        child: Text('Pull to refresh to load feed'),
      );
    }

    if (state.status == FeedStatus.loading && state.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading feed...'),
          ],
        ),
      );
    }

    if (state.status == FeedStatus.failure && state.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load feed',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              state.errorMessage ?? 'Unknown error',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                context.read<FeedBloc>().add(const FeedRetry());
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.rss_feed_outlined,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text('No feed items available'),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: state.items.length + _buildTrailingWidgets(state).length,
      itemBuilder: (context, index) {
        if (index < state.items.length) {
          return _buildFeedItem(state.items[index]);
        } else {
          final trailingIndex = index - state.items.length;
          return _buildTrailingWidgets(state)[trailingIndex];
        }
      },
    );
  }

  /// Builds a single feed item
  Widget _buildFeedItem(FeedItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.person,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  item.author,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              item.content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 14,
                  color: Colors.grey[500],
                ),
                const SizedBox(width: 4),
                Text(
                  _formatDateTime(item.publishedAt),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Builds trailing widgets (loading indicator, error banner, end message)
  List<Widget> _buildTrailingWidgets(FeedState state) {
    final widgets = <Widget>[];

    // Show error banner if there's an error but we have items
    if (state.hasError && state.hasItems) {
      widgets.add(
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.red[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red[600]),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  state.errorMessage ?? 'An error occurred',
                  style: TextStyle(color: Colors.red[700]),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<FeedBloc>().add(const FeedRetry());
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    // Show loading indicator for pagination
    if (state.isLoadingMore) {
      widgets.add(
        const Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    // Show end reached message
    if (state.hasReachedEnd && state.hasItems) {
      widgets.add(
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green[600]),
              const SizedBox(width: 8),
              Text(
                'You\'ve reached the end of the feed',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      );
    }

    return widgets;
  }

  /// Formats date time for display
  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

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
}
