import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String? itemId;
  final String? itemTitle;

  const DetailsPage({
    super.key,
    this.itemId,
    this.itemTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Page'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Details Page',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This page demonstrates receiving arguments from named routes.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    if (itemId != null) ...[
                      Text(
                        'Item ID: $itemId',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                    if (itemTitle != null) ...[
                      Text(
                        'Item Title: $itemTitle',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                    if (itemId == null && itemTitle == null) ...[
                      const Text(
                        'No arguments provided',
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go Back'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context, 'Returned from Details with ID: $itemId');
              },
              icon: const Icon(Icons.reply),
              label: const Text('Go Back with Data'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
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
                      'Route Arguments',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'How arguments are passed and received:',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text('• Arguments are passed via Navigator.pushNamed()'),
                    Text('• Received in onGenerateRoute via settings.arguments'),
                    Text('• Extracted and passed to widget constructor'),
                    Text('• Null-safe handling of optional arguments'),
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
                      'Navigation Methods',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Different ways to navigate with named routes:',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text('• Navigator.pushNamed() - Push new route'),
                    Text('• Navigator.pushReplacementNamed() - Replace current'),
                    Text('• Navigator.popAndPushNamed() - Pop and push'),
                    Text('• Navigator.pushNamedAndRemoveUntil() - Clear stack'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
