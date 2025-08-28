# Implementing Responsive Layouts in Flutter

## Learning Objectives

By the end of this module, you will be able to:

1. **Understand responsive design principles** and why they're crucial for modern Flutter applications
2. **Master key Flutter widgets** for responsiveness: MediaQuery, LayoutBuilder, OrientationBuilder, and flexible widgets
3. **Implement adaptive layouts** that work across different screen sizes, orientations, and platforms
4. **Create responsive text and images** that scale appropriately on various devices
5. **Build a complete responsive dashboard** that demonstrates all learned concepts

## Introduction

### Why Responsive Design Matters

In today's digital landscape, your Flutter app needs to work seamlessly across:
- **Mobile phones** (320px - 768px width)
- **Tablets** (768px - 1024px width) 
- **Desktop computers** (1024px+ width)
- **Foldable devices** (variable screen sizes)
- **Web browsers** (resizable windows)
- **Different orientations** (portrait vs landscape)

### Adaptive vs Responsive Design

- **Adaptive Design**: Creates different layouts for specific screen sizes (like having separate mobile and desktop versions)
- **Responsive Design**: Creates a single layout that fluidly adapts to any screen size (more flexible and maintainable)

Flutter excels at responsive design because it uses a constraint-based layout system that naturally adapts to available space.

## MediaQuery Basics

MediaQuery provides information about the current device's screen size, orientation, and other display properties.

### Reading Screen Dimensions

```dart
class ResponsiveExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;
    
    // Calculate responsive values
    final padding = screenWidth * 0.05; // 5% of screen width
    final fontSize = screenWidth * 0.04; // 4% of screen width
    
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: Text(
          'Screen: ${screenWidth.toInt()}x${screenHeight.toInt()}',
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }
}
```

### Example: Adaptive Font Sizes

```dart
class AdaptiveTextExample extends StatelessWidget {
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
      appBar: AppBar(title: Text('Adaptive Text')),
      body: Center(
        child: Text(
          'This text adapts to screen size!',
          style: TextStyle(
            fontSize: getFontSize(),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
```

## LayoutBuilder

LayoutBuilder gives you access to the constraints of the parent widget, allowing you to build layouts that respond to available space.

### Basic LayoutBuilder Example

```dart
class LayoutBuilderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('LayoutBuilder Demo')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // constraints.maxWidth and constraints.maxHeight
          // give us the available space
          
          if (constraints.maxWidth < 600) {
            // Mobile layout - single column
            return Column(
              children: [
                Container(
                  width: constraints.maxWidth,
                  height: 100,
                  color: Colors.blue,
                  child: Center(child: Text('Mobile Layout')),
                ),
                Expanded(
                  child: Container(
                    width: constraints.maxWidth,
                    color: Colors.green,
                    child: Center(child: Text('Content Area')),
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
                  child: Center(child: Text('Sidebar')),
                ),
                Expanded(
                  child: Container(
                    color: Colors.green,
                    child: Center(child: Text('Main Content')),
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
```

### Responsive Grid Example

```dart
class ResponsiveGridExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Responsive Grid')),
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
          
          return GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Item ${index + 1}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
```

## OrientationBuilder

OrientationBuilder helps you adapt your layout based on whether the device is in portrait or landscape mode.

### Profile Page Example

```dart
class ResponsiveProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Responsive Profile')),
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
                        Text('Lorem ipsum dolor sit amet...'),
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
                        Text('Lorem ipsum dolor sit amet...'),
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
```

## Flexible & Expanded Widgets

These widgets help distribute available space among child widgets.

### Three-Panel Layout Example

```dart
class ThreePanelLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Three Panel Layout')),
      body: Row(
        children: [
          // Left panel - fixed width
          Container(
            width: 100,
            color: Colors.red[100],
            child: Center(child: Text('Left\nPanel')),
          ),
          // Middle panel - expands to fill available space
          Expanded(
            flex: 2, // Takes 2 parts of available space
            child: Container(
              color: Colors.green[100],
              child: Center(child: Text('Middle\nPanel\n(Expanded)')),
            ),
          ),
          // Right panel - takes remaining space
          Expanded(
            flex: 1, // Takes 1 part of available space
            child: Container(
              color: Colors.blue[100],
              child: Center(child: Text('Right\nPanel')),
            ),
          ),
        ],
      ),
    );
  }
}
```

### Flexible vs Expanded

