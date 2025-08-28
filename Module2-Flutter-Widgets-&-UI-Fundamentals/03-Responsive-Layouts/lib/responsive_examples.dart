import 'package:flutter/material.dart';

// Centralized breakpoint management
class ResponsiveBreakpoints {
  static const double mobile = 600;
  static const double tablet = 1024;
  static const double desktop = 1200;
  
  static bool isMobile(double width) => width < mobile;
  static bool isTablet(double width) => width >= mobile && width < tablet;
  static bool isDesktop(double width) => width >= tablet;
}

// 1. MediaQuery Example
class MediaQueryExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;
    
    // Calculate responsive values
    final padding = screenWidth * 0.05;
    final fontSize = screenWidth * 0.04;
    
    return Scaffold(
      appBar: AppBar(title: Text('MediaQuery Basics')),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Screen Information',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Width: ${screenWidth.toInt()}px'),
            Text('Height: ${screenHeight.toInt()}px'),
            Text('Orientation: ${orientation.name}'),
            SizedBox(height: 20),
            Text(
              'Responsive Text',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'This text size adapts to screen width: ${fontSize.toStringAsFixed(1)}px',
              style: TextStyle(fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. LayoutBuilder Example
class LayoutBuilderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('LayoutBuilder Demo')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // Mobile layout - single column
            return Column(
              children: [
                Container(
                  width: constraints.maxWidth,
                  height: 100,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Mobile Layout',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: constraints.maxWidth,
                    color: Colors.green,
                    child: Center(
                      child: Text(
                        'Content Area\nWidth: ${constraints.maxWidth.toInt()}px',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Desktop layout - side by side
            return Row(
              children: [
                Container(
                  width: 200,
                  height: constraints.maxHeight,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Sidebar\nWidth: 200px',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.green,
                    child: Center(
                      child: Text(
                        'Main Content\nWidth: ${constraints.maxWidth.toInt()}px',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

// 3. OrientationBuilder Example
class OrientationBuilderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OrientationBuilder Demo')),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            // Portrait layout - stacked vertically
            return Column(
              children: [
                // Profile image
                Container(
                  width: 150,
                  height: 150,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue[200],
                  ),
                  child: Icon(Icons.person, size: 80, color: Colors.white),
                ),
                // Profile info
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text('Software Developer'),
                        SizedBox(height: 16),
                        Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
                        SizedBox(height: 16),
                        Text('Orientation: Portrait'),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Landscape layout - side by side
            return Row(
              children: [
                // Profile image
                Container(
                  width: 120,
                  height: 120,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue[200],
                  ),
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),
                // Profile info
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'John Doe',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text('Software Developer'),
                        SizedBox(height: 16),
                        Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
                        SizedBox(height: 16),
                        Text('Orientation: Landscape'),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

// 4. Flexible & Expanded Example
class FlexibleExpandedExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flexible & Expanded Demo')),
      body: Column(
        children: [
          // Three panel layout
          Expanded(
            flex: 2,
            child: Row(
              children: [
                // Left panel - fixed width
                Container(
                  width: 100,
                  color: Colors.red[100],
                  child: Center(
                    child: Text(
                      'Left\nPanel\n(100px)',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // Middle panel - expands to fill available space
                Expanded(
                  flex: 2, // Takes 2 parts of available space
                  child: Container(
                    color: Colors.green[100],
                    child: Center(
                      child: Text(
                        'Middle\nPanel\n(Expanded x2)',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                // Right panel - takes remaining space
                Expanded(
                  flex: 1, // Takes 1 part of available space
                  child: Container(
                    color: Colors.blue[100],
                    child: Center(
                      child: Text(
                        'Right\nPanel\n(Expanded x1)',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Flexible vs Expanded comparison
          Expanded(
            flex: 1,
            child: Row(
              children: [
                // Expanded - takes all available space
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.orange[100],
                    child: Center(
                      child: Text(
                        'Expanded\n(Takes all space)',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                // Flexible - takes only needed space
                Flexible(
                  flex: 1,
                  child: Container(
                    color: Colors.purple[100],
                    child: Center(
                      child: Text(
                        'Flexible\n(Takes needed space)',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
}

// 5. Responsive Text & Images Example
class ResponsiveTextImageExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(title: Text('Responsive Text & Images')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // FittedBox example
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FittedBox Text Scaling',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: screenWidth * 0.8,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'This text scales down if too large',
                            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // Responsive image with overlay
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * 0.4,
                  child: Stack(
                    children: [
                      // Background image
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.image,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                      // Overlay text
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Responsive Banner',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 6. Responsive Navigation Example
class ResponsiveNavigationExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(title: Text('Responsive Navigation')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (ResponsiveBreakpoints.isMobile(screenWidth)) {
            // Mobile: Bottom navigation
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone_android, size: 64, color: Colors.blue),
                    SizedBox(height: 16),
                    Text(
                      'Mobile Layout',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('Using Bottom Navigation'),
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
                ],
              ),
            );
          } else {
            // Tablet/Desktop: Sidebar navigation
            return Row(
              children: [
                // Sidebar
                Container(
                  width: 250,
                  color: Colors.grey[200],
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Navigation',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text('Home'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(Icons.search),
                        title: Text('Search'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Profile'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Settings'),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                // Main content
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.desktop_windows, size: 64, color: Colors.green),
                        SizedBox(height: 16),
                        Text(
                          'Desktop Layout',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text('Using Sidebar Navigation'),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

// 7. Responsive Dashboard
class ResponsiveDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Responsive Dashboard'),
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          IconButton(icon: Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return _buildDashboardLayout(constraints);
        },
      ),
    );
  }
  
  Widget _buildDashboardLayout(BoxConstraints constraints) {
    final screenWidth = constraints.maxWidth;
    
    if (ResponsiveBreakpoints.isMobile(screenWidth)) {
      // Mobile: Single column layout
      return SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStatsCard('Total Users', '1,234', Icons.people, Colors.blue),
            SizedBox(height: 16),
            _buildStatsCard('Revenue', '\$45,678', Icons.attach_money, Colors.green),
            SizedBox(height: 16),
            _buildStatsCard('Orders', '567', Icons.shopping_cart, Colors.orange),
            SizedBox(height: 16),
            _buildChartCard(),
          ],
        ),
      );
    } else {
      // Tablet/Desktop: Grid layout
      return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Stats row
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(child: _buildStatsCard('Total Users', '1,234', Icons.people, Colors.blue)),
                  SizedBox(width: 16),
                  Expanded(child: _buildStatsCard('Revenue', '\$45,678', Icons.attach_money, Colors.green)),
                  SizedBox(width: 16),
                  Expanded(child: _buildStatsCard('Orders', '567', Icons.shopping_cart, Colors.orange)),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Chart row
            Expanded(
              flex: 3,
              child: _buildChartCard(),
            ),
          ],
        ),
      );
    }
  }
  
  Widget _buildStatsCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildChartCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sales Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bar_chart, size: 64, color: Colors.grey[400]),
                      SizedBox(height: 16),
                      Text(
                        'Chart Area\n(Responsive)',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ],
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
