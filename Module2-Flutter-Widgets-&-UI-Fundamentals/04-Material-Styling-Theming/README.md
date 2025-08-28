# Styling and Theming in Flutter

## Learning Objectives

By the end of this module, you will be able to:

1. **Understand the difference** between styling individual widgets and app-wide theming
2. **Apply basic styling** to Text, Container, and Button widgets using their respective style properties
3. **Configure global themes** using ThemeData in MaterialApp with custom colors, fonts, and text themes
4. **Implement dark mode support** using ThemeMode and create theme switching functionality
5. **Override themes locally** using Theme.of(context) and copyWith() for specific widget customization

## Introduction

### Why Styling and Theming Matter

Styling and theming are crucial for creating professional, user-friendly Flutter applications. They provide:

- **Consistency**: Uniform appearance across your entire app
- **Branding**: Reflect your brand identity through colors, fonts, and design
- **User Experience**: Better readability, accessibility, and visual hierarchy
- **Maintainability**: Centralized design system that's easy to update

### Styling vs Theming

- **Styling**: Applied to individual widgets (local scope)
  - Example: Setting a specific color for one Text widget
  - Use widget-specific style properties like `TextStyle`, `BoxDecoration`, `ButtonStyle`

- **Theming**: Applied app-wide (global scope)
  - Example: Setting the primary color for the entire app
  - Use `ThemeData` in `MaterialApp` to define global design rules

## Basic Widget Styling

### 1. Text Styling with TextStyle

The `TextStyle` class allows you to customize text appearance:

```dart
Text(
  'Hello Flutter!',
  style: TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
    fontFamily: 'Roboto',
    letterSpacing: 1.2,
    height: 1.5,
  ),
)
```

**Key TextStyle Properties:**
- `fontSize`: Text size in logical pixels
- `fontWeight`: Font weight (normal, bold, w100-w900)
- `color`: Text color
- `fontFamily`: Font family name
- `letterSpacing`: Space between characters
- `height`: Line height multiplier
- `decoration`: Text decorations (underline, overline, lineThrough)

### 2. Container Styling with BoxDecoration

`BoxDecoration` provides extensive styling options for containers:

```dart
Container(
  width: 200,
  height: 100,
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        offset: Offset(0, 4),
        blurRadius: 8,
      ),
    ],
    gradient: LinearGradient(
      colors: [Colors.blue, Colors.purple],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    border: Border.all(
      color: Colors.white,
      width: 2,
    ),
  ),
  child: Center(
    child: Text(
      'Styled Container',
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
  ),
)
```

**Key BoxDecoration Properties:**
- `color`: Background color
- `borderRadius`: Corner radius
- `boxShadow`: Shadow effects
- `gradient`: Color gradients
- `border`: Border styling
- `shape`: Container shape (rectangle, circle)

### 3. Button Styling with ButtonStyle

Modern Flutter buttons use `ButtonStyle` for consistent styling:

```dart
ElevatedButton(
  onPressed: () {},
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.green),
    foregroundColor: MaterialStateProperty.all(Colors.white),
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    elevation: MaterialStateProperty.all(4),
  ),
  child: Text('Styled Button'),
)
```

**Key ButtonStyle Properties:**
- `backgroundColor`: Button background color
- `foregroundColor`: Text/icon color
- `padding`: Internal spacing
- `shape`: Button shape and border radius
- `elevation`: Shadow depth
- `overlayColor`: Press state color

## App-Wide Theming

### ThemeData Configuration

`ThemeData` in `MaterialApp` defines your app's global design system:

```dart
MaterialApp(
  title: 'Flutter Theming Demo',
  theme: ThemeData(
    // Color Scheme
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue[700],
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
    
    // Scaffold
    scaffoldBackgroundColor: Colors.grey[50],
    
    // Text Themes
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.blue[900],
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.grey[800],
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    
    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue[700],
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    
    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    
    // Card Theme
    cardTheme: CardTheme(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  home: MyHomePage(),
)
```

