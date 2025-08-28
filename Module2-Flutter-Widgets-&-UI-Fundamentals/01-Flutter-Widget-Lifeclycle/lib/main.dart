import 'package:flutter/material.dart';
import 'examples/counter_lifecycle_demo.dart';
import 'examples/data_fetching_demo.dart';
import 'examples/widget_swapping_demo.dart';
import 'examples/exercises.dart';

void main() {
  runApp(WidgetLifecycleApp());
}

class WidgetLifecycleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widget Tree & Lifecycle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Tree & Lifecycle Examples'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Flutter Widget Tree and Lifecycle',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Select an example to explore widget lifecycle:',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            _buildExampleCard(
              context,
              'Counter with Lifecycle Logs',
              'Observe lifecycle methods in a simple counter app',
              Icons.add_circle,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CounterLifecycleDemo()),
              ),
            ),
            SizedBox(height: 16),
            _buildExampleCard(
              context,
              'Data Fetching Demo',
              'See how to handle async operations in lifecycle',
              Icons.cloud_download,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DataFetchingDemo()),
              ),
            ),
            SizedBox(height: 16),
            _buildExampleCard(
              context,
              'Widget Swapping Demo',
              'Observe widget disposal and recreation',
              Icons.swap_horiz,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WidgetSwappingDemo()),
              ),
            ),
            SizedBox(height: 16),
            _buildExampleCard(
              context,
              'Practice Exercises',
              'Complete hands-on exercises to test your knowledge',
              Icons.school,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExercisesScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: Colors.blue[600],
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
