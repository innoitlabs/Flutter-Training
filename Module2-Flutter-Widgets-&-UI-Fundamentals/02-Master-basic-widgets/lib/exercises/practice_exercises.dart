import 'package:flutter/material.dart';

class PracticeExercises extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice Exercises'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Introduction
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.indigo[50],
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.indigo[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Practice Exercises',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo[800],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Complete these exercises to reinforce your understanding of Flutter basic widgets.',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.indigo[700],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24.0),
            
            // Exercise 1
            _buildExerciseCard(
              'Exercise 1: Basic Text Styling',
              'Easy',
              Colors.green,
              'Create a Text widget that displays "Hello Flutter" with:\n• Font size of 24\n• Blue color\n• Bold weight',
              'Text(\n  "Hello Flutter",\n  style: TextStyle(\n    fontSize: 24.0,\n    color: Colors.blue,\n    fontWeight: FontWeight.bold,\n  ),\n)',
            ),
            
            SizedBox(height: 16.0),
            
            // Exercise 2
            _buildExerciseCard(
              'Exercise 2: Styled Container',
              'Easy',
              Colors.blue,
              'Create a Container with:\n• Width: 200, Height: 100\n• Orange background color\n• Rounded corners (12px radius)\n• White text saying "Styled Container"',
              'Container(\n  width: 200.0,\n  height: 100.0,\n  decoration: BoxDecoration(\n    color: Colors.orange,\n    borderRadius: BorderRadius.circular(12.0),\n  ),\n  child: Center(\n    child: Text(\n      "Styled Container",\n      style: TextStyle(\n        color: Colors.white,\n        fontSize: 16.0,\n        fontWeight: FontWeight.bold,\n      ),\n    ),\n  ),\n)',
            ),
            
            SizedBox(height: 16.0),
            
            // Exercise 3
            _buildExerciseCard(
              'Exercise 3: Profile Card',
              'Intermediate',
              Colors.orange,
              'Create a profile card with:\n• Circular avatar (blue background)\n• Name and title in a Column\n• Arrange them horizontally using Row\n• Add some padding and styling',
              'Container(\n  padding: EdgeInsets.all(16.0),\n  decoration: BoxDecoration(\n    color: Colors.white,\n    borderRadius: BorderRadius.circular(8.0),\n    boxShadow: [\n      BoxShadow(\n        color: Colors.grey.withOpacity(0.3),\n        blurRadius: 5,\n      ),\n    ],\n  ),\n  child: Row(\n    children: [\n      Container(\n        width: 50.0,\n        height: 50.0,\n        decoration: BoxDecoration(\n          color: Colors.blue,\n          shape: BoxShape.circle,\n        ),\n        child: Icon(Icons.person, color: Colors.white),\n      ),\n      SizedBox(width: 16.0),\n      Column(\n        crossAxisAlignment: CrossAxisAlignment.start,\n        children: [\n          Text("John Doe", \n               style: TextStyle(fontWeight: FontWeight.bold)),\n          Text("Developer"),\n        ],\n      ),\n    ],\n  ),\n)',
            ),
            
            SizedBox(height: 16.0),
            
            // Exercise 4
            _buildExerciseCard(
              'Exercise 4: Stats Row',
              'Intermediate',
              Colors.purple,
              'Create a Row with 3 Expanded containers:\n• Each showing a number and label\n• Different background colors\n• Equal width distribution\n• Rounded corners and padding',
              'Row(\n  children: [\n    Expanded(\n      child: Container(\n        padding: EdgeInsets.all(16.0),\n        margin: EdgeInsets.only(right: 8.0),\n        decoration: BoxDecoration(\n          color: Colors.green[100],\n          borderRadius: BorderRadius.circular(8.0),\n        ),\n        child: Column(\n          children: [\n            Text("150", \n                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),\n            Text("Projects"),\n          ],\n        ),\n      ),\n    ),\n    Expanded(\n      child: Container(\n        padding: EdgeInsets.all(16.0),\n        margin: EdgeInsets.symmetric(horizontal: 4.0),\n        decoration: BoxDecoration(\n          color: Colors.blue[100],\n          borderRadius: BorderRadius.circular(8.0),\n        ),\n        child: Column(\n          children: [\n            Text("4.9", \n                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),\n            Text("Rating"),\n          ],\n        ),\n      ),\n    ),\n    Expanded(\n      child: Container(\n        padding: EdgeInsets.all(16.0),\n        margin: EdgeInsets.only(left: 8.0),\n        decoration: BoxDecoration(\n          color: Colors.orange[100],\n          borderRadius: BorderRadius.circular(8.0),\n        ),\n        child: Column(\n          children: [\n            Text("2.5K", \n                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),\n            Text("Downloads"),\n          ],\n        ),\n      ),\n    ),\n  ],\n)',
            ),
            
            SizedBox(height: 16.0),
            
            // Exercise 5
            _buildExerciseCard(
              'Exercise 5: Banner with Stack',
              'Advanced',
              Colors.red,
              'Create a promotional banner using Stack:\n• Gradient background\n• Main title and subtitle\n• Action button positioned at bottom-right\n• Use Positioned widgets for precise placement',
              'Stack(\n  children: [\n    Container(\n      width: double.infinity,\n      height: 120.0,\n      decoration: BoxDecoration(\n        gradient: LinearGradient(\n          colors: [Colors.purple, Colors.pink],\n          begin: Alignment.topLeft,\n          end: Alignment.bottomRight,\n        ),\n        borderRadius: BorderRadius.circular(12.0),\n      ),\n    ),\n    Positioned(\n      top: 20.0,\n      left: 20.0,\n      child: Text(\n        "Special Offer!",\n        style: TextStyle(\n          color: Colors.white,\n          fontSize: 24.0,\n          fontWeight: FontWeight.bold,\n        ),\n      ),\n    ),\n    Positioned(\n      top: 50.0,\n      left: 20.0,\n      child: Text(\n        "Get 50% off on Flutter courses",\n        style: TextStyle(\n          color: Colors.white70,\n          fontSize: 16.0,\n        ),\n      ),\n    ),\n    Positioned(\n      bottom: 20.0,\n      right: 20.0,\n      child: Container(\n        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),\n        decoration: BoxDecoration(\n          color: Colors.white,\n          borderRadius: BorderRadius.circular(20.0),\n        ),\n        child: Text(\n          "Claim Now",\n          style: TextStyle(\n            color: Colors.purple,\n            fontWeight: FontWeight.bold,\n          ),\n        ),\n      ),\n    ),\n  ],\n)',
            ),
            
            SizedBox(height: 16.0),
            
            // Exercise 6
            _buildExerciseCard(
              'Exercise 6: Complete Layout',
              'Advanced',
              Colors.teal,
              'Build a complete screen layout:\n• Header with gradient background\n• Profile card with avatar and info\n• Stats section with 3 columns\n• Promotional banner at bottom\n• Combine all widgets you\'ve learned',
              'Column(\n  children: [\n    // Header\n    Container(\n      width: double.infinity,\n      padding: EdgeInsets.all(20.0),\n      decoration: BoxDecoration(\n        gradient: LinearGradient(\n          colors: [Colors.deepPurple, Colors.purple],\n        ),\n        borderRadius: BorderRadius.circular(12.0),\n      ),\n      child: Column(\n        children: [\n          Text("Flutter Widgets", \n               style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),\n          Text("Master the basics", \n               style: TextStyle(fontSize: 16, color: Colors.white70)),\n        ],\n      ),\n    ),\n    SizedBox(height: 24.0),\n    // Profile Card\n    Container(\n      padding: EdgeInsets.all(16.0),\n      decoration: BoxDecoration(\n        color: Colors.white,\n        borderRadius: BorderRadius.circular(12.0),\n        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 5)],\n      ),\n      child: Row(\n        children: [\n          Container(\n            width: 60.0,\n            height: 60.0,\n            decoration: BoxDecoration(\n              color: Colors.blue,\n              shape: BoxShape.circle,\n            ),\n            child: Icon(Icons.person, color: Colors.white, size: 30.0),\n          ),\n          SizedBox(width: 16.0),\n          Expanded(\n            child: Column(\n              crossAxisAlignment: CrossAxisAlignment.start,\n              children: [\n                Text("Flutter Developer", \n                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),\n                Text("Building amazing apps", \n                     style: TextStyle(color: Colors.grey[600])),\n              ],\n            ),\n          ),\n        ],\n      ),\n    ),\n    // Add stats and banner sections...\n  ],\n)',
            ),
            
            SizedBox(height: 24.0),
            
            // Tips Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.amber[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '💡 Tips for Success',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber[800],
                    ),
                  ),
                  SizedBox(height: 12.0),
                  _buildTip('Start with simple widgets and gradually add complexity'),
                  _buildTip('Use SizedBox for consistent spacing'),
                  _buildTip('Experiment with different colors and styles'),
                  _buildTip('Test your layouts on different screen sizes'),
                  _buildTip('Use Container decoration for advanced styling'),
                  _buildTip('Combine widgets to create complex layouts'),
                ],
              ),
            ),
            
            SizedBox(height: 24.0),
            
            // Next Steps
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.green[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🚀 Next Steps',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    'After mastering these basic widgets, explore:',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.green[700],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  _buildNextStep('StatefulWidgets for interactive UI'),
                  _buildNextStep('ListView for scrollable lists'),
                  _buildNextStep('GestureDetector for user interactions'),
                  _buildNextStep('Custom widgets for reusable components'),
                  _buildNextStep('Theme and styling for consistent design'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildExerciseCard(
    String title,
    String difficulty,
    Color difficultyColor,
    String description,
    String solution,
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
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Container(
          margin: EdgeInsets.only(top: 4.0),
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: difficultyColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            difficulty,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Solution:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Text(
                    solution,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'monospace',
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTip(String tip) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(color: Colors.amber[700])),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.amber[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNextStep(String step) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('→ ', style: TextStyle(color: Colors.green[700])),
          Expanded(
            child: Text(
              step,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.green[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

