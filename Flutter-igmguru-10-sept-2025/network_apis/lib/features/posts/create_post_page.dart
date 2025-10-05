import 'package:flutter/material.dart';
import 'package:network_apis/features/posts/post_model.dart';
import 'package:network_apis/features/posts/posts_service.dart';
import 'package:network_apis/network/api_result.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final PostsService _postsService = PostsService();

  ApiResult<Post> _submitResult = const ApiLoading();
  bool _isSubmitting = false;

  @override
  void dispose() {

    _titleController.dispose();
    _bodyController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter post title',
                    prefixIcon: Icon(Icons.title)
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  enabled: !_isSubmitting,
                ),
                const SizedBox(height: 16,),
                Expanded(
                    child: TextFormField(
                      controller: _bodyController,
                      decoration: const InputDecoration(
                        labelText: 'Body',
                        hintText: 'Enter post content',
                        prefixIcon: Icon(Icons.article),
                        alignLabelWithHint: true,
                      ),
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Body is required';
                        }
                        if (value.trim().length < 10) {
                          return 'Body must be at least 10 characters';
                        }
                        return null;
                      },
                      enabled: !_isSubmitting,
                    )
                ),
                const SizedBox(height: 16,),

                // Submit button
                ElevatedButton.icon(
                  onPressed: null,
                  icon: _isSubmitting
                      ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Icon(Icons.send),
                  label: Text(_isSubmitting ? 'Creating...' : 'Create Post'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),

              ],
            )),
      ),
    );
  }
}