### ColorScheme

`ColorScheme` provides a comprehensive color system:

```dart
colorScheme: ColorScheme.fromSeed(
  seedColor: Colors.blue,
  brightness: Brightness.light,
  // Custom colors
  primary: Colors.blue[700]!,
  secondary: Colors.orange[600]!,
  surface: Colors.white,
  background: Colors.grey[50]!,
  error: Colors.red[600]!,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onSurface: Colors.grey[900]!,
  onBackground: Colors.grey[900]!,
  onError: Colors.white,
)
```

## Dark Mode Support

### ThemeMode Configuration

Flutter supports three theme modes:

```dart
MaterialApp(
  title: 'Flutter Theming Demo',
  theme: ThemeData.light(), // Light theme
  darkTheme: ThemeData.dark(), // Dark theme
  themeMode: ThemeMode.system, // Follows system preference
  home: MyHomePage(),
)
```

### Custom Dark Theme

```dart
darkTheme: ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: Colors.grey[900],
  cardColor: Colors.grey[850],
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: Colors.grey[300],
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900],
    foregroundColor: Colors.white,
  ),
)
```

### Theme Switching

```dart
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  
  ThemeMode get themeMode => _themeMode;
  
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}

// Usage in MaterialApp
MaterialApp(
  themeMode: themeProvider.themeMode,
  // ... other properties
)
```

## Overriding Themes Locally

### Using Theme.of(context)

Access the current theme anywhere in your widget tree:

```dart
Widget build(BuildContext context) {
  final theme = Theme.of(context);
  
  return Container(
    color: theme.colorScheme.primary,
    child: Text(
      'Using Theme Colors',
      style: theme.textTheme.headlineMedium?.copyWith(
        color: theme.colorScheme.onPrimary,
      ),
    ),
  );
}
```

### Local Theme Override

Use the `Theme` widget to override theme for specific widgets:

```dart
Theme(
  data: Theme.of(context).copyWith(
    textTheme: Theme.of(context).textTheme.copyWith(
      bodyLarge: TextStyle(
        fontSize: 18,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  child: Text('This text uses the overridden theme'),
)
```

### copyWith() Method

Create theme variations using `copyWith()`:

```dart
// Override specific theme properties
final customTheme = Theme.of(context).copyWith(
  primaryColor: Colors.green,
  textTheme: Theme.of(context).textTheme.copyWith(
    headlineLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w300,
      color: Colors.green,
    ),
  ),
);
```

## Mini Project: Styled Notes App

Let's build a complete notes app that demonstrates all the styling and theming concepts:

### Features:
- AppBar with theme colors
- List of notes with custom card styling
- Add note button using theme styling
- Dark/light mode toggle
- Responsive design using theme colors

### Key Implementation Points:
1. **Global Theme**: Define consistent colors and styles
2. **Dark Mode**: Support both light and dark themes
3. **Local Styling**: Custom card designs and button styles
4. **Theme Access**: Use `Theme.of(context)` throughout the app

## Best Practices

### 1. Centralize Theme Configuration
```dart
// Create a separate theme file
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    // All light theme configuration
  );
  
  static ThemeData darkTheme = ThemeData(
    // All dark theme configuration
  );
}
```

### 2. Use Consistent Color Schemes
```dart
// Define a color palette
class AppColors {
  static const primary = Color(0xFF2196F3);
  static const secondary = Color(0xFFFF9800);
  static const background = Color(0xFFF5F5F5);
  static const surface = Color(0xFFFFFFFF);
  static const error = Color(0xFFD32F2F);
}
```

### 3. Prefer Theme.of(context) Over Hardcoded Values
```dart
// Good
Text(
  'Hello',
  style: Theme.of(context).textTheme.headlineMedium,
)

// Avoid
Text(
  'Hello',
  style: TextStyle(fontSize: 24, color: Colors.black),
)
```

