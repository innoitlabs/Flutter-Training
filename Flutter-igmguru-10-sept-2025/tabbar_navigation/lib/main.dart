import 'package:flutter/material.dart';

void main() {
  runApp(const BasicTabsExample());
}

class BasicTabsExample extends StatelessWidget {
  const BasicTabsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Basic Tabs Example",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
        )
      ),
      home: const BasicTabsScreen(),
    );
  }
}

// BasicTabsScreen -> HomeTabScreen, ProfileTabScreen, SettingsTabScreen
class BasicTabsScreen extends StatelessWidget {
  const BasicTabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Basic Tabs Example"),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            bottom: const TabBar(
              isScrollable: true,
                tabs: [
                  Tab(
                    icon: Icon(Icons.home),
                    text: "Home",
                  ),
                  Tab(
                    icon: Icon(Icons.search),
                    text: "Search",
                  ),
                  Tab(
                    icon: Icon(Icons.person),
                    text: "Profile",
                  )
                ]),
          ),
          body: TabBarView(
              children: [
                Home(),
                Search(),
                Profile()
              ]),
        ));
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Home Tab Screen")
      ],
    );
  }
}

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Search Tab Screen", style: TextStyle(fontSize: 30),)
      ],
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Profile Tab Screen", style: TextStyle(fontSize: 30))
      ],
    );
  }
}

