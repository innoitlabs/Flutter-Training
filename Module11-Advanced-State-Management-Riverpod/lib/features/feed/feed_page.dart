import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/widgets/async_value_view.dart';
import 'feed_providers.dart';

class FeedPage extends ConsumerWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Async Feed Examples'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'FutureProvider'),
              Tab(text: 'StreamProvider'),
              Tab(text: 'AsyncNotifier'),
              Tab(text: 'AutoDispose'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _FutureProviderTab(),
            _StreamProviderTab(),
            _AsyncNotifierTab(),
            _AutoDisposeTab(),
          ],
        ),
      ),
    );
  }
}

class _FutureProviderTab extends ConsumerWidget {
  const _FutureProviderTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedItemsAsync = ref.watch(feedItemsProvider);
    final statsAsync = ref.watch(feedStatsProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Statistics card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: statsAsync.whenView(
                data: (stats) => Column(
                  children: [
                    Text(
                      'Feed Statistics',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatItem('Items', stats['total_items']!),
                        _StatItem('Chars', stats['characters']!),
                        _StatItem('Emojis', stats['emojis']!),
                      ],
                    ),
                  ],
                ),
                loading: const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Text('Error: $error'),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Feed items
          Expanded(
            child: feedItemsAsync.whenView(
              data: (items) => ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(items[index]),
                      subtitle: Text('Item ${index + 1} of ${items.length}'),
                    ),
                  );
                },
              ),
              loading: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading feed items...'),
                  ],
                ),
              ),
              error: (error, stack) => Center(
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
                      'Failed to load feed',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error.toString(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Refresh the provider
                        ref.invalidate(feedItemsProvider);
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StreamProviderTab extends ConsumerWidget {
  const _StreamProviderTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tickerAsync = ref.watch(tickerProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Real-time Ticker',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  tickerAsync.whenView(
                    data: (count) => Text(
                      count.toString(),
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    loading: const CircularProgressIndicator(),
                    error: (error, stack) => Text('Error: $error'),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Updates every second',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Combined feed example
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Combined Data',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Consumer(
                        builder: (context, ref, child) {
                          final combinedAsync = ref.watch(combinedFeedProvider);
                          
                          return combinedAsync.whenView(
                            data: (data) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Ticker: ${data['ticker']}'),
                                Text('Timestamp: ${data['timestamp']}'),
                                const SizedBox(height: 16),
                                const Text('Feed Items:'),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: (data['items'] as List).length,
                                    itemBuilder: (context, index) {
                                      final item = (data['items'] as List)[index];
                                      return ListTile(
                                        dense: true,
                                        title: Text(item),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            loading: const Center(child: CircularProgressIndicator()),
                            error: (error, stack) => Text('Error: $error'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AsyncNotifierTab extends ConsumerWidget {
  const _AsyncNotifierTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedControllerAsync = ref.watch(feedControllerProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ref.read(feedControllerProvider.notifier).refresh();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showAddItemDialog(context, ref),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Item'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ref.read(feedControllerProvider.notifier).clearAll();
                  },
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear All'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Feed items
          Expanded(
            child: feedControllerAsync.whenView(
              data: (items) => items.isEmpty
                  ? const Center(
                      child: Text(
                        'No items yet. Add some!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text('${index + 1}'),
                            ),
                            title: Text(items[index]),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                ref.read(feedControllerProvider.notifier)
                                    .removeItem(index);
                              },
                            ),
                          ),
                        );
                      },
                    ),
              loading: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading...'),
                  ],
                ),
              ),
              error: (error, stack) => Center(
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
                      'Error loading feed',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error.toString(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        ref.read(feedControllerProvider.notifier).refresh();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddItemDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Feed Item'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Item text',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              ref.read(feedControllerProvider.notifier).addItem(value);
              Navigator.of(context).pop();
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                ref.read(feedControllerProvider.notifier).addItem(controller.text);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class _AutoDisposeTab extends ConsumerWidget {
  const _AutoDisposeTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final autoDisposeAsync = ref.watch(autoDisposeFeedProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Auto-dispose Provider',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'This provider will be disposed when you navigate away and recreated when you return.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Auto-dispose feed items
          Expanded(
            child: autoDisposeAsync.whenView(
              data: (items) => ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Text('${index + 1}'),
                      ),
                      title: Text(items[index]),
                      subtitle: const Text('Auto-dispose item'),
                    ),
                  );
                },
              ),
              loading: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading auto-dispose data...'),
                  ],
                ),
              ),
              error: (error, stack) => Center(
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
                      'Auto-dispose error',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error.toString(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final int value;

  const _StatItem(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