### 4. Support System Theme by Default
```dart
MaterialApp(
  themeMode: ThemeMode.system, // Respects user's system preference
  // ... other properties
)
```

### 5. Use Semantic Colors
```dart
// Use semantic color names
color: theme.colorScheme.primary, // Instead of hardcoded blue
color: theme.colorScheme.error,   // Instead of hardcoded red
```

## Exercises

### Easy Exercise: Text Styling
Create a Text widget with custom styling:
- Font size: 20
- Font weight: bold
- Color: blue
- Font family: 'Roboto'

### Intermediate Exercise: Custom Theme
Create a custom ThemeData with:
- Primary color: green
- Secondary color: orange
- Custom text theme for headlines
- Custom button style

### Advanced Exercise: Theme Switcher
Implement a complete theme switching system:
- Toggle between light, dark, and system themes
- Persist theme choice using SharedPreferences
- Update UI immediately when theme changes

## Summary

### Key Takeaways:

1. **Styling vs Theming**: 
   - Styling is widget-specific, theming is app-wide
   - Use styling for unique cases, theming for consistency

2. **Global vs Local**:
   - Global themes provide consistency across the app
   - Local overrides allow customization when needed

3. **Dark Mode**:
   - Always support both light and dark themes
   - Use `ThemeMode.system` to respect user preferences
   - Test your app in both themes

4. **Best Practices**:
   - Centralize theme configuration
   - Use semantic color names
   - Prefer `Theme.of(context)` over hardcoded values
   - Support accessibility with proper contrast ratios

### Next Steps:
- Explore advanced theming with custom widgets
- Learn about responsive design with themes
- Study Material Design 3 guidelines
- Practice creating custom color schemes

---

## 📚 Additional Resources

### Quick Start
- **[Quick Start Guide](QUICK_START.md)** - Get up and running in 5 minutes
- **[Setup Guide](SETUP_GUIDE.md)** - Detailed setup instructions and troubleshooting

### Learning Materials
- **[Exercises](EXERCISES.md)** - 10 hands-on exercises with solutions
- **[Code Examples](lib/examples/)** - Practical examples demonstrating concepts

### Project Structure
```
lib/
├── main.dart                 # App entry point
├── models/note.dart         # Data model
├── screens/home_screen.dart # Main UI
├── theme/                   # Theme configuration
│   ├── app_colors.dart     # Color definitions
│   ├── app_theme.dart      # Theme data
│   └── theme_provider.dart # Theme state management
├── widgets/                 # Custom widgets
│   ├── styled_widgets.dart # Styled components
│   └── theme_switcher.dart # Theme switching UI
└── examples/               # Learning examples
    ├── basic_styling_examples.dart
    └── theme_override_examples.dart
```

## 🚀 Getting Started

1. **Quick Start**: Follow [QUICK_START.md](QUICK_START.md) for immediate setup
2. **Detailed Setup**: Use [SETUP_GUIDE.md](SETUP_GUIDE.md) for comprehensive instructions
3. **Practice**: Work through [EXERCISES.md](EXERCISES.md) for hands-on learning
4. **Explore**: Run the app and experiment with the theme switcher

## 🎯 Learning Path

1. **Start with the App**: Run the project and explore the interactive features
2. **Read the Documentation**: Understand concepts through the detailed explanations
3. **Practice with Exercises**: Complete the hands-on exercises
4. **Experiment**: Modify the code and see how changes affect the app
5. **Build Your Own**: Apply these concepts to your own projects

---

**Remember**: Good theming creates a cohesive, professional app experience that users will love to use!

## 📖 Navigation

- **[Quick Start](QUICK_START.md)** - Get started immediately
- **[Setup Guide](SETUP_GUIDE.md)** - Detailed setup and troubleshooting
- **[Exercises](EXERCISES.md)** - Practice exercises with solutions
- **[Main App](lib/main.dart)** - Run the complete demo app
- **[Examples](lib/examples/)** - Code examples for learning
