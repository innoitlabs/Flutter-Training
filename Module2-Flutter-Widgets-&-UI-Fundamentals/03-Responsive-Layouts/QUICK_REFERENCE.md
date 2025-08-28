# Flutter Responsive Layouts - Quick Reference

## Key Widgets

### MediaQuery
```dart
// Get screen dimensions
final screenWidth = MediaQuery.of(context).size.width;
final screenHeight = MediaQuery.of(context).size.height;
final orientation = MediaQuery.of(context).orientation;

// Calculate responsive values
final padding = screenWidth * 0.05; // 5% of screen width
final fontSize = screenWidth * 0.04; // 4% of screen width
```

### LayoutBuilder
```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 600) {
      // Mobile layout
      return Column(children: [...]);
    } else {
      // Desktop layout
      return Row(children: [...]);
    }
  },
)
```

### OrientationBuilder
```dart
OrientationBuilder(
  builder: (context, orientation) {
    if (orientation == Orientation.portrait) {
      return Column(children: [...]);
    } else {
      return Row(children: [...]);
    }
  },
)
```

### Flexible & Expanded
```dart
Row(
  children: [
    Container(width: 100), // Fixed width
    Expanded(flex: 2, child: ...), // Takes 2 parts
    Expanded(flex: 1, child: ...), // Takes 1 part
  ],
)
```

## Breakpoints

### Standard Breakpoints
```dart
class ResponsiveBreakpoints {
  static const double mobile = 600;    // < 600px
  static const double tablet = 1024;   // 600px - 1024px
  static const double desktop = 1200;  // > 1024px
  
  static bool isMobile(double width) => width < mobile;
  static bool isTablet(double width) => width >= mobile && width < tablet;
  static bool isDesktop(double width) => width >= tablet;
}
```

### Usage
```dart
final screenWidth = MediaQuery.of(context).size.width;

if (ResponsiveBreakpoints.isMobile(screenWidth)) {
  // Mobile layout
} else if (ResponsiveBreakpoints.isTablet(screenWidth)) {
  // Tablet layout
} else {
  // Desktop layout
}
```

## Responsive Text

### Dynamic Font Sizes
```dart
double getFontSize(double screenWidth) {
  if (screenWidth < 600) return 16.0;      // Mobile
  if (screenWidth < 1024) return 20.0;     // Tablet
  return 24.0;                             // Desktop
}

Text(
  'Responsive Text',
  style: TextStyle(fontSize: getFontSize(screenWidth)),
)
```

### FittedBox for Text Scaling
```dart
FittedBox(
  fit: BoxFit.scaleDown,
  child: Text(
    'This text scales down if too large',
    style: TextStyle(fontSize: 48),
  ),
)
```

## Responsive Grid

### Adaptive Column Count
```dart
LayoutBuilder(
  builder: (context, constraints) {
    int crossAxisCount;
    if (constraints.maxWidth < 600) {
      crossAxisCount = 2; // Mobile: 2 columns
    } else if (constraints.maxWidth < 1024) {
      crossAxisCount = 3; // Tablet: 3 columns
    } else {
      crossAxisCount = 4; // Desktop: 4 columns
    }
    
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
      ),
      // ... rest of grid
    );
  },
)
```

## Responsive Navigation

### Mobile vs Desktop Navigation
```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 600) {
      // Mobile: Bottom navigation
      return Scaffold(
        body: content,
        bottomNavigationBar: BottomNavigationBar(items: [...]),
      );
    } else {
      // Desktop: Sidebar navigation
      return Row(
        children: [
          Container(width: 250, child: sidebar),
          Expanded(child: content),
        ],
      );
    }
  },
)
```

## Responsive Images

### Aspect Ratio
```dart
AspectRatio(
  aspectRatio: 16 / 9,
  child: Image.network('url'),
)
```

### Responsive Image with Overlay
```dart
Container(
  width: constraints.maxWidth,
  height: constraints.maxHeight * 0.4,
  child: Stack(
    children: [
      // Background image
      Container(
        decoration: BoxDecoration(
          color: Colors.blue[300],
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      // Overlay text
      Positioned(
        bottom: 20,
        left: 20,
        child: Text(
          'Overlay Text',
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            color: Colors.white,
          ),
        ),
      ),
    ],
  ),
)
```

## Best Practices

### 1. Performance
```dart
// Cache MediaQuery values
final screenWidth = MediaQuery.of(context).size.width;

// Use const widgets
const SizedBox(height: 16),
const Icon(Icons.home),
```

### 2. Maintainability
```dart
// Centralize breakpoints
class AppBreakpoints {
  static const double mobile = 600;
  static const double tablet = 1024;
}

// Create reusable responsive widgets
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double mobilePadding;
  final double desktopPadding;
  
  // ... implementation
}
```

### 3. Testing
```dart
// Test different screen sizes
// Mobile: 375px width
// Tablet: 768px width  
// Desktop: 1024px+ width

// Test orientations
// Portrait: height > width
// Landscape: width > height
```

## Common Patterns

### Responsive Card Layout
```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 600) {
      return Column(children: cards);
    } else {
      return Row(children: cards);
    }
  },
)
```

### Responsive Text Layout
```dart
Text(
  'Long text content...',
  style: TextStyle(
    fontSize: screenWidth * 0.04,
    height: 1.5,
  ),
  textAlign: screenWidth < 600 ? TextAlign.left : TextAlign.center,
)
```

### Responsive Spacing
```dart
EdgeInsets.all(screenWidth * 0.05), // 5% of screen width
SizedBox(height: screenHeight * 0.02), // 2% of screen height
```

## Debugging Tips

### 1. Visual Debugging
```dart
// Add borders to see layout boundaries
Container(
  decoration: BoxDecoration(
    border: Border.all(color: Colors.red),
  ),
  child: yourWidget,
)
```

### 2. Print Debug Info
```dart
print('Screen width: $screenWidth');
print('Orientation: $orientation');
print('Breakpoint: ${ResponsiveBreakpoints.isMobile(screenWidth) ? "Mobile" : "Desktop"}');
```

### 3. Test on Multiple Devices
- Use Flutter Inspector
- Test on different screen sizes
- Check both orientations
- Verify on real devices

## Quick Checklist

- [ ] Use MediaQuery for screen dimensions
- [ ] Use LayoutBuilder for constraint-based layouts
- [ ] Use OrientationBuilder for orientation changes
- [ ] Define clear breakpoints
- [ ] Test on multiple screen sizes
- [ ] Optimize for performance
- [ ] Keep layouts simple and maintainable
