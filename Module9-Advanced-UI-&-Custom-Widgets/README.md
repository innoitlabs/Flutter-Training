# Module 9 — Advanced UI & Custom Widgets (Dart 3.6.1)

## Learning Objectives

- **Create reusable custom widgets** with clean APIs and proper composition
- **Implement complex layouts** using SliverAppBar, CustomScrollView, and advanced Material widgets
- **Use InheritedWidget** for state propagation down the widget tree without external packages
- **Apply CustomPainter** for drawing custom shapes, charts, and visual effects
- **Explore theme customization** with ThemeExtension for consistent branding
- **Master advanced composition patterns** for scalable and maintainable UI code

## Key Concepts

### Custom Widget Creation
- **Stateless vs Stateful**: Choose based on whether the widget needs to maintain internal state
- **Composition over inheritance**: Build complex widgets by combining simpler ones
- **Clean APIs**: Design widgets with clear, intuitive parameters and callbacks
- **Reusability**: Create widgets that can be used across different contexts

### InheritedWidget
- **State propagation**: Share data down the widget tree without prop drilling
- **Automatic rebuilding**: Descendant widgets automatically rebuild when inherited data changes
- **Performance optimization**: Only widgets that depend on the data are rebuilt
- **Context access**: Use `context.dependOnInheritedWidgetOfExactType()` to access data

### CustomPainter
- **Canvas drawing**: Use Canvas and Paint for pixel-level control
- **Custom shapes**: Draw circles, arcs, paths, and complex geometries
- **Performance**: Implement `shouldRepaint()` to optimize rendering
- **Animation support**: Combine with AnimationController for smooth transitions

### Advanced Layout
- **CustomScrollView**: Coordinate multiple scrollable widgets
- **SliverAppBar**: Collapsing headers with flexible space
- **SliverGrid & SliverList**: Efficient scrolling lists and grids
- **SliverToBoxAdapter**: Convert regular widgets to slivers

### Theme Customization
- **ThemeExtension**: Extend ThemeData with custom properties
- **Brand consistency**: Centralize brand colors and styling
- **Material 3**: Use modern Material Design with `useMaterial3: true`
- **Dark/Light themes**: Support both theme modes with custom extensions

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── app/
│   ├── app.dart                 # App exports
│   └── theme.dart               # Theme configuration & extensions
└── features/
    ├── home/
    │   └── home_page.dart       # Main navigation hub
    ├── profile/
    │   └── profile_card.dart    # Custom ProfileCard widget
    ├── layout/
    │   └── sliver_demo_page.dart # Advanced layout with slivers
    ├── theme/
    │   └── theme_controller.dart # InheritedWidget demo
    └── painter/
        └── progress_painter.dart # CustomPainter examples
