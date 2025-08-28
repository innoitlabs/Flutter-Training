# Quick Start Guide

## Getting Started

### 1. Prerequisites
- Flutter SDK (latest stable version)
- Dart 3.6.1 or higher
- An IDE (VS Code, Android Studio, etc.)

### 2. Setup
1. Clone or download this module
2. Open the project in your IDE
3. Run `flutter pub get` to install dependencies
4. Ensure you have a device/emulator running

### 3. Running the Examples

#### Option 1: Run All Examples
```bash
flutter run
```
This will start the main app with a module selector.

#### Option 2: Run Individual Examples
To run a specific example, modify `lib/main.dart`:

```dart
// For basic navigation
import 'basic_navigation/main.dart';

// For named routes
import 'named_routes/main.dart';

// For data passing
import 'data_passing/main.dart';

// For complete example
import 'complete_example/main.dart';
```

### 4. Learning Path

#### Step 1: Basic Navigation
1. Run the basic navigation example
2. Understand `Navigator.push()` and `Navigator.pop()`
3. See how the navigation stack works
4. Try the different navigation buttons

#### Step 2: Named Routes
1. Run the named routes example
2. Understand route definitions in `MaterialApp`
3. See how `onGenerateRoute` works
4. Try navigating with arguments

#### Step 3: Data Passing
1. Run the data passing example
2. Understand constructor parameters vs route arguments
3. See how data is returned via `Navigator.pop()`
4. Try the form examples

#### Step 4: Complete Example
1. Run the complete example app
2. See all concepts working together
3. Understand the Item model and data flow
4. Try adding, editing, and navigating between items

### 5. Key Files to Explore

#### Basic Navigation
- `lib/basic_navigation/main.dart` - App entry point
- `lib/basic_navigation/home_page.dart` - Home screen with navigation buttons
- `lib/basic_navigation/details_page.dart` - Details screen demonstrating pop

#### Named Routes
- `lib/named_routes/main.dart` - App with route definitions
- `lib/named_routes/app_routes.dart` - Centralized route management
- `lib/named_routes/home_page.dart` - Using named routes
- `lib/named_routes/details_page.dart` - Receiving route arguments

#### Data Passing
- `lib/data_passing/main.dart` - App entry point
- `lib/data_passing/home_page.dart` - Sending and receiving data
- `lib/data_passing/details_page.dart` - Form with data return
- `lib/data_passing/profile_page.dart` - Complex data structures

#### Complete Example
- `lib/complete_example/main.dart` - Full app with all concepts
- `lib/complete_example/app_routes.dart` - Advanced route management
- `lib/complete_example/models/item.dart` - Custom data model
- `lib/complete_example/home_page.dart` - List with navigation
- `lib/complete_example/item_details_page.dart` - Item editing
- `lib/complete_example/add_item_page.dart` - Form creation
- `lib/complete_example/settings_page.dart` - Settings management

### 6. Common Commands

```bash
# Get dependencies
flutter pub get

# Run the app
flutter run

# Run on specific device
flutter run -d <device-id>

# Hot reload (while app is running)
r

# Hot restart (while app is running)
R

# Stop the app
q

# Check for issues
flutter analyze

# Format code
flutter format .

# Run tests
flutter test
```

### 7. Troubleshooting

#### Common Issues

**"Target of URI doesn't exist"**
- Run `flutter pub get`
- Check import paths

**"No supported devices connected"**
- Start an emulator or connect a device
- Run `flutter devices` to see available devices

**"Hot reload not working"**
- Save all files
- Try hot restart (R) instead
- Check for syntax errors

**"App crashes on navigation"**
- Check for null safety issues
- Verify route definitions
- Check console for error messages

### 8. Next Steps

1. **Complete the Exercises**: Work through `EXERCISES.md`
2. **Read the Summary**: Review `SUMMARY.md` for best practices
3. **Experiment**: Modify the examples to try different approaches
4. **Build Your Own**: Create a simple app using these concepts

### 9. Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Material Design](https://material.io/design)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)

### 10. Support

If you encounter issues:
1. Check the Flutter documentation
2. Search Stack Overflow
3. Check the Flutter GitHub issues
4. Ask in Flutter community forums

---

**Happy Learning! 🚀**

This module provides a comprehensive foundation for Flutter navigation. Take your time to understand each concept before moving to the next one. Practice with the exercises and experiment with the code to reinforce your learning.
