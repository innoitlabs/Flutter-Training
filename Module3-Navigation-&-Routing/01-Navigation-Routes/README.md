# Navigation Between Screens in Flutter

## Learning Objectives

- Learn how to navigate using Navigator with routes
- Use named routes for cleaner navigation
- Pass data forward and receive results back
- Apply best practices for navigation in Flutter apps

## Module Structure

This module covers:

1. **Basic Navigator & Routes** - Understanding the stack-based navigation system
2. **Named Routes** - Using MaterialApp.routes and onGenerateRoute
3. **Data Passing** - Sending and receiving data between screens
4. **Best Practices** - Centralized routing and performance optimization
5. **Complete Example App** - A mini app demonstrating all concepts

## Prerequisites

- Flutter SDK (latest stable version)
- Dart 3.6.1 or higher
- Basic understanding of Flutter widgets and Material Design

## Getting Started

1. Clone or download this module
2. Open the project in your preferred IDE
3. Run `flutter pub get` to install dependencies
4. Start with `main.dart` and follow the learning path

## Learning Path

### 1. Basic Navigation (`lib/basic_navigation/`)
- `home_page.dart` - Main screen with navigation buttons
- `details_page.dart` - Secondary screen demonstrating push/pop

### 2. Named Routes (`lib/named_routes/`)
- `app_routes.dart` - Centralized route definitions
- `home_page.dart` - Using named routes for navigation
- `details_page.dart` - Receiving route arguments

### 3. Data Passing (`lib/data_passing/`)
- `home_page.dart` - Sending data to other screens
- `details_page.dart` - Receiving and returning data
- `profile_page.dart` - Complex data passing example

### 4. Complete Example App (`lib/complete_example/`)
- Full-featured app demonstrating all navigation concepts
- Item list with favorites functionality
- Form handling with data return

## Key Concepts

### Navigator Stack
Flutter uses a stack-based navigation system where screens are pushed onto and popped from a stack.

### Imperative vs Declarative Navigation
- **Imperative**: Direct control with `Navigator.push()` and `Navigator.pop()`
- **Declarative**: Route-based navigation using named routes

### Best Practices
- Centralize route definitions
- Use named routes for larger apps
- Keep widget trees shallow
- Use const constructors for performance
- Handle null safety properly

## Exercises

### Easy
Add a button to navigate from Home → Details using basic navigation.

### Intermediate
Pass a username to a Profile screen and display it using named routes.

### Advanced
Build a form screen that returns entered data to the Home screen.

## Running the Examples

Each example can be run independently by changing the main.dart file:

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

## Dependencies

This project uses:
- Flutter SDK (latest stable)
- Material 3 design system
- Dart 3.6.1+ null-safe syntax

## Support

For questions or issues, refer to the Flutter documentation or create an issue in this repository.
