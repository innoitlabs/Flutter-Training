import 'package:flutter/material.dart';

/// Tab Navigation Exercises
/// 
/// This file contains solutions to the exercises mentioned in the learning module.
/// Each exercise demonstrates different aspects of tab navigation in Flutter.
/// 
/// Run this example with: flutter run -t lib/exercises/tab_exercises.dart

void main() {
  runApp(const TabExercisesApp());
}

class TabExercisesApp extends StatelessWidget {
  const TabExercisesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tab Navigation Exercises',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.dark,
        ),
      ),
      home: const ExerciseSelectorScreen(),
    );
  }
}

class ExerciseSelectorScreen extends StatelessWidget {
  const ExerciseSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tab Navigation Exercises'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Exercise Solutions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildExerciseCard(
              context,
              'Easy Exercise',
              'Add a 4th tab and make the strip scrollable',
              Icons.add,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EasyExercise(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildExerciseCard(
              context,
              'Intermediate Exercise',
              'Add a badge on a tab with unread count',
              Icons.badge,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const IntermediateExercise(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildExerciseCard(
              context,
              'Advanced Exercise',
              'NestedScrollView with collapsing header and pinned tabs',
              Icons.view_column,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdvancedExercise(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Easy Exercise: Add a 4th tab and make the strip scrollable
class EasyExercise extends StatelessWidget {
  const EasyExercise({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Added 4th tab
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Easy Exercise - 4 Tabs'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: const TabBar(
            isScrollable: true, // Make tabs scrollable
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: 'Home',
              ),
              Tab(
                icon: Icon(Icons.search),
                text: 'Search',
              ),
              Tab(
                icon: Icon(Icons.person),
                text: 'Profile',
              ),
              Tab(
                icon: Icon(Icons.settings),
                text: 'Settings',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HomeTab(),
            SearchTab(),
            ProfileTab(),
            SettingsTab(),
          ],
        ),
      ),
    );
  }
}

/// Intermediate Exercise: Badge on tab with unread count
class IntermediateExercise extends StatefulWidget {
  const IntermediateExercise({super.key});

  @override
  State<IntermediateExercise> createState() => _IntermediateExerciseState();
}

class _IntermediateExerciseState extends State<IntermediateExercise>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _unreadCount = 3;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Listen to tab changes to clear unread count
    _tabController.addListener(() {
      if (_tabController.index == 1 && _unreadCount > 0) {
        setState(() {
          _unreadCount = 0;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intermediate Exercise - Badge'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            const Tab(
              icon: Icon(Icons.home),
              text: 'Home',
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
              icon: Icon(Icons.settings),
              text: 'Settings',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          HomeTab(),
          MessagesTab(),
          SettingsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _unreadCount += 1;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Added message. Unread: $_unreadCount'),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Advanced Exercise: NestedScrollView with collapsing header
class AdvancedExercise extends StatelessWidget {
  const AdvancedExercise({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 250.0,
                floating: false,
                pinned: true,
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text('Advanced Exercise'),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).colorScheme.tertiary,
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            size: 80,
                            color: Colors.white,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Collapsing Header',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Scroll to see the magic!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                bottom: const TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.list),
                      text: 'List View',
                    ),
                    Tab(
                      icon: Icon(Icons.grid_view),
                      text: 'Grid View',
                    ),
                    Tab(
                      icon: Icon(Icons.table_chart),
                      text: 'Table View',
                    ),
                  ],
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              ListViewTab(),
              GridViewTab(),
              TableViewTab(),
            ],
          ),
        ),
      ),
    );
  }
}

// Tab content widgets for exercises
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 64),
          SizedBox(height: 16),
          Text('Home Tab Content'),
        ],
      ),
    );
  }
}

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 64),
          SizedBox(height: 16),
          Text('Search Tab Content'),
        ],
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 64),
          SizedBox(height: 16),
          Text('Profile Tab Content'),
        ],
      ),
    );
  }
}

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.settings, size: 64),
          SizedBox(height: 16),
          Text('Settings Tab Content'),
        ],
      ),
    );
  }
}

class MessagesTab extends StatelessWidget {
  const MessagesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: Text('Message ${index + 1}'),
            subtitle: Text('This is message content ${index + 1}'),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        );
      },
    );
  }
}

class ListViewTab extends StatelessWidget {
  const ListViewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      itemCount: 50,
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
            title: Text('List Item ${index + 1}'),
            subtitle: Text('Description for item ${index + 1}'),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        );
      },
    );
  }
}

class GridViewTab extends StatelessWidget {
  const GridViewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Grid Item ${index + 1} tapped'),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.grid_view,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 8),
                Text(
                  'Grid ${index + 1}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TableViewTab extends StatelessWidget {
  const TableViewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Data Table',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Table(
                    border: TableBorder.all(),
                    children: [
                      const TableRow(
                        decoration: BoxDecoration(color: Colors.grey),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('ID', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      ...List.generate(10, (index) => TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${index + 1}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Item ${index + 1}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(index % 2 == 0 ? 'Active' : 'Inactive'),
                          ),
                        ],
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
