# Flutter State Management Exercises

Practice exercises to reinforce your understanding of Flutter state management with `setState`.

## Exercise 1: Simple Toggle Button (Easy)

**Objective**: Create a button that toggles between "ON" and "OFF" states.

**Requirements**:
- Use a StatefulWidget
- Implement setState to change the button text
- Change button color based on state (green for ON, red for OFF)

**Starter Code**:
```dart
class ToggleButton extends StatefulWidget {
  const ToggleButton({super.key});

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  // TODO: Add state variable for toggle
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // TODO: Implement toggle logic with setState
      },
      style: ElevatedButton.styleFrom(
        // TODO: Change color based on state
      ),
      child: Text(
        // TODO: Change text based on state
      ),
    );
  }
}
```

**Solution**:
```dart
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
      style: ElevatedButton.styleFrom(
        backgroundColor: _isOn ? Colors.green : Colors.red,
      ),
      child: Text(_isOn ? 'ON' : 'OFF'),
    );
  }
}
```

---

## Exercise 2: Counter with Reset (Easy)

**Objective**: Create a counter app with increment, decrement, and reset functionality.

**Requirements**:
- Display current count
- Increment button (+)
- Decrement button (-)
- Reset button (sets count to 0)
- Show different colors for positive, negative, and zero values

**Starter Code**:
```dart
class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  // TODO: Add counter state variable
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TODO: Display counter with appropriate color
        // TODO: Add increment, decrement, and reset buttons
      ],
    );
  }
}
```

---

## Exercise 3: Form with Clear Button (Intermediate)

**Objective**: Create a simple form with name and email fields, plus a clear button.

**Requirements**:
- Name field (required, minimum 2 characters)
- Email field (required, valid email format)
- Submit button (shows success message)
- Clear button (resets all fields)
- Real-time validation feedback

**Starter Code**:
```dart
class SimpleForm extends StatefulWidget {
  const SimpleForm({super.key});

  @override
  State<SimpleForm> createState() => _SimpleFormState();
}

class _SimpleFormState extends State<SimpleForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  
  @override
  void dispose() {
    // TODO: Dispose controllers
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // TODO: Add name field with validation
          // TODO: Add email field with validation
          // TODO: Add submit and clear buttons
        ],
      ),
    );
  }
}
```

---

## Exercise 4: Todo List (Intermediate)

**Objective**: Create a simple todo list where you can add and remove items.

**Requirements**:
- Text field to enter new todo
- Add button to add todo to list
- Display list of todos
- Remove button for each todo
- Show count of total todos

**Starter Code**:
```dart
class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final _todoController = TextEditingController();
  // TODO: Add list to store todos
  
  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TODO: Add input field and add button
        // TODO: Display todo count
        // TODO: Display list of todos with remove buttons
      ],
    );
  }
}
```

---

## Exercise 5: Enhanced Profile Form (Advanced)

**Objective**: Expand the profile form with additional features.

**Requirements**:
- All fields from the basic profile form
- Age dropdown (18-25, 26-35, 36-45, 46+)
- Experience level radio buttons (Beginner, Intermediate, Advanced)
- Multiple checkbox selections for interests (Flutter, Dart, Mobile Development, Web Development)
- Real-time character count for bio field
- Form validation for all fields
- Success message with all collected data

**Starter Code**:
```dart
class EnhancedProfileForm extends StatefulWidget {
  const EnhancedProfileForm({super.key});

  @override
  State<EnhancedProfileForm> createState() => _EnhancedProfileFormState();
}

class _EnhancedProfileFormState extends State<EnhancedProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();
  
  // TODO: Add state variables for new fields
  
  @override
  void dispose() {
    // TODO: Dispose all controllers
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          // TODO: Add all form fields with validation
          // TODO: Add submit button
          // TODO: Display success message with all data
        ],
      ),
    );
  }
}
```

---

## Exercise 6: Color Theme Switcher (Advanced)

**Objective**: Create an app that can switch between different color themes.

**Requirements**:
- Multiple predefined color themes (Light, Dark, Blue, Green, Purple)
- Theme affects the entire app
- Current theme selection indicator
- Smooth transitions between themes
- Save theme preference

**Starter Code**:
```dart
class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  // TODO: Add theme state variables
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Switcher'),
        // TODO: Apply current theme
      ),
      body: Column(
        children: [
          // TODO: Display current theme
          // TODO: Add theme selection buttons
          // TODO: Add sample content to see theme changes
        ],
      ),
    );
  }
}
```

---

## Exercise 7: Quiz App (Advanced)

**Objective**: Create a simple quiz app with multiple choice questions.

**Requirements**:
- Multiple questions with 4 options each
- Track current question and score
- Show progress indicator
- Display final score at the end
- Restart quiz functionality
- Animated transitions between questions

**Starter Code**:
```dart
class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  // TODO: Add quiz state variables
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: Column(
        children: [
          // TODO: Display progress and score
          // TODO: Display current question
          // TODO: Display answer options
          // TODO: Handle answer selection
          // TODO: Show final results
        ],
      ),
    );
  }
}
```

---

## Exercise 8: Shopping Cart (Advanced)

**Objective**: Create a simple shopping cart with products and quantity management.

**Requirements**:
- List of products with prices
- Add/remove items from cart
- Update quantities
- Calculate total price
- Show cart summary
- Clear cart functionality

**Starter Code**:
```dart
class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  // TODO: Add product and cart state variables
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Column(
        children: [
          // TODO: Display available products
          // TODO: Display cart items
          // TODO: Show total price
          // TODO: Add checkout button
        ],
      ),
    );
  }
}
```

---

## Tips for Completing Exercises

1. **Start Simple**: Begin with the basic functionality and add features incrementally
2. **Test Often**: Run your code frequently to catch errors early
3. **Use setState Properly**: Remember to wrap state changes in setState()
4. **Handle Edge Cases**: Consider empty inputs, invalid data, etc.
5. **Follow Best Practices**: Keep widgets small, dispose controllers, provide feedback
6. **Add Comments**: Document your code to explain your logic

## Submission Guidelines

For each exercise:
1. Create a new file for your solution
2. Include proper comments explaining your approach
3. Test all functionality thoroughly
4. Ensure the code follows Flutter best practices
5. Add error handling where appropriate

## Additional Challenges

Once you've completed the basic exercises, try these advanced challenges:

1. **Persistence**: Save form data or preferences using SharedPreferences
2. **Animations**: Add smooth animations for state changes
3. **Accessibility**: Implement proper accessibility features
4. **Testing**: Write unit tests for your state management logic
5. **Performance**: Optimize your code for better performance

Remember, the key to mastering Flutter state management is practice. Start with the easy exercises and gradually work your way up to the more complex ones!
