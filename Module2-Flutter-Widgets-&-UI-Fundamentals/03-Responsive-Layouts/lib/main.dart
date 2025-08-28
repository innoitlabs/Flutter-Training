import 'package:flutter/material.dart';
import 'responsive_examples.dart';

void main() {
  runApp(ResponsiveLayoutsDemo());
}

class ResponsiveLayoutsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Layouts Demo',
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
        title: Text('Responsive Layouts Demo'),
        elevation: 2,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive grid layout for examples
          int crossAxisCount;
          if (constraints.maxWidth < 600) {
            crossAxisCount = 1; // Mobile: single column
          } else if (constraints.maxWidth < 1024) {
            crossAxisCount = 2; // Tablet: 2 columns
          } else {
            crossAxisCount = 3; // Desktop: 3 columns
          }

          return GridView.count(
            crossAxisCount: crossAxisCount,
            padding: EdgeInsets.all(16),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildExampleCard(
                context,
                'MediaQuery Basics',
                'Learn how to read screen dimensions and adapt UI accordingly',
                Icons.screen_rotation,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MediaQueryExample()),
                ),
              ),
              _buildExampleCard(
                context,
                'LayoutBuilder',
                'Build layouts that respond to available space constraints',
                Icons.grid_on,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LayoutBuilderExample()),
                ),
              ),
              _buildExampleCard(
                context,
                'OrientationBuilder',
                'Adapt layouts for portrait and landscape orientations',
                Icons.screen_rotation_alt,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrientationBuilderExample()),
                ),
              ),
              _buildExampleCard(
                context,
                'Flexible & Expanded',
                'Distribute available space among child widgets',
                Icons.view_column,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FlexibleExpandedExample()),
                ),
              ),
              _buildExampleCard(
                context,
                'Responsive Text & Images',
                'Scale text and images appropriately across devices',
                Icons.text_fields,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResponsiveTextImageExample()),
                ),
              ),
              _buildExampleCard(
                context,
                'Responsive Navigation',
                'Adapt navigation patterns for different screen sizes',
                Icons.navigation,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResponsiveNavigationExample()),
                ),
              ),
              _buildExampleCard(
                context,
                'Responsive Dashboard',
                'Complete dashboard that adapts to all screen sizes',
                Icons.dashboard,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResponsiveDashboard()),
                ),
              ),
            ],
          );
        },
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
