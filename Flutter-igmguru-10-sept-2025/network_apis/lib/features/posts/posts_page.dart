import 'package:flutter/material.dart';
import 'package:network_apis/features/posts/post_model.dart';
import 'package:network_apis/features/posts/posts_service.dart';
import 'package:network_apis/network/api_result.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final PostsService _postsService = PostsService();
  ApiResult<List<Post>> _postsResult = const ApiLoading();

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts({bool forceRefresh = false}) async {
    if(!mounted) return;

    setState(() {
      _postsResult = const ApiLoading();
    });

    final result = await _postsService.getPosts(forceRefresh: forceRefresh);

    setState(() {
      _postsResult = result;
    });
  }

  // Handle pull-to-refresh
  Future<void> _onRefresh() async {
    await _loadPosts(forceRefresh: true);
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
          child: _buildBody()
      ),
    );
  }

  Widget _buildBody(){
    return switch (_postsResult) {
      ApiLoading() => _buildLoadingState(),
    ApiSuccess() => _buildSuccessState(),
    ApiError() => _buildErrorState()
    };
  }

  Widget _buildLoadingState(){
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessState(){
    final posts = _postsResult.data!;
    if(posts.isEmpty){
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.article_outlined, size: 64, color: Colors.grey,),
            SizedBox(height: 16,),
            Text('No posts found',
            style: TextStyle(fontSize: 18, color: Colors.grey),),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
        itemCount: posts.length,
        itemBuilder: (context, index){
          final post = posts[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(
                post.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4,),
                  Text(post.body, maxLines: 3, overflow: TextOverflow.ellipsis,),
                  const SizedBox(height: 8,),
                  Row(
                    children: [
                      Icon(Icons.person_outline,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 4,),
                      Text(
                        'User ${post.userId}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.tag,
                        size: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4,),
                      Text(
                        'ID : ${post.id}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ),
          );
        }
    );
  }

  Widget _buildErrorState() {
    final errorMessage = _postsResult.errorMessage ?? 'An error occured';
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
            size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16,),
            Text(
              'Oops!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              )
            ),
            const SizedBox(height: 8,),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16,),
            ElevatedButton.icon(
              onPressed: _loadPosts,
              label: const Text('Retry'),
              icon: const Icon(Icons.refresh),
            )
          ]
        ),
      ),
    );

  }
}