```dart
class FlexibleExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flexible vs Expanded')),
      body: Column(
        children: [
          // Expanded - takes all available space
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.red[100],
              child: Center(child: Text('Expanded\n(Takes all space)')),
            ),
          ),
          // Flexible - takes only needed space
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.green[100],
              child: Center(child: Text('Flexible\n(Takes needed space)')),
            ),
          ),
        ],
      ),
    );
  }
}
```

## Responsive Text & Images

### FittedBox for Text Scaling

```dart
class ResponsiveTextExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Responsive Text')),
      body: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'This text will scale down if it\'s too large for the container',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
```

### Responsive Image with Overlay

```dart
class ResponsiveImageExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(title: Text('Responsive Image')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight * 0.4, // 40% of screen height
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
                        fontSize: screenWidth * 0.04, // Responsive font size
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
    );
  }
}
```

## Breakpoints & Conditional Layouts

### Centralized Breakpoint Management

```dart
class ResponsiveBreakpoints {
  static const double mobile = 600;
  static const double tablet = 1024;
  static const double desktop = 1200;
  
  static bool isMobile(double width) => width < mobile;
  static bool isTablet(double width) => width >= mobile && width < tablet;
  static bool isDesktop(double width) => width >= tablet;
}

class ResponsiveNavigation extends StatelessWidget {
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
              body: Center(child: Text('Main Content')),
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
                    ],
                  ),
                ),
                // Main content
                Expanded(
                  child: Center(child: Text('Main Content')),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
```

## Mini Project: Responsive Dashboard

Let's build a complete responsive dashboard that demonstrates all the concepts we've learned.

```dart
import 'package:flutter/material.dart';

class ResponsiveDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
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
                  child: Text(
                    'Chart Area\n(Responsive)',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
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
```

## Best Practices

### 1. Keep UI Simple
- Avoid complex layouts that are hard to maintain
- Use consistent spacing and sizing patterns
- Test on multiple device sizes regularly

### 2. Performance Optimization
- Use `const` widgets where possible
- Avoid rebuilding widgets unnecessarily
- Cache MediaQuery values if used frequently

### 3. Sizing Strategies
- Prefer percentage-based sizing over fixed pixels
- Use `Flexible` and `Expanded` for space distribution
- Set minimum and maximum sizes for critical elements

### 4. Maintainability
- Centralize breakpoints in one place
- Create reusable responsive widgets
- Use consistent naming conventions

### 5. Testing
- Test on real devices when possible
- Use Flutter's device simulator for different screen sizes
- Test both portrait and landscape orientations

## Exercises

### Easy Exercise: Dynamic Text Sizing
Create a widget that changes text size based on screen width using MediaQuery.

**Requirements:**
- Text should be 16px on mobile (< 600px)
- Text should be 20px on tablet (600-1024px)
- Text should be 24px on desktop (> 1024px)

### Intermediate Exercise: Adaptive Grid
Build a grid that adapts its column count based on screen width.

**Requirements:**
- 2 columns on mobile
- 3 columns on tablet
- 4 columns on desktop
- Use LayoutBuilder for constraints

### Advanced Exercise: Responsive Blog Layout
Create a blog layout with:
- Single column on mobile
- Two columns on tablet (content + sidebar)
- Three columns on desktop (navigation + content + sidebar)

**Requirements:**
- Navigation drawer on mobile, sidebar on larger screens
- Responsive images and text
- Proper spacing and typography

## Summary

### Key Takeaways

1. **MediaQuery** provides device information for responsive decisions
2. **LayoutBuilder** gives you constraints to build adaptive layouts
3. **OrientationBuilder** helps handle portrait/landscape changes
4. **Flexible widgets** (Expanded, Flexible) distribute space effectively
5. **Breakpoints** help organize responsive logic consistently
6. **Testing** on multiple devices is crucial for responsive design

### Responsive Design Principles

- **Mobile-first**: Design for mobile first, then enhance for larger screens
- **Fluid layouts**: Use flexible sizing instead of fixed dimensions
- **Consistent experience**: Maintain functionality across all screen sizes
- **Performance**: Optimize for the target devices

### Next Steps

- Practice building responsive layouts regularly
- Explore third-party packages like `flutter_screenutil` for advanced scaling
- Study real-world Flutter apps to see responsive patterns in action
- Experiment with different breakpoint strategies for your specific use cases

Remember: Responsive design is not just about making things fit—it's about creating the best possible user experience across all devices and screen sizes.
