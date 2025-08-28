import 'package:flutter/material.dart';

/// Manual TabController Example
/// 
/// This example demonstrates advanced tab management:
/// - Manual TabController with lifecycle management
/// - State preservation using AutomaticKeepAliveClientMixin
/// - Listening to tab index changes
/// - Proper disposal of controllers
/// - Badge support for tabs
/// 
/// Run this example with: flutter run -t lib/examples/manual_tabs_example.dart
void main() {
  runApp(const ManualTabsExample());
}

class ManualTabsExample extends StatelessWidget {
  const ManualTabsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manual TabController Example',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.green,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
      ),
      home: const ManualTabsScreen(),
    );
  }
}

class ManualTabsScreen extends StatefulWidget {
  const ManualTabsScreen({super.key});

  @override
  State<ManualTabsScreen> createState() => _ManualTabsScreenState();
}

class _ManualTabsScreenState extends State<ManualTabsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _unreadCount = 5; // For badge demonstration

  @override
  void initState() {
    super.initState();
    // Initialize TabController with SingleTickerProviderStateMixin
    _tabController = TabController(
      length: 4, // Number of tabs
      vsync: this, // Required for animations
    );
    
    // Listen to tab index changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        print('Tab changing from ${_tabController.previousIndex} to ${_tabController.index}');
      }
      if (_tabController.index == 1) {
        // Clear unread count when visiting messages tab
        setState(() {
          _unreadCount = 0;
        });
      }
    });
  }

  @override
  void dispose() {
    // Always dispose the TabController to prevent memory leaks
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual TabController Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Add a button to programmatically switch tabs
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: () {
              // Programmatically switch to next tab
              final nextIndex = (_tabController.index + 1) % _tabController.length;
              _tabController.animateTo(nextIndex);
            },
            tooltip: 'Switch to next tab',
          ),
        ],
        bottom: TabBar(
          controller: _tabController, // Use our custom controller
          isScrollable: true,
          tabs: [
            const Tab(
              icon: Icon(Icons.dashboard),
              text: 'Dashboard',
            ),
            Tab(
              icon: Stack(
                children: [
                  const Icon(Icons.message),
                  if (_unreadCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '$_unreadCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              text: 'Messages',
            ),
            const Tab(
              icon: Icon(Icons.favorite),
              text: 'Favorites',
            ),
            const Tab(
              icon: Icon(Icons.settings),
              text: 'Settings',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController, // Use our custom controller
        children: const [
          DashboardTab(),
          MessagesTab(),
          FavoritesTab(),
          SettingsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add more unread messages
          setState(() {
            _unreadCount += 3;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Added 3 new messages. Total: $_unreadCount'),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Dashboard Tab with State Preservation
/// 
/// This tab demonstrates state preservation using AutomaticKeepAliveClientMixin.
/// The scroll position and content will be preserved when switching tabs.
class DashboardTab extends StatefulWidget {
  const DashboardTab({super.key});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  int _itemCount = 50;

  @override
  bool get wantKeepAlive => true; // This preserves the widget state

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // IMPORTANT: Always call super.build when using AutomaticKeepAliveClientMixin
    super.build(context);
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard Tab',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'This tab preserves its scroll position when you switch tabs.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          // Add more items button
          ElevatedButton(
            onPressed: () {
              setState(() {
                _itemCount += 10;
              });
            },
            child: const Text('Add More Items'),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _itemCount,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text('Dashboard Item ${index + 1}'),
                    subtitle: Text('This is item number ${index + 1}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Tapped Dashboard Item ${index + 1}'),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Messages Tab
class MessagesTab extends StatelessWidget {
  const MessagesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Messages Tab',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          const Text(
            'This tab shows messages. The unread count badge will clear when you visit this tab.',
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                final isUnread = index < 5;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isUnread
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: isUnread ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  title: Text(
                    'Message ${index + 1}',
                    style: TextStyle(
                      fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  subtitle: Text('Message content ${index + 1}'),
                  trailing: isUnread
                      ? Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        )
                      : null,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Opened Message ${index + 1}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Favorites Tab with State Preservation
class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab>
    with AutomaticKeepAliveClientMixin {
  final List<String> _favorites = [
    'Favorite Item 1',
    'Favorite Item 2',
    'Favorite Item 3',
    'Favorite Item 4',
    'Favorite Item 5',
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Favorites Tab',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          const Text(
            'This tab also preserves its state. Try adding/removing favorites and switching tabs.',
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _favorites.add('Favorite Item ${_favorites.length + 1}');
              });
            },
            child: const Text('Add Favorite'),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: const Icon(Icons.favorite, color: Colors.red),
                    title: Text(_favorites[index]),
                    subtitle: Text('This is a favorite item'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _favorites.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Favorite removed'),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Settings Tab
class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings Tab',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          const Text(
            'This tab shows settings. It doesn\'t preserve state since it\'s simple content.',
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                SwitchListTile(
                  title: const Text('Enable Notifications'),
                  subtitle: const Text('Receive push notifications'),
                  value: true,
                  onChanged: (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Notifications ${value ? 'enabled' : 'disabled'}'),
                      ),
                    );
                  },
                ),
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Use dark theme'),
                  value: false,
                  onChanged: (value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Dark mode ${value ? 'enabled' : 'disabled'}'),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('Language'),
                  subtitle: const Text('English'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Language settings tapped')),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.storage),
                  title: const Text('Storage'),
                  subtitle: const Text('Manage app storage'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Storage settings tapped')),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('About'),
                  subtitle: const Text('App version and information'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('About tapped')),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
