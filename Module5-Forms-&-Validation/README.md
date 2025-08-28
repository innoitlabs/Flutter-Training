# Flutter Forms & Validation (Module 5) — Material 3, Dart 3.6.1

A comprehensive learning module for building complex forms, implementing validation, and creating custom form fields in Flutter.

## Learning Objectives

- Create complex, multi-field forms with proper state management
- Implement input validation (synchronous and asynchronous simulation)
- Handle form submission with loading states and result feedback
- Build custom form fields and reusable validators
- Master Material 3 theming and input decoration

## Key Concepts & Architecture

### Form Fundamentals

**Form & FormField Basics**
- `Form` widget acts as a container that groups form fields together
- `GlobalKey<FormState>` provides access to form state for validation, saving, and resetting
- `FormField<T>` is the base class for all form input widgets
- `FormState` manages the validation state and lifecycle of form fields

**FormState Operations**
- `validate()`: Triggers validation on all form fields, returns true if all valid
- `save()`: Calls `onSaved` callback on all form fields to collect values
- `reset()`: Resets all form fields to their initial state

**Real-time vs On-Submit Validation**
- `AutovalidateMode.disabled`: Only validate when `validate()` is called
- `AutovalidateMode.onUserInteraction`: Validate after user interacts with field
- `AutovalidateMode.always`: Always show validation errors
- `AutovalidateMode.onUserInteraction` is recommended for better UX

### Input Types & Configuration

**TextInputType**: Determines keyboard type and behavior
- `TextInputType.emailAddress`: Email keyboard with @ symbol
- `TextInputType.phone`: Numeric keyboard for phone numbers
- `TextInputType.number`: Numeric keyboard
- `TextInputType.multiline`: Multi-line text input

**TextInputAction**: Controls the action button on keyboard
- `TextInputAction.next`: Moves focus to next field
- `TextInputAction.done`: Submits form or closes keyboard
- `TextInputAction.search`: Triggers search action

**InputFormatters**: Transform or restrict input
- `FilteringTextInputFormatter.digitsOnly`: Only allow digits
- `LengthLimitingTextInputFormatter(maxLength)`: Limit input length
- `TextInputFormatter.withFunction()`: Custom formatting logic

### Focus Management

**FocusNode**: Manages focus state and keyboard navigation
- `requestFocus()`: Programmatically focus a field
- `unfocus()`: Remove focus from a field
- `addListener()`: Listen to focus changes

**FocusScope**: Manages focus traversal
- `FocusScope.of(context).nextFocus()`: Move to next focusable widget
- `FocusScope.of(context).requestFocus(focusNode)`: Focus specific node

## Quick Start: Minimal Login Form

The minimal login form demonstrates basic form setup with validation:

```dart
class MinimalLoginForm extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: ValidationUtils.compose([
              ValidationUtils.required,
              ValidationUtils.email,
            ]),
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            validator: ValidationUtils.compose([
              ValidationUtils.required,
              ValidationUtils.minLength(6),
            ]),
          ),
          FilledButton(
            onPressed: _handleSubmit,
            child: Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
```

**Key Features:**
- Real-time validation with `AutovalidateMode.onUserInteraction`
- Composed validators using `ValidationUtils.compose()`
- Proper focus management with `textInputAction`
- Loading state during submission
- Error handling with SnackBar feedback

## Building Complex Forms

The complex registration form showcases advanced form patterns:

### Multiple Field Types

**TextFormField**: Standard text input with validation
**DropdownButtonFormField**: Selection from predefined options
**CheckboxListTile**: Boolean selection with rich UI
**SwitchListTile**: Toggle switch with label

### Cross-Field Validation

```dart
// Password confirmation validation
TextFormField(
  validator: ValidationUtils.compose([
    ValidationUtils.required,
    ValidationUtils.passwordMatch(_passwordController.text),
  ]),
)
```

### Async Validation Simulation

```dart
// Username availability check
Future<void> _checkUsernameAvailability(String username) async {
  setState(() {
    _isCheckingUsername = true;
  });
  
  await Future.delayed(Duration(milliseconds: 800));
  
  final isAvailable = !takenUsernames.contains(username.toLowerCase());
  setState(() {
    _isCheckingUsername = false;
    _usernameAvailabilityMessage = isAvailable 
        ? 'Username is available' 
        : 'Username is already taken';
  });
}
```

