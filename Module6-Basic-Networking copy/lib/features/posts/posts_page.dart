import 'package:flutter/material.dart';
import '../core/network/api_result.dart';
import 'post_model.dart';
import 'posts_service.dart';
import 'create_post_page.dart';

/// Posts list page with loading, error, and success states
class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final PostsService _postsService = PostsService();
  ApiResult<List<Post>> _postsResult = const ApiLoading();
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  /// Load posts from API
  Future<void> _loadPosts({bool forceRefresh = false}) async {
    if (!mounted) return;
    
    setState(() {
      if (forceRefresh) {
        _isRefreshing = true;
      } else {
        _postsResult = const ApiLoading();
      }
    });

    final result = await _postsService.getPosts(forceRefresh: forceRefresh);
    
    if (!mounted) return;
    
    setState(() {
      _postsResult = result;
      _isRefreshing = false;
    });
  }

  /// Handle pull-to-refresh
  Future<void> _onRefresh() async {
    await _loadPosts(forceRefresh: true);
  }

  /// Navigate to create post page
  Future<void> _navigateToCreatePost() async {
    final result = await Navigator.push<Post>(
      context,
      MaterialPageRoute(
        builder: (context) => const CreatePostPage(),
      ),
    );
    
    // If a new post was created, refresh the list
    if (result != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Post "${result.title}" created successfully!'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
      await _loadPosts(forceRefresh: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: _buildBody(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCreatePost,
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Build the main body based on current state
  Widget _buildBody() {
    return switch (_postsResult) {
      ApiLoading() => _buildLoadingState(),
      ApiSuccess() => _buildSuccessState(),
      ApiError() => _buildErrorState(),
    };
  }

  /// Build loading state
  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading posts...'),
        ],
      ),
    );
  }

  /// Build success state with posts list
  Widget _buildSuccessState() {
    final posts = _postsResult.data!;
    
    if (posts.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.article_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No posts found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text(
              post.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  post.body,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'User ${post.userId}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.tag,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'ID: ${post.id}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            onTap: () {
              // TODO: Navigate to post details page
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Post details coming soon!'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        );
      },
    );
  }

  /// Build error state with retry button
  Widget _buildErrorState() {
    final errorMessage = _postsResult.errorMessage ?? 'An error occurred';
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Oops!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _loadPosts(forceRefresh: true),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