```

## Runnable Examples

### Example A: Custom Widgets (ProfileCard)
- **Location**: `lib/features/profile/profile_card.dart`
- **Demonstrates**: Widget composition, reusability, clean API design
- **Features**: Avatar, user info, action buttons, error handling
- **Key Concepts**: Composition, conditional rendering, callback parameters

### Example B: Advanced Layout (Slivers)
- **Location**: `lib/features/layout/sliver_demo_page.dart`
- **Demonstrates**: CustomScrollView, SliverAppBar, SliverGrid, SliverList
- **Features**: Collapsing header, grid + list hybrid layout
- **Key Concepts**: Sliver coordination, efficient scrolling, complex layouts

### Example C: InheritedWidget Demo
- **Location**: `lib/features/theme/theme_controller.dart`
- **Demonstrates**: State propagation, automatic rebuilding
- **Features**: Theme color toggling, descendant widget updates
- **Key Concepts**: InheritedWidget pattern, context dependency, state management

### Example D: CustomPainter
- **Location**: `lib/features/painter/progress_painter.dart`
- **Demonstrates**: Canvas drawing, custom shapes, animations
- **Features**: Progress rings, pie charts, smooth animations
- **Key Concepts**: CustomPainter, Canvas API, Paint properties, shouldRepaint

### Example E: Theme Customization
- **Location**: `lib/app/theme.dart`
- **Demonstrates**: ThemeExtension, brand color management
- **Features**: Custom brand colors, light/dark theme support
- **Key Concepts**: ThemeExtension, ColorScheme, Material 3 theming

## Run & Verify — iOS Simulator

### Prerequisites
- Flutter SDK (latest stable)
- Dart 3.6.1 or higher
- Xcode (for iOS development)
- iOS Simulator

### Steps

1. **Get dependencies**:
   ```bash
   flutter pub get
   ```

2. **Launch iOS Simulator**:
   ```bash
   open -a Simulator
   ```
   Or launch via Xcode: Xcode → Open Developer Tool → Simulator

3. **Verify simulator is available**:
   ```bash
   flutter devices
   ```
   Confirm iOS Simulator is listed in the output.

4. **Run the app**:
   ```bash
   flutter run -d ios
   ```

### Verification Checklist

- ✅ **ProfileCard**: Shows styled user info with avatar, name, email, and action buttons
- ✅ **SliverAppBar**: Collapses/expands smoothly when scrolling
- ✅ **InheritedWidget**: Toggle custom theme colors and see descendant widgets update automatically
- ✅ **Progress Ring**: Draws correctly with percentage and animates smoothly
- ✅ **Theme Extension**: Custom brand colors applied consistently across the app
- ✅ **Navigation**: All demo pages accessible from the home screen

## Best Practices Recap

### Widget Design
- **Composition over inheritance**: Always prefer combining widgets over extending them
- **Small, focused widgets**: Keep widgets small and focused on a single responsibility
- **Clean APIs**: Design intuitive parameters and provide sensible defaults
- **Null safety**: Use nullable types appropriately and provide fallbacks

### Performance
- **const constructors**: Use const where possible to improve performance
- **shouldRepaint**: Implement properly in CustomPainter to avoid unnecessary repaints
- **Sliver efficiency**: Use slivers for large lists and grids
- **Widget extraction**: Extract reusable parts to avoid rebuilding

### State Management
- **InheritedWidget sparingly**: Use for simple state propagation, prefer state management for complex apps
- **Lifecycle management**: Properly dispose of controllers and listeners
- **State immutability**: Use immutable data classes for state

### Theming
- **Centralized branding**: Use ThemeExtension for consistent brand colors
- **Material 3**: Leverage modern Material Design features
- **Accessibility**: Ensure proper contrast ratios and semantic labels

## Exercises

### Easy: RatingStars Widget
Create a custom `RatingStars` widget that displays filled/unfilled stars based on a rating value.

```dart
class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 24.0,
    this.onRatingChanged,
  });

  final double rating;
  final int maxRating;
  final double size;
  final ValueChanged<double>? onRatingChanged;

  // Implementation here...
}
```

### Intermediate: Expandable ProfileCard
Extend the ProfileCard widget with expandable details section.

```dart
class ExpandableProfileCard extends StatefulWidget {
  // Add expansion functionality to ProfileCard
  // Include animation for smooth expand/collapse
  // Add more user details (bio, location, etc.)
}
```

### Advanced: Animated DonutChart
Create a `DonutChartPainter` with labels and smooth animations.

```dart
class DonutChartPainter extends CustomPainter {
  // Draw donut chart with labels
  // Support animations
  // Include hover effects
  // Add legends and tooltips
}
```

## Code Quality & Constraints

- **Dart SDK**: `>=3.6.1 <4.0.0`
- **Flutter**: Latest stable SDK with Material 3
- **Null Safety**: Full null safety compliance
- **No External Dependencies**: Only Flutter SDK required for core module
- **Accessibility**: Proper semantic labels and contrast ratios
- **Documentation**: Inline comments explaining key concepts

## Troubleshooting

### Common Issues

1. **Simulator not found**: Ensure Xcode is installed and iOS Simulator is running
2. **Dart version mismatch**: Verify Dart 3.6.1+ is installed
3. **Build errors**: Run `flutter clean` and `flutter pub get`
4. **Performance issues**: Check for unnecessary rebuilds and optimize CustomPainter

### Debug Tips

- Use `flutter doctor` to verify setup
- Enable debug mode for detailed error messages
- Use Flutter Inspector to inspect widget tree
- Profile performance with Flutter DevTools

---

**Happy Learning! 🚀**

This module provides a solid foundation for advanced Flutter UI development. Practice the concepts, experiment with the code, and build upon these examples to create amazing user experiences.
