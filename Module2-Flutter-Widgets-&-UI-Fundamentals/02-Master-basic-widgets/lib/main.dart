import 'package:flutter/material.dart';
import 'examples/text_examples.dart';
import 'examples/container_examples.dart';
import 'examples/layout_examples.dart';
import 'examples/stack_examples.dart';
import 'exercises/practice_exercises.dart';

void main() {
  runApp(FlutterBasicWidgetsApp());
}

class FlutterBasicWidgetsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Basic Widgets Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
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
        title: Text('Flutter Basic Widgets'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.purple],
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  Text(
                    'Flutter Widgets',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Master the basics',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24.0),
            
            // Navigation Cards
            Text(
              'Widget Examples',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            
            // Text Widget Card
            _buildNavigationCard(
              context,
              'Text Widget',
              'Display and style text content',
              Icons.text_fields,
              Colors.blue,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TextExamples()),
              ),
            ),
            
            SizedBox(height: 12.0),
            
            // Container Widget Card
            _buildNavigationCard(
              context,
              'Container Widget',
              'Layout, padding, margins, and styling',
              Icons.crop_square,
              Colors.orange,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContainerExamples()),
              ),
            ),
            
            SizedBox(height: 12.0),
            
            // Layout Widget Card
            _buildNavigationCard(
              context,
              'Row & Column',
              'Horizontal and vertical layouts',
              Icons.view_column,
              Colors.green,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LayoutExamples()),
              ),
            ),
            
            SizedBox(height: 12.0),
            
            // Stack Widget Card
            _buildNavigationCard(
              context,
              'Stack Widget',
              'Overlapping and layered layouts',
              Icons.layers,
              Colors.purple,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StackExamples()),
              ),
            ),
            
            SizedBox(height: 24.0),
            
            // Complete Demo Section
            Text(
              'Complete Demo',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            
            _buildNavigationCard(
              context,
              'Full Demo Screen',
              'See all widgets working together',
              Icons.dashboard,
              Colors.deepPurple,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WidgetDemoScreen()),
              ),
            ),
            
            SizedBox(height: 24.0),
            
            // Practice Section
            Text(
              'Practice & Exercises',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            
            _buildNavigationCard(
              context,
              'Practice Exercises',
              'Complete exercises to reinforce learning',
              Icons.school,
              Colors.indigo,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PracticeExercises()),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildNavigationCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 16.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WidgetDemoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Widgets Demo'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.purple],
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  Text(
                    'Flutter Widgets',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Master the basics',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24.0),
            
            // Profile Card Section
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Profile Image
                  Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person, color: Colors.white, size: 30.0),
                  ),
                  SizedBox(width: 16.0),
                  // Profile Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Flutter Developer',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Building amazing apps',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey),
                ],
              ),
            ),
            
            SizedBox(height: 24.0),
            
            // Stats Section with Expanded
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '150',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                        ),
                        Text(
                          'Projects',
                          style: TextStyle(color: Colors.green[700]),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '4.9',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                        ),
                        Text(
                          'Rating',
                          style: TextStyle(color: Colors.blue[700]),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.only(left: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '2.5K',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[800],
                          ),
                        ),
                        Text(
                          'Downloads',
                          style: TextStyle(color: Colors.orange[700]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 24.0),
            
            // Stack Banner Section
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 120.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.pink],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                Positioned(
                  top: 20.0,
                  left: 20.0,
                  child: Text(
                    'Special Offer!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: 50.0,
                  left: 20.0,
                  child: Text(
                    'Get 50% off on Flutter courses',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  right: 20.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'Claim Now',
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
