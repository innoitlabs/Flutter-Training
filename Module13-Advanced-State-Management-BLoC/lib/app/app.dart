import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme.dart';
import 'routes.dart';
import '../features/counter/counter_bloc.dart';
import '../features/counter/counter_page.dart';
import '../features/todos/bloc/todos_bloc.dart';
import '../features/todos/bloc/todo_stats_bloc.dart';
import '../features/todos/ui/todos_page.dart';
import '../features/feed/bloc/feed_bloc.dart';
import '../features/feed/ui/feed_page.dart';
import '../features/todos/data/todo_repository.dart';
import '../features/feed/data/feed_repository.dart';

/// Main app widget with BLoC providers and navigation
class BlocHubApp extends StatelessWidget {
  const BlocHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlocHub - BLoC Pattern Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      onGenerateRoute: AppRoutes.generateRoute,
      home: const BlocHubHomePage(),
    );
  }
}

/// Home page with bottom navigation and BLoC providers
class BlocHubHomePage extends StatefulWidget {
  const BlocHubHomePage({super.key});

  @override
  State<BlocHubHomePage> createState() => _BlocHubHomePageState();
}

class _BlocHubHomePageState extends State<BlocHubHomePage> {
  int _currentIndex = 0;
  
  final List<Widget> _pages = [
    const CounterPage(),
    const TodosPage(),
    const FeedPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Counter BLoC - simple state management
        BlocProvider<CounterBloc>(
          create: (context) => CounterBloc(),
        ),
        // Todos BLoC - CRUD operations with repository
        BlocProvider<TodosBloc>(
          create: (context) => TodosBloc(
            repository: InMemoryTodoRepository(),
          ),
        ),
        // Todo Stats BLoC - derived from Todos BLoC
        BlocProvider<TodoStatsBloc>(
          create: (context) => TodoStatsBloc(
            todosBloc: context.read<TodosBloc>(),
          ),
        ),
        // Feed BLoC - async operations with pagination
        BlocProvider<FeedBloc>(
          create: (context) => FeedBloc(
            repository: MockFeedRepository(),
          ),
        ),
      ],
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.add_circle_outline),
              selectedIcon: Icon(Icons.add_circle),
              label: 'Counter',
            ),
            NavigationDestination(
              icon: Icon(Icons.check_box_outline_blank),
              selectedIcon: Icon(Icons.check_box),
              label: 'Todos',
            ),
            NavigationDestination(
              icon: Icon(Icons.rss_feed_outlined),
              selectedIcon: Icon(Icons.rss_feed),
              label: 'Feed',
            ),
          ],
        ),
      ),
    );
  }
}
