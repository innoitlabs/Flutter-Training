import 'package:flutter/material.dart';
import 'details_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _returnedData;
  Map<String, dynamic>? _profileData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Passing - Home'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Passing Concepts',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Learn how to pass data between screens:',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text('• Pass data via constructor parameters'),
                    Text('• Use Navigator.push() with arguments'),
                    Text('• Return data using Navigator.pop(context, data)'),
                    Text('• Handle async data flow between screens'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                // Pass data via constructor and receive result
                final result = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailsPage(
                      itemId: 'item_001',
                      itemTitle: 'Sample Item',
                      itemDescription: 'This is a sample item for demonstration',
                    ),
                  ),
                );
                
                setState(() {
                  _returnedData = result;
                });
                
                if (result != null) {
                  _showSnackBar('Received: $result');
                }
              },
              icon: const Icon(Icons.send),
              label: const Text('Send Data to Details'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () async {
                // Pass data via arguments and receive complex result
                final result = await Navigator.push<Map<String, dynamic>>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      initialUsername: 'John Doe',
                      initialEmail: 'john@example.com',
                    ),
                  ),
                );
                
                setState(() {
                  _profileData = result;
                });
                
                if (result != null) {
                  _showSnackBar('Profile updated: ${result['username']}');
                }
              },
              icon: const Icon(Icons.person),
              label: const Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () async {
                // Pass data via arguments map
                final result = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(
                      itemId: 'dynamic_item',
                      itemTitle: 'Dynamic Item',
                      itemDescription: 'Created at ${DateTime.now()}',
                    ),
                  ),
                );
                
                setState(() {
                  _returnedData = result;
                });
              },
              icon: const Icon(Icons.dynamic_feed),
              label: const Text('Dynamic Data Example'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 20),
            if (_returnedData != null) ...[
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Returned Data from Details:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(_returnedData!),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
            if (_profileData != null) ...[
              Card(
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Profile Data:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Username: ${_profileData!['username']}'),
                      Text('Email: ${_profileData!['email']}'),
                      Text('Action: ${_profileData!['action']}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Passing Patterns',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Different ways to pass data:',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text('• Constructor parameters - Type-safe, compile-time'),
                    Text('• Navigator arguments - Runtime, flexible'),
                    Text('• Global state management - For complex apps'),
                    Text('• Callback functions - For immediate responses'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Best Practices',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Guidelines for data passing:',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text('• Use constructors for required data'),
                    Text('• Use arguments for optional data'),
                    Text('• Keep data structures simple'),
                    Text('• Handle null values safely'),
                    Text('• Use async/await for data flow'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
