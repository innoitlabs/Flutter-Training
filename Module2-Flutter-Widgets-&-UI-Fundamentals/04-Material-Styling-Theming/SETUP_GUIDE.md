# Flutter Styling & Theming Setup Guide

## Prerequisites

Before you begin, make sure you have the following installed:

1. **Flutter SDK** (version 3.0.0 or higher)
2. **Dart SDK** (comes with Flutter)
3. **Android Studio** or **VS Code** with Flutter extensions
4. **Git** (for version control)

## Project Setup

### 1. Clone or Download the Project

If you're using Git:
```bash
git clone <repository-url>
cd flutter_styling_theming_demo
```

Or download and extract the project files to your desired directory.

### 2. Install Dependencies

Navigate to the project directory and run:
```bash
flutter pub get
```

This will install all the required dependencies listed in `pubspec.yaml`.

### 3. Run the Project

To run the project on a connected device or emulator:
```bash
flutter run
```

For web development:
```bash
flutter run -d chrome
```

## Project Structure

```
flutter_styling_theming_demo/
├── lib/
│   ├── main.dart                 # Main app entry point
│   ├── models/
│   │   └── note.dart            # Note data model
│   ├── screens/
│   │   └── home_screen.dart     # Main home screen
│   ├── theme/
│   │   ├── app_colors.dart      # Color definitions
│   │   ├── app_theme.dart       # Theme configurations
│   │   └── theme_provider.dart  # Theme state management
│   ├── widgets/
│   │   ├── styled_widgets.dart  # Custom styled widgets
│   │   └── theme_switcher.dart  # Theme switching widget
│   └── examples/
│       ├── basic_styling_examples.dart    # Basic styling examples
│       └── theme_override_examples.dart   # Theme override examples
├── pubspec.yaml                 # Project dependencies
├── README.md                    # Main documentation
├── EXERCISES.md                 # Practice exercises
└── SETUP_GUIDE.md              # This file
```

## Key Files Explained

### 1. `lib/main.dart`
- Entry point of the application
- Sets up the MaterialApp with theme configuration
- Initializes theme provider and loads saved preferences

### 2. `lib/theme/app_theme.dart`
- Contains light and dark theme configurations
- Defines text themes, button themes, card themes, etc.
- Centralized theme management

### 3. `lib/theme/app_colors.dart`
- Defines the color palette for the app
- Includes colors for both light and dark themes
- Semantic color definitions

### 4. `lib/theme/theme_provider.dart`
- Manages theme state using ChangeNotifier
- Handles theme switching logic
- Persists theme preferences

### 5. `lib/screens/home_screen.dart`
- Main application screen
- Demonstrates various styling and theming concepts
- Interactive notes app with theme switching

### 6. `lib/widgets/styled_widgets.dart`
- Custom widgets that demonstrate styling techniques
- Reusable components with theme integration
- Examples of local styling vs theme-based styling

## Features Demonstrated

### 1. Basic Widget Styling
- **Text Styling**: Using TextStyle for fonts, colors, and decorations
- **Container Styling**: BoxDecoration with colors, borders, shadows, and gradients
- **Button Styling**: ButtonStyle for different button types

### 2. App-Wide Theming
- **ThemeData Configuration**: Global theme settings
- **ColorScheme**: Comprehensive color system
- **Text Themes**: Typography hierarchy
- **Component Themes**: Button, card, and input themes

### 3. Dark Mode Support
- **ThemeMode**: Light, dark, and system themes
- **Theme Switching**: Dynamic theme changes
- **Persistence**: Saving theme preferences

### 4. Local Theme Overrides
- **Theme.of(context)**: Accessing current theme
- **copyWith()**: Creating theme variations
- **Local Overrides**: Widget-specific theme changes

## Running Examples

### Basic Styling Examples
To run the basic styling examples:
1. Navigate to `lib/examples/basic_styling_examples.dart`
2. Replace the home screen in `main.dart` with `BasicStylingExamples()`
3. Run the app

### Theme Override Examples
To run the theme override examples:
1. Navigate to `lib/examples/theme_override_examples.dart`
2. Replace the home screen in `main.dart` with `ThemeOverrideExamples()`
3. Run the app

## Customization Guide

### Adding New Colors
1. Open `lib/theme/app_colors.dart`
2. Add your color constants
3. Update the theme files to use the new colors

### Creating Custom Themes
1. Modify `lib/theme/app_theme.dart`
2. Add new theme configurations
3. Update the theme provider if needed

### Adding Custom Widgets
1. Create new files in `lib/widgets/`
2. Use `Theme.of(context)` for theme integration
3. Follow the existing patterns in `styled_widgets.dart`

## Troubleshooting

### Common Issues

1. **Dependencies not found**
   ```bash
   flutter clean
   flutter pub get
   ```

2. **Theme not updating**
   - Check if you're using `Consumer<ThemeProvider>` or `context.watch<ThemeProvider>()`
   - Ensure the theme provider is properly initialized

3. **Colors not showing correctly**
   - Verify color definitions in `app_colors.dart`
   - Check if colors are properly referenced in theme files

4. **Fonts not loading**
   - Ensure font files are in the `fonts/` directory
   - Check `pubspec.yaml` font configuration

### Debug Tips

1. **Use Flutter Inspector**: Inspect widget tree and theme properties
2. **Hot Reload**: Use `r` in terminal for quick testing
3. **Debug Console**: Check for error messages
4. **Theme Debugging**: Add print statements to theme provider

## Best Practices

### 1. Theme Usage
- Always use `Theme.of(context)` instead of hardcoded values
- Prefer semantic color names over specific colors
- Use theme text styles for consistency

### 2. Code Organization
- Keep theme configuration centralized
- Separate concerns (colors, themes, providers)
- Use meaningful file and class names

### 3. Performance
- Avoid creating theme objects in build methods
- Use const constructors where possible
- Minimize theme rebuilds

### 4. Accessibility
- Ensure proper color contrast ratios
- Support system font scaling
- Test with accessibility tools

## Next Steps

After setting up and exploring the project:

1. **Complete the Exercises**: Work through `EXERCISES.md`
2. **Experiment**: Try modifying themes and styles
3. **Build Your Own**: Create a new app using these concepts
4. **Advanced Topics**: Explore Material Design 3, custom painters, etc.

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Material Design Guidelines](https://material.io/design)
- [Flutter Theme Documentation](https://api.flutter.dev/flutter/material/ThemeData-class.html)
- [Provider Package](https://pub.dev/packages/provider)

## Support

If you encounter issues:
1. Check the troubleshooting section above
2. Review Flutter documentation
3. Search for similar issues on Stack Overflow
4. Create an issue in the project repository

Happy coding! 🎨✨
