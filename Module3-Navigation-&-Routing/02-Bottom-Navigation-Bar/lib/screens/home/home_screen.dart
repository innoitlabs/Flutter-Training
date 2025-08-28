import 'package:flutter/material.dart';
import 'home_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        children: [
          const Icon(Icons.home, size: 64, color: Colors.blue),
          const SizedBox(height: 16),
          const Text(
            'Home Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _textController,
            decoration: const InputDecoration(
              labelText: 'Enter some text (state will be preserved)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HomeDetailsScreen(),
                ),
              );
            },
            child: const Text('Go to Details'),
          ),
          const SizedBox(height: 32),
          // Add some content to demonstrate scroll position preservation
          ...List.generate(20, (index) => ListTile(
            title: Text('Item ${index + 1}'),
            subtitle: Text('This is item number ${index + 1}'),
            leading: CircleAvatar(child: Text('${index + 1}')),
          )),
        ],
      ),
    );
  }
}
