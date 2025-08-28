import 'package:flutter/material.dart';

class ContainerExamples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Container Widget Examples'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Container
            Text(
              'Basic Container Examples',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            
            // Simple colored container
            Container(
              width: 200.0,
              height: 100.0,
              color: Colors.blue,
              child: Center(
                child: Text(
                  'Simple Container',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            
            // Container with padding
            Container(
              width: 200.0,
              height: 100.0,
              color: Colors.green,
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'With Padding',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            
            // Container with margin
            Container(
              width: 200.0,
              height: 100.0,
              color: Colors.red,
              margin: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'With Margin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.0),
            
            // Styled Container with Decoration
            Text(
              'Styled Container Examples',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            
            // Container with rounded corners
            Container(
              width: 200.0,
              height: 100.0,
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: Text(
                  'Rounded Corners',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            
            // Container with border
            Container(
              width: 200.0,
              height: 100.0,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.purple,
                  width: 3.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  'With Border',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            
            // Container with shadow
            Container(
              width: 200.0,
              height: 100.0,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'With Shadow',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.0),
            
            // Container with gradient
            Container(
              width: 200.0,
              height: 100.0,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: Text(
                  'With Gradient',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.0),
            
            // Container with complex decoration
            Container(
              width: 200.0,
              height: 100.0,
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal, Colors.cyan],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Complex Design',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.0),
            
            // Container with different shapes
            Text(
              'Container Shapes',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Circle container
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ),
                
                // Rounded rectangle
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ),
                
                // Square with border
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    border: Border.all(
                      color: Colors.orange,
                      width: 3.0,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.diamond,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.0),
            
            // Exercise: Create your own container
            Text(
              'Exercise: Create your own styled container',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 16.0),
            
            // Add your custom container here
            Container(
              width: 200.0,
              height: 100.0,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.pink],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Your Custom Container',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

