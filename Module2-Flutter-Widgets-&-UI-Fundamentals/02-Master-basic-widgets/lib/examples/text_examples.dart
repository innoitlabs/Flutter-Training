import 'package:flutter/material.dart';

class TextExamples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Widget Examples'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Text
            Text(
              'Basic Text Example',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            
            // Simple text
            Text('Hello Flutter!'),
            SizedBox(height: 16.0),
            
            // Styled text
            Text(
              'Styled Text Example',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            
            // Multiple styled texts in a column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Flutter Basics',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Learn the fundamentals of Flutter widgets',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.0),
            
            // Text with different styles
            Text(
              'Large Bold Text',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 8.0),
            
            Text(
              'Medium Regular Text',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 8.0),
            
            Text(
              'Small Italic Text',
              style: TextStyle(
                fontSize: 14.0,
                fontStyle: FontStyle.italic,
                color: Colors.orange,
              ),
            ),
            SizedBox(height: 24.0),
            
            // Text with decoration
            Text(
              'Underlined Text',
              style: TextStyle(
                fontSize: 20.0,
                decoration: TextDecoration.underline,
                decorationColor: Colors.purple,
                decorationThickness: 2.0,
              ),
            ),
            SizedBox(height: 16.0),
            
            Text(
              'Strikethrough Text',
              style: TextStyle(
                fontSize: 20.0,
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.red,
              ),
            ),
            SizedBox(height: 24.0),
            
            // Text with letter spacing
            Text(
              'Spaced Out Text',
              style: TextStyle(
                fontSize: 20.0,
                letterSpacing: 2.0,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 16.0),
            
            // Text with word spacing
            Text(
              'Words with spacing',
              style: TextStyle(
                fontSize: 20.0,
                wordSpacing: 8.0,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 24.0),
            
            // Text with background
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'Text with Background',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.brown,
                ),
              ),
            ),
            SizedBox(height: 24.0),
            
            // Exercise: Try creating your own styled text
            Text(
              'Exercise: Create your own styled text below',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 16.0),
            
            // Add your custom styled text here
            Text(
              'Your Custom Text Here',
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.pink,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