### Form Submission Pattern

```dart
Future<void> _handleSubmit() async {
  // 1. Validate form
  if (!_formKey.currentState!.validate()) {
    return;
  }
  
  // 2. Check business rules
  if (!_acceptTerms) {
    showSnackBar('Please accept terms and conditions');
    return;
  }
  
  // 3. Set loading state
  setState(() {
    _isSubmitting = true;
  });
  
  try {
    // 4. Submit data
    await _submitForm();
    
    // 5. Handle success
    showSuccessDialog();
  } catch (e) {
    // 6. Handle error
    showErrorSnackBar(e.toString());
  } finally {
    // 7. Reset loading state
    setState(() {
      _isSubmitting = false;
    });
  }
}
```

## Reusable Validation Utilities

The `ValidationUtils` class provides pure, composable validation functions:

### Basic Validators

```dart
// Required field
ValidationUtils.required

// Email validation
ValidationUtils.email

// Length constraints
ValidationUtils.minLength(8)
ValidationUtils.maxLength(50)

// Phone number validation
ValidationUtils.phone

// Password strength
ValidationUtils.passwordStrength
```

### Composing Validators

```dart
// Combine multiple validators
validator: ValidationUtils.compose([
  ValidationUtils.required,
  ValidationUtils.email,
  ValidationUtils.maxLength(100),
])
```

### Custom Validators

```dart
// Custom validation with condition
ValidationUtils.custom(
  (value) => value!.contains('@'),
  'Must contain @ symbol'
)

// Cross-field validation
ValidationUtils.passwordMatch(_passwordController.text)
```

## Custom Form Field Implementation

The `PhoneFormField` demonstrates building a custom form field from scratch:

### FormField<T> Structure

```dart
class PhoneFormField extends FormField<String> {
  PhoneFormField({
    String? initialValue,
    String? Function(String?)? validator,
    void Function(String?)? onChanged,
    // ... other parameters
  }) : super(
    initialValue: initialValue,
    validator: validator,
    onChanged: onChanged,
    builder: (FormFieldState<String> field) {
      return _PhoneFormFieldState(field: field);
    },
  );
}
```

### State Management

```dart
class _PhoneFormFieldStateState extends State<_PhoneFormFieldState> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.field.value);
    _focusNode = FocusNode();
    
    // Listen to changes
    _controller.addListener(_handleControllerChanged);
  }
  
  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
```

### Input Formatting

```dart
String _formatPhoneNumber(String input) {
  final digitsOnly = input.replaceAll(RegExp(r'[^\d]'), '');
  
  if (digitsOnly.length <= 3) {
    return digitsOnly;
  } else if (digitsOnly.length <= 6) {
    return '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3)}';
  } else {
    return '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6)}';
  }
}
```

## Input Decoration & Theming

### Global Theme Configuration

```dart
ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.blue, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.red, width: 2),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  ),
)
```

### Per-Field Customization

```dart
TextFormField(
  decoration: InputDecoration(
    labelText: 'Email',
    hintText: 'Enter your email',
    prefixIcon: Icon(Icons.email_outlined),
    suffixIcon: IconButton(
      icon: Icon(Icons.clear),
      onPressed: () => _controller.clear(),
    ),
  ),
)
```

## Form Submission Patterns

### Complete Submission Flow

1. **Validation**: Check all form fields are valid
2. **Business Rules**: Verify additional constraints (terms accepted, etc.)
3. **Loading State**: Show progress indicator and disable inputs
4. **Data Collection**: Use `formKey.currentState!.save()` or controllers
5. **Submission**: Send data to server/API
6. **Success Handling**: Show success message, navigate, or reset form
7. **Error Handling**: Display error message and allow retry
8. **State Reset**: Clear loading state and re-enable inputs

### Preventing Double Submissions

```dart
FilledButton(
  onPressed: _isSubmitting ? null : _handleSubmit,
  child: _isSubmitting
      ? CircularProgressIndicator()
      : Text('Submit'),
)
```

### Returning Data

