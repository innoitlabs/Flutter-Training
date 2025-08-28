# Flutter State Management Basics with setState

A comprehensive learning module for Flutter state management using `setState`. This project provides hands-on examples and exercises to master basic state management concepts in Flutter.

## Learning Objectives

- ✅ Understand the difference between Stateful and Stateless widgets
- ✅ Learn how the state lifecycle works (initState, build, dispose)
- ✅ Implement setState to update UI in simple apps
- ✅ Handle user interactions (e.g., button taps, text fields)
- ✅ Manage form state with validation basics

## Key Concepts Covered

### 1. State vs Stateless Widgets

**StatelessWidget**: Cannot change its state after creation. Used for static content that doesn't need to update.

```dart
class StatelessExample extends StatelessWidget {
  const StatelessExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('I cannot change!');
  }
}
```

**StatefulWidget**: Can change its state and rebuild the UI. Used for dynamic content that needs to update.

```dart
class StatefulExample extends StatefulWidget {
  const StatefulExample({super.key});

  @override
  State<StatefulExample> createState() => _StatefulExampleState();
}

class _StatefulExampleState extends State<StatefulExample> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Text('Counter: $_counter');
  }
}
```

### 2. StatefulWidget Lifecycle

The lifecycle of a StatefulWidget follows this order:

1. **createState()**: Creates the State object
2. **initState()**: Called once when the widget is first created
3. **build()**: Called every time the widget needs to be rebuilt
4. **dispose()**: Called when the widget is removed from the widget tree

```dart
class LifecycleDemo extends StatefulWidget {
  @override
  State<LifecycleDemo> createState() => _LifecycleDemoState();
}

class _LifecycleDemoState extends State<LifecycleDemo> {
  @override
  void initState() {
    super.initState();
    print('Widget initialized');
  }

  @override
  void dispose() {
    print('Widget disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Widget built');
    return Container();
  }
}
```

### 3. Using setState

`setState()` tells Flutter to rebuild the widget with new state values. It's the most basic form of state management.

```dart
void _incrementCounter() {
  setState(() {
    // Modify state variables here
    _counter++;
  });
  // Widget will rebuild automatically
}
```

### 4. Handling User Interactions

Examples of different user interactions:

- **Buttons**: `ElevatedButton`, `TextButton`, `IconButton`
- **Switches**: `Switch`, `SwitchListTile`
- **Checkboxes**: `Checkbox`, `CheckboxListTile`
- **Radio Buttons**: `Radio`, `RadioListTile`
- **Sliders**: `Slider`
- **Text Fields**: `TextField`, `TextFormField`

### 5. Form State & Validation

Use `Form`, `TextFormField`, and `GlobalKey<FormState>` for form validation:

```dart
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'This field is required';
      }
      return null;
    },
  ),
)

// Validate form
if (_formKey.currentState!.validate()) {
  // Form is valid
}
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── screens/
│   ├── home_screen.dart      # Navigation hub
│   ├── widget_comparison_screen.dart  # Stateless vs Stateful demo
│   ├── counter_screen.dart   # Basic setState example
│   ├── toggle_screen.dart    # User interactions demo
│   ├── form_validation_screen.dart    # Form validation basics
│   └── profile_form_screen.dart       # Complete project
```

## Running the Examples

1. **Widget Comparison**: See the difference between Stateless and Stateful widgets
2. **Counter App**: Basic setState implementation with increment/decrement
3. **Toggle Visibility**: Various user interactions (switches, checkboxes, etc.)
4. **Form Validation**: Basic form handling with validation
5. **Profile Form**: Complete interactive form project

## Best Practices

### ✅ Do's
- Keep widgets small and reusable
- Use setState only for local, simple state
- Clean up controllers in dispose() method
- Provide real-time validation feedback
- Use appropriate input types and validation
- Implement loading states for better UX

### ❌ Don'ts
- Avoid putting heavy logic in build() method
- Don't use setState for complex state management
- Don't forget to dispose of controllers
- Don't validate forms without user interaction
- Don't ignore accessibility considerations

## Exercises

### Easy Exercise: Toggle Button
Create a button that toggles between "ON" and "OFF" states.

```dart
class ToggleButton extends StatefulWidget {
  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool _isOn = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _isOn = !_isOn;
        });
      },
      child: Text(_isOn ? 'ON' : 'OFF'),
    );
  }
}
```

### Intermediate Exercise: Form with Clear Button
Add a "Clear" button to reset a form.

```dart
void _clearForm() {
  setState(() {
    _nameController.clear();
    _emailController.clear();
    _isFormSubmitted = false;
  });
}
```

### Advanced Exercise: Enhanced Profile Form
Expand the profile form with:
- Dropdown for age groups
- Radio buttons for experience level
- Multiple checkbox selections for interests
- Real-time character count for bio field

## When to Move Beyond setState

Consider advanced state management solutions when:
- State needs to be shared across multiple widgets
- Complex state logic is required
- Performance becomes an issue
- Testing state becomes difficult

Popular alternatives:
- **Provider**: Simple state management
- **Riverpod**: Modern provider alternative
- **Bloc**: Business Logic Component pattern
- **GetX**: All-in-one solution

## Summary

Key takeaways from this module:

1. **StatelessWidget vs StatefulWidget**: Choose based on whether the widget needs to change
2. **setState**: Use for simple, local state management
3. **Lifecycle**: Understand initState, build, and dispose methods
4. **User Interactions**: Handle various input types with setState
5. **Form Validation**: Use Form, TextFormField, and GlobalKey for validation
6. **Best Practices**: Keep widgets small, clean up resources, provide feedback

## Getting Started

1. Ensure you have Flutter SDK installed (>=3.16.0)
2. Clone this repository
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the app
5. Navigate through the examples to learn each concept

## Requirements

- Dart SDK: >=3.6.1 <4.0.0
- Flutter SDK: >=3.16.0
- Material 3 design system
- Null safety enabled

## Contributing

Feel free to submit issues, feature requests, or pull requests to improve this learning module.

## License

This project is open source and available under the MIT License.
