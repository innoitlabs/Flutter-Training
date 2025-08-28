import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Reusable widget for handling AsyncValue states
// This demonstrates best practices for handling loading, error, and success states
class AsyncValueView<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final Widget Function(Object error, StackTrace? stackTrace)? error;
  final Widget? loading;
  final VoidCallback? onRetry;

  const AsyncValueView({
    super.key,
    required this.value,
    required this.data,
    this.error,
    this.loading,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => loading ?? const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => this.error?.call(error, stackTrace) ??
          _DefaultErrorWidget(
            error: error,
            onRetry: onRetry,
          ),
    );
  }
}

// Default error widget when no custom error widget is provided
class _DefaultErrorWidget extends StatelessWidget {
  final Object error;
  final VoidCallback? onRetry;

  const _DefaultErrorWidget({
    required this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Extension to make AsyncValueView easier to use
extension AsyncValueViewExtension<T> on AsyncValue<T> {
  Widget whenView({
    required Widget Function(T data) data,
    Widget Function(Object error, StackTrace? stackTrace)? error,
    Widget? loading,
    VoidCallback? onRetry,
  }) {
    return AsyncValueView<T>(
      value: this,
      data: data,
      error: error,
      loading: loading,
      onRetry: onRetry,
    );
  }
}
