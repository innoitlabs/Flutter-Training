# Setup and Running Guide

## Prerequisites

- Flutter SDK (>=3.16.0)
- Dart SDK (>=3.6.1)
- Android Studio / VS Code with Flutter extensions
- Android emulator or iOS simulator

## Getting Started

### 1. Clone and Setup

```bash
# Navigate to the project directory
cd flutter_bottom_navigation_demo

# Get dependencies
flutter pub get
```

### 2. Running the Examples

#### Option 1: Launcher (Recommended)
Run the launcher to choose from different examples:

```bash
flutter run -t lib/launcher.dart
```

This will show a menu where you can choose:
- Basic NavigationBar Example
- Advanced Nested Navigators Example
- All Examples Demo

#### Option 2: Individual Examples

**Basic Example:**
```bash
flutter run -t lib/main.dart
```

**Advanced Example:**
```bash
flutter run -t lib/advanced_main.dart
```

**Demo App:**
```bash
flutter run -t lib/demo_app.dart
```

### 3. Testing

Run the widget tests:

```bash
flutter test
```

## Project Structure

```
lib/
├── main.dart                          # Basic NavigationBar example
├── advanced_main.dart                 # Advanced nested navigators example
├── demo_app.dart                      # Comprehensive demo app
├── launcher.dart                      # App launcher
├── screens/                           # Screen implementations
│   ├── home/
│   │   ├── home_screen.dart
│   │   └── home_details_screen.dart
│   ├── search/
│   │   ├── search_screen.dart
│   │   └── search_results_screen.dart
│   └── profile/
│       ├── profile_screen.dart
│       └── profile_settings_screen.dart
├── widgets/
│   └── bottom_navigation_wrapper.dart # Navigation wrapper
├── routes/
│   └── route_generator.dart          # Route management
└── examples/                          # Additional examples
    ├── legacy_bottom_navigation.dart
    ├── responsive_navigation.dart
    └── state_preservation_example.dart
```

## Key Features Demonstrated

### 1. Basic NavigationBar (main.dart)
- Simple NavigationBar implementation
- IndexedStack for state management
- Material 3 theming
- Basic tab switching

### 2. Advanced Nested Navigators (advanced_main.dart)
- Nested navigators for each tab
- Proper back button handling with WillPopScope
- Badge implementation
- State preservation across tabs

### 3. State Preservation (examples/state_preservation_example.dart)
- PageStorageKey for scroll position preservation
- Form input state preservation
- Switch and slider state preservation

### 4. Responsive Design (examples/responsive_navigation.dart)
- Automatic switching between NavigationBar and NavigationRail
- Screen size detection
- Adaptive layout

### 5. Legacy Reference (examples/legacy_bottom_navigation.dart)
- BottomNavigationBar implementation
- Comparison with Material 3 NavigationBar

## Troubleshooting

### Common Issues

1. **Dependencies not found**
   ```bash
   flutter clean
   flutter pub get
   ```

2. **Build errors**
   - Ensure you're using Flutter >=3.16.0
   - Check that Dart SDK >=3.6.1

3. **Navigation not working**
   - Verify that all import statements are correct
   - Check that file paths match the project structure

4. **Badge not showing**
   - Ensure you're using Flutter 3.16+ for Badge widget
   - Check that the Badge widget is properly nested

### Platform-Specific Notes

**Android:**
- Test back button behavior
- Verify safe area handling
- Check navigation gestures

**iOS:**
- Test swipe back gestures
- Verify safe area handling
- Check navigation animations

## Development Tips

1. **Hot Reload**: Use `r` in the terminal for hot reload during development
2. **Hot Restart**: Use `R` in the terminal for hot restart
3. **Debug Mode**: Use `flutter run --debug` for debugging
4. **Profile Mode**: Use `flutter run --profile` for performance testing

## Customization

### Changing Colors
Modify the `ColorScheme.fromSeed()` in the theme:

```dart
colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple), // Change color here
```

### Adding More Tabs
1. Add new screen widgets
2. Update the `_screens` list
3. Add new `NavigationDestination` items
4. Update navigation logic

### Custom Theming
Modify the `NavigationBarThemeData`:

```dart
navigationBarTheme: NavigationBarThemeData(
  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
  // Add custom theming here
),
```

## Next Steps

After running the examples:

1. **Try the Exercises**: Complete the exercises in `EXERCISES.md`
2. **Modify Examples**: Experiment with the code to understand how it works
3. **Build Your Own**: Use these examples as a foundation for your own app
4. **Explore Advanced Topics**: Look into state management, deep linking, and custom animations

## Support

If you encounter issues:

1. Check the Flutter documentation
2. Review the code comments for explanations
3. Run `flutter doctor` to verify your setup
4. Check the troubleshooting section above

## Contributing

Feel free to:
- Add new examples
- Improve existing code
- Add more exercises
- Enhance documentation
