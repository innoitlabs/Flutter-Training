import 'package:flutter/material.dart';

class LayoutExamples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Layout Widget Examples'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row Examples
            Text(
              'Row Widget Examples',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            
            // Basic Row
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  SizedBox(width: 8.0),
                  Text('5.0'),
                  SizedBox(width: 8.0),
                  Text('(120 reviews)'),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            
            // Row with different alignments
            Text(
              'Row with MainAxisAlignment',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            
            // SpaceEvenly
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(width: 50, height: 30, color: Colors.red),
                  Container(width: 50, height: 30, color: Colors.green),
                  Container(width: 50, height: 30, color: Colors.blue),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            
            // SpaceBetween
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 50, height: 30, color: Colors.red),
                  Container(width: 50, height: 30, color: Colors.green),
                  Container(width: 50, height: 30, color: Colors.blue),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            
            // Center
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 50, height: 30, color: Colors.red),
                  SizedBox(width: 8.0),
                  Container(width: 50, height: 30, color: Colors.green),
                  SizedBox(width: 8.0),
                  Container(width: 50, height: 30, color: Colors.blue),
                ],
              ),
            ),
            SizedBox(height: 24.0),
            
            // Column Examples
            Text(
              'Column Widget Examples',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            
            // Basic Column
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Product Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Product Description'),
                  Text('\$29.99', style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            
            // Column with different alignments
            Text(
              'Column with CrossAxisAlignment',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            
            Row(
              children: [
                // Start alignment
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: 30, height: 30, color: Colors.red),
                        SizedBox(height: 8.0),
                        Container(width: 30, height: 30, color: Colors.green),
                        SizedBox(height: 8.0),
                        Container(width: 30, height: 30, color: Colors.blue),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                
                // Center alignment
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(width: 30, height: 30, color: Colors.red),
                        SizedBox(height: 8.0),
                        Container(width: 30, height: 30, color: Colors.green),
                        SizedBox(height: 8.0),
                        Container(width: 30, height: 30, color: Colors.blue),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                
                // End alignment
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(width: 30, height: 30, color: Colors.red),
                        SizedBox(height: 8.0),
                        Container(width: 30, height: 30, color: Colors.green),
                        SizedBox(height: 8.0),
                        Container(width: 30, height: 30, color: Colors.blue),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.0),
            
            // Expanded Examples
            Text(
              'Expanded Widget Examples',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            
            // Basic Expanded
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    color: Colors.red,
                    child: Center(child: Text('Fixed')),
                  ),
                  Expanded(
                    child: Container(
                      height: 50.0,
                      color: Colors.green,
                      child: Center(child: Text('Expanded')),
                    ),
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    color: Colors.blue,
                    child: Center(child: Text('Fixed')),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            
            // Expanded with flex
            Text(
              'Expanded with Flex Property',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50.0,
                      color: Colors.red,
                      child: Center(child: Text('Flex: 1')),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 50.0,
                      color: Colors.green,
                      child: Center(child: Text('Flex: 2')),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50.0,
                      color: Colors.blue,
                      child: Center(child: Text('Flex: 1')),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),
            
            // Complex Layout Example
            Text(
              'Complex Layout Example',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            
            // Profile Card
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
                          'John Doe',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Flutter Developer',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 16.0),
                            SizedBox(width: 4.0),
                            Text('4.8'),
                            SizedBox(width: 16.0),
                            Icon(Icons.location_on, color: Colors.grey, size: 16.0),
                            SizedBox(width: 4.0),
                            Text('New York'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey),
                ],
              ),
            ),
            SizedBox(height: 24.0),
            
            // Stats Cards
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
            
            // Exercise: Create your own layout
            Text(
              'Exercise: Create your own layout',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 16.0),
            
            // Add your custom layout here
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.purple[200]!),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Icon(Icons.code, color: Colors.white),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Custom Layout',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[800],
                          ),
                        ),
                        Text(
                          'Combine Row, Column, and Expanded',
                          style: TextStyle(
                            color: Colors.purple[600],
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward, color: Colors.purple),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