```dart
// Return form data to previous screen
Navigator.pop(context, {
  'email': _emailController.text,
  'success': true,
});

// Handle returned data
final result = await Navigator.push(context, route);
if (result != null && result['success']) {
  // Handle success
}
```

## Best Practices

### Validation Strategy

✅ **Do:**
- Use `AutovalidateMode.onUserInteraction` for real-time feedback
- Provide clear, specific error messages
- Use appropriate `keyboardType` and `textInputAction`
- Compose validators for reusability
- Validate on both client and server

❌ **Don't:**
- Show validation errors before user interaction
- Use generic error messages
- Ignore accessibility requirements
- Mix business logic with UI code

### State Management

✅ **Do:**
- Keep business logic outside `build()` method
- Use `TextEditingController` for complex input handling
- Dispose controllers and focus nodes properly
- Use `mounted` check before setState in async operations
- Keep widgets small and focused

❌ **Don't:**
- Store form state in global variables
- Forget to dispose resources
- Call setState after widget disposal
- Mix UI and business logic

### Accessibility

✅ **Do:**
- Provide meaningful labels and hints
- Use semantic labels for screen readers
- Ensure adequate tap targets (minimum 48x48 pixels)
- Support keyboard navigation
- Provide error text for screen readers

❌ **Don't:**
- Use generic labels like "Field 1"
- Ignore contrast requirements
- Make tap targets too small
- Skip keyboard navigation testing

### Responsive Design

✅ **Do:**
- Use `SingleChildScrollView` for long forms
- Wrap form in `SafeArea` for proper padding
- Test on different screen sizes
- Use flexible layouts with `Expanded` and `Flexible`
- Consider landscape orientation

❌ **Don't:**
- Assume fixed screen dimensions
- Ignore keyboard overlap
- Use hardcoded dimensions
- Forget about small screens

## Exercises

### Easy: Username Availability Check

Add a username field with live availability checking:

```dart
TextFormField(
  onChanged: (value) {
    // Debounce and check availability
    _checkUsernameAvailability(value);
  },
  validator: (value) {
    if (_isCheckingUsername) {
      return 'Checking availability...';
    }
    if (_usernameAvailabilityMessage?.contains('taken') == true) {
      return 'Username is already taken';
    }
    return null;
  },
)
```

### Intermediate: Date Picker Form Field

Create a custom date picker form field:

```dart
class DatePickerFormField extends FormField<DateTime?> {
  // Implementation with showDatePicker
  // Handle date formatting and validation
  // Support for date range constraints
}
```

### Advanced: Multi-Step Form

Build a multi-step registration form:

```dart
class MultiStepForm extends StatefulWidget {
  // Step 1: Personal Information
  // Step 2: Contact Information  
  // Step 3: Review and Submit
  // Cross-step validation
  // Progress indicator
  // Navigation between steps
}
```

## Summary

### Key Takeaways

1. **FormState Management**: Use `GlobalKey<FormState>` for form operations
2. **Validation Strategy**: Implement real-time validation with clear error messages
3. **Custom Fields**: Build reusable form fields using `FormField<T>` when needed
4. **Input Decoration**: Leverage Material 3 theming for consistent styling
5. **Submission Flow**: Follow the validate → save → submit → handle result pattern
6. **Focus Management**: Implement proper keyboard navigation and focus handling
7. **Responsive Design**: Ensure forms work well on all screen sizes

### Next Steps

- Explore state management solutions (Provider, Riverpod, Bloc) for complex forms
- Implement real HTTP validation with debouncing
- Add form persistence with `RestorationMixin` or `SharedPreferences`
- Internationalize error messages using the `intl` package
- Add unit tests for validation logic and form behavior

### Resources

- [Flutter Form Documentation](https://docs.flutter.dev/cookbook/forms)
- [Material 3 Design Guidelines](https://m3.material.io/)
- [Flutter Validation Best Practices](https://docs.flutter.dev/cookbook/forms/validation)
- [Accessibility Guidelines](https://docs.flutter.dev/development/accessibility-and-localization/accessibility)

---

**Note**: This module is compatible with Dart 3.6.1+ and Flutter 3.24.0+. All examples use Material 3 design and null safety. For production applications, consider implementing proper error handling, logging, and analytics.
