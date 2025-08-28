# Flutter Styling & Theming Exercises

## Exercise 1: Basic Text Styling (Easy)

**Objective**: Practice basic text styling with TextStyle

**Task**: Create a Text widget with the following specifications:
- Font size: 20
- Font weight: bold
- Color: blue
- Font family: 'Roboto'
- Letter spacing: 1.2
- Line height: 1.5

**Expected Output**: A blue, bold text with increased letter spacing and line height.

**Solution**:
```dart
Text(
  'Your styled text here',
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
    fontFamily: 'Roboto',
    letterSpacing: 1.2,
    height: 1.5,
  ),
)
```

---

## Exercise 2: Container Styling (Easy)

**Objective**: Practice container styling with BoxDecoration

**Task**: Create a Container with the following specifications:
- Width: 200, Height: 100
- Background color: purple
- Border radius: 12
- Box shadow: black with 26% opacity, offset (0, 4), blur radius 8
- Border: white, width 2

**Expected Output**: A purple container with rounded corners, shadow, and white border.

**Solution**:
```dart
Container(
  width: 200,
  height: 100,
  decoration: BoxDecoration(
    color: Colors.purple,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        offset: Offset(0, 4),
        blurRadius: 8,
      ),
    ],
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

---

## Exercise 3: Button Styling (Easy)

**Objective**: Practice button styling with ButtonStyle

**Task**: Create an ElevatedButton with the following specifications:
- Background color: green
- Text color: white
- Padding: horizontal 24, vertical 12
- Border radius: 8
- Elevation: 4

**Expected Output**: A green elevated button with white text and rounded corners.

**Solution**:
```dart
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 4,
  ),
  child: Text('Styled Button'),
)
```

---

## Exercise 4: Custom Theme Creation (Intermediate)

**Objective**: Create a custom ThemeData with specific colors and styles

**Task**: Create a custom ThemeData with the following specifications:
- Primary color: green
- Secondary color: orange
- Custom text theme for headlines (fontSize: 28, fontWeight: bold, color: green)
- Custom button style (backgroundColor: green, foregroundColor: white, borderRadius: 12)

**Expected Output**: A complete theme that can be applied to MaterialApp.

**Solution**:
```dart
ThemeData(
  primarySwatch: Colors.green,
  primaryColor: Colors.green,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.green,
    secondary: Colors.orange,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.green,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
)
```

---

## Exercise 5: Theme Access and Override (Intermediate)

**Objective**: Practice accessing theme properties and overriding them locally

**Task**: Create a widget that:
1. Uses Theme.of(context) to access the current theme
2. Displays text using theme colors
3. Overrides the text style for one specific widget using copyWith()

**Expected Output**: A widget that shows theme-based styling with one local override.

**Solution**:
```dart
Widget build(BuildContext context) {
  final theme = Theme.of(context);
  
  return Column(
    children: [
      // Using theme colors
      Container(
        color: theme.colorScheme.primary,
        padding: EdgeInsets.all(16),
        child: Text(
          'Theme-based text',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
      
      // Local override
      Text(
        'Overridden text',
        style: theme.textTheme.bodyLarge?.copyWith(
          fontSize: 20,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
```

---

## Exercise 6: Dark Mode Implementation (Advanced)

**Objective**: Implement a complete dark mode system

**Task**: Create a theme switching system with:
1. Light and dark themes
2. Theme provider using ChangeNotifier
3. Theme switching functionality
4. Persistence using SharedPreferences

**Expected Output**: A complete app with working dark/light mode toggle.

**Solution**:

**ThemeProvider**:
```dart
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  
  ThemeMode get themeMode => _themeMode;
  
  void setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', mode.index);
  }
}
```

**MaterialApp**:
```dart
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: themeProvider.themeMode,
  home: MyHomePage(),
)
```

**Theme Switcher**:
```dart
IconButton(
  onPressed: () {
    final currentMode = themeProvider.themeMode;
    if (currentMode == ThemeMode.light) {
      themeProvider.setThemeMode(ThemeMode.dark);
    } else {
      themeProvider.setThemeMode(ThemeMode.light);
    }
  },
  icon: Icon(
    themeProvider.themeMode == ThemeMode.dark 
        ? Icons.light_mode 
        : Icons.dark_mode,
  ),
)
```

---

## Exercise 7: Custom Widget with Theme Integration (Advanced)

**Objective**: Create a custom widget that fully integrates with the theme system

**Task**: Create a custom card widget that:
1. Uses theme colors for background, text, and borders
2. Adapts to light/dark themes
3. Has customizable content
4. Uses theme text styles
5. Supports elevation changes

**Expected Output**: A reusable card widget that works with any theme.

**Solution**:
```dart
class ThemedCard extends StatelessWidget {
  final Widget child;
  final double elevation;
  final EdgeInsetsGeometry? padding;
  
  const ThemedCard({
    super.key,
    required this.child,
    this.elevation = 4,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Card(
      elevation: elevation,
      color: isDark ? Colors.grey[850] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
```

---

## Exercise 8: Responsive Theming (Advanced)

**Objective**: Create a theme that adapts to different screen sizes

**Task**: Create a theme system that:
1. Adjusts font sizes based on screen width
2. Changes padding and margins for different screen sizes
3. Adapts button sizes for mobile vs tablet
4. Uses MediaQuery to detect screen dimensions

**Expected Output**: A responsive theme that looks good on all screen sizes.

**Solution**:
```dart
class ResponsiveTheme {
  static ThemeData getTheme(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    
    return ThemeData(
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: isTablet ? 32 : 24,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          fontSize: isTablet ? 18 : 16,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 32 : 24,
            vertical: isTablet ? 16 : 12,
          ),
          textStyle: TextStyle(
            fontSize: isTablet ? 18 : 16,
          ),
        ),
      ),
    );
  }
}
```

---

## Exercise 9: Color Palette Creation (Intermediate)

**Objective**: Create a comprehensive color palette system

**Task**: Create a color palette class with:
1. Primary, secondary, and accent colors
2. Light and dark variants
3. Semantic colors (success, warning, error, info)
4. Helper methods for opacity variations

**Expected Output**: A complete color system that can be used throughout the app.

**Solution**:
```dart
class AppColorPalette {
  // Primary colors
  static const primary = Color(0xFF2196F3);
  static const primaryLight = Color(0xFF64B5F6);
  static const primaryDark = Color(0xFF1976D2);
  
  // Secondary colors
  static const secondary = Color(0xFFFF9800);
  static const secondaryLight = Color(0xFFFFB74D);
  static const secondaryDark = Color(0xFFF57C00);
  
  // Semantic colors
  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFFC107);
  static const error = Color(0xFFD32F2F);
  static const info = Color(0xFF2196F3);
  
  // Helper methods
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
  
  static Color getShade(Color color, int shade) {
    // Implementation for getting different shades
    return color;
  }
}
```

---

## Exercise 10: Complete App Theming (Advanced)

**Objective**: Apply all learned concepts to create a fully themed app

**Task**: Create a complete app with:
1. Custom light and dark themes
2. Theme switching functionality
3. Responsive design
4. Custom widgets that use theme
5. Consistent styling throughout
6. Accessibility considerations

**Expected Output**: A professional-looking app with complete theming system.

**Key Components**:
- ThemeProvider for state management
- AppTheme class with light/dark themes
- Custom widgets (ThemedCard, ThemedButton, etc.)
- Responsive layout
- Accessibility features (high contrast, large text support)

---

## Bonus Exercise: Animation with Themes

**Objective**: Create smooth transitions between themes

**Task**: Add animated transitions when switching themes:
1. Animate color changes
2. Smooth transitions for text styles
3. Animated theme switcher icon
4. Transition effects for containers

**Expected Output**: Smooth, animated theme transitions.

**Solution**:
```dart
AnimatedContainer(
  duration: Duration(milliseconds: 300),
  color: theme.colorScheme.background,
  child: AnimatedDefaultTextStyle(
    duration: Duration(milliseconds: 300),
    style: theme.textTheme.bodyLarge!,
    child: YourContent(),
  ),
)
```

---

## Submission Guidelines

For each exercise:
1. Create a new Dart file with your solution
2. Include comments explaining your approach
3. Test your code to ensure it works correctly
4. Consider edge cases and error handling
5. Follow Flutter best practices and conventions

## Evaluation Criteria

- **Correctness**: Does the code work as expected?
- **Theme Integration**: Does it properly use theme properties?
- **Code Quality**: Is the code clean, readable, and well-structured?
- **Best Practices**: Does it follow Flutter conventions?
- **Creativity**: Does it show understanding beyond basic requirements?

## Tips for Success

1. **Start Simple**: Begin with basic styling before moving to complex themes
2. **Test Thoroughly**: Always test in both light and dark modes
3. **Use Theme.of(context)**: Prefer theme properties over hardcoded values
4. **Think Responsively**: Consider how your styling works on different screen sizes
5. **Document Your Code**: Add comments explaining your design decisions
6. **Iterate**: Don't be afraid to refactor and improve your solutions

Good luck with your Flutter styling and theming journey! 🎨
