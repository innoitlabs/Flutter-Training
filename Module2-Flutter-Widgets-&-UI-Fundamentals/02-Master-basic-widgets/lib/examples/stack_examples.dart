import 'package:flutter/material.dart';

class StackExamples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stack Widget Examples'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Stack
            Text(
              'Basic Stack Examples',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            
            // Simple Stack
            Container(
              width: 300.0,
              height: 200.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Stack(
                children: [
                  // Background
                  Container(
                    width: 300.0,
                    height: 200.0,
                    color: Colors.blue,
                  ),
                  // Overlay text
                  Positioned(
                    bottom: 20.0,
                    left: 20.0,
                    child: Text(
                      'Overlay Text',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            
            // Stack with multiple positioned elements
            Container(
              width: 300.0,
              height: 200.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Stack(
                children: [
                  // Background
                  Container(
                    width: 300.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.blue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  // Top left text
                  Positioned(
                    top: 20.0,
                    left: 20.0,
                    child: Text(
                      'Top Left',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Top right icon
                  Positioned(
                    top: 20.0,
                    right: 20.0,
                    child: Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 30.0,
                    ),
                  ),
                  // Bottom right button
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
                        'Button',
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Center text
                  Positioned(
                    top: 50.0,
                    left: 0.0,
                    right: 0.0,
                    child: Center(
                      child: Text(
                        'Center Text',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),
            
            // Banner Examples
            Text(
              'Banner Examples',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            
            // Promotional Banner
            Container(
              width: double.infinity,
              height: 120.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Stack(
                children: [
                  // Background gradient
                  Container(
                    width: double.infinity,
                    height: 120.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.pink],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  // Main text
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
                  // Subtitle
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
                  // Action button
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
            ),
            SizedBox(height: 16.0),
            
            // Product Card with Badge
            Container(
              width: 200.0,
              height: 250.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Stack(
                children: [
                  // Product image background
                  Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.image,
                        size: 60.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  // Sale badge
                  Positioned(
                    top: 10.0,
                    left: 10.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        'SALE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Favorite icon
                  Positioned(
                    top: 10.0,
                    right: 10.0,
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite_border,
                        size: 20.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  // Product info at bottom
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Product Name',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '\$29.99',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),
            
            // Profile Card with Overlay
            Text(
              'Profile Card with Overlay',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            
            Container(
              width: 300.0,
              height: 200.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Stack(
                children: [
                  // Background image
                  Container(
                    width: 300.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.purple],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  // Profile info
                  Positioned(
                    bottom: 20.0,
                    left: 20.0,
                    child: Row(
                      children: [
                        // Profile picture
                        Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3.0),
                          ),
                          child: Icon(
                            Icons.person,
                            size: 30.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 16.0),
                        // Name and title
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'John Doe',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Flutter Developer',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Online status indicator
                  Positioned(
                    top: 20.0,
                    right: 20.0,
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),
            
            // Floating Action Button Example
            Text(
              'Floating Action Button Example',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            
            Container(
              width: double.infinity,
              height: 200.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[100],
              ),
              child: Stack(
                children: [
                  // Content
                  Center(
                    child: Text(
                      'Your content goes here',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  // Floating action button
                  Positioned(
                    bottom: 20.0,
                    right: 20.0,
                    child: Container(
                      width: 56.0,
                      height: 56.0,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),
            
            // Exercise: Create your own stack
            Text(
              'Exercise: Create your own stack layout',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 16.0),
            
            // Add your custom stack here
            Container(
              width: 300.0,
              height: 150.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Stack(
                children: [
                  // Background
                  Container(
                    width: 300.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.teal, Colors.cyan],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  // Your custom positioned elements
                  Positioned(
                    top: 20.0,
                    left: 20.0,
                    child: Text(
                      'Your Custom Stack',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20.0,
                    right: 20.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Text(
                        'Custom Button',
                        style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20.0,
                    right: 20.0,
                    child: Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

