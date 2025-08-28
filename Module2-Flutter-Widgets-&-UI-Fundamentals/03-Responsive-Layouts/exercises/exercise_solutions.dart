import 'package:flutter/material.dart';

// Exercise 1: Dynamic Text Sizing
class DynamicTextSizingExercise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Define responsive font sizes
    double getFontSize() {
      if (screenWidth < 600) return 16.0;      // Mobile
      if (screenWidth < 1024) return 20.0;     // Tablet
      return 24.0;                             // Desktop
    }
    
    return Scaffold(
      appBar: AppBar(title: Text('Exercise 1: Dynamic Text Sizing')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Responsive Text Example',
                style: TextStyle(
                  fontSize: getFontSize(),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Current font size: ${getFontSize().toStringAsFixed(1)}px',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 8),
              Text(
                'Screen width: ${screenWidth.toInt()}px',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Exercise 2: Adaptive Grid
class AdaptiveGridExercise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exercise 2: Adaptive Grid')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate number of columns based on screen width
          int crossAxisCount;
          if (constraints.maxWidth < 600) {
            crossAxisCount = 2; // Mobile: 2 columns
          } else if (constraints.maxWidth < 1024) {
            crossAxisCount = 3; // Tablet: 3 columns
          } else {
            crossAxisCount = 4; // Desktop: 4 columns
          }
          
          return Column(
            children: [
              // Info panel
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.blue[50],
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      'Grid adapts to screen size: $crossAxisCount columns',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // Grid
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue[300]!),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Colors.blue[700]),
                            SizedBox(height: 8),
                            Text(
                              'Item ${index + 1}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Exercise 3: Responsive Blog Layout
class ResponsiveBlogLayoutExercise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exercise 3: Responsive Blog Layout')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          
          if (screenWidth < 600) {
            // Mobile: Single column with drawer
            return Scaffold(
              body: _buildBlogContent(),
              drawer: _buildNavigationDrawer(),
            );
          } else if (screenWidth < 1024) {
            // Tablet: Two columns (content + sidebar)
            return Row(
              children: [
                // Main content
                Expanded(
                  flex: 2,
                  child: _buildBlogContent(),
                ),
                // Sidebar
                Container(
                  width: 250,
                  child: _buildSidebar(),
                ),
              ],
            );
          } else {
            // Desktop: Three columns (navigation + content + sidebar)
            return Row(
              children: [
                // Navigation
                Container(
                  width: 200,
                  child: _buildNavigation(),
                ),
                // Main content
                Expanded(
                  flex: 3,
                  child: _buildBlogContent(),
                ),
                // Sidebar
                Container(
                  width: 250,
                  child: _buildSidebar(),
                ),
              ],
            );
          }
        },
      ),
    );
  }
  
  Widget _buildNavigation() {
    return Container(
      color: Colors.grey[100],
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
            leading: Icon(Icons.article),
            title: Text('Articles'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Categories'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('About'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
  
  Widget _buildNavigationDrawer() {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              child: Text(
                'Blog Navigation',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.article),
            title: Text('Articles'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Categories'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('About'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
  
  Widget _buildBlogContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured Article',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.image, size: 64, color: Colors.white),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Responsive Design in Flutter',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Published on December 1, 2024',
            style: TextStyle(color: Colors.grey[600]),
          ),
          SizedBox(height: 16),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          SizedBox(height: 16),
          Text(
            'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSidebar() {
    return Container(
      color: Colors.grey[50],
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Posts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildSidebarItem('Getting Started with Flutter', 'Nov 28, 2024'),
            _buildSidebarItem('State Management Patterns', 'Nov 25, 2024'),
            _buildSidebarItem('UI/UX Best Practices', 'Nov 22, 2024'),
            _buildSidebarItem('Performance Optimization', 'Nov 19, 2024'),
            SizedBox(height: 24),
            Text(
              'Categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildCategoryItem('Flutter', 15),
            _buildCategoryItem('Dart', 8),
            _buildCategoryItem('UI/UX', 12),
            _buildCategoryItem('Performance', 6),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSidebarItem(String title, String date) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 4),
          Text(
            date,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoryItem(String name, int count) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: TextStyle(fontSize: 12, color: Colors.blue[700]),
            ),
          ),
        ],
      ),
    );
  }
}
