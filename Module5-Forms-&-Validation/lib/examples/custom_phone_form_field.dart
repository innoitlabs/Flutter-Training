import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/validation_utils.dart';

/// Custom Phone Form Field Example
/// 
/// This example demonstrates:
/// - Building a custom FormField from scratch using FormField<T> and FormFieldState<T>
/// - Input formatting and masking
/// - Custom validation logic
/// - Proper state management and lifecycle
class CustomPhoneFormFieldExample extends StatefulWidget {
  const CustomPhoneFormFieldExample({super.key});

  @override
  State<CustomPhoneFormFieldExample> createState() => _CustomPhoneFormFieldExampleState();
}

class _CustomPhoneFormFieldExampleState extends State<CustomPhoneFormFieldExample> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  
  // Form state
  String? _phoneNumber;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Form submitted successfully!\nPhone: $_phoneNumber'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Submission failed: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _nameController.clear();
    _emailController.clear();
    setState(() {
      _phoneNumber = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Phone Form Field'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Icon(
                  Icons.phone_android,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Custom Phone Field',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Built from scratch using FormField<T>',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your name',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: ValidationUtils.required,
                ),
                const SizedBox(height: 16),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: ValidationUtils.compose([
                    ValidationUtils.required,
                    ValidationUtils.email,
                  ]),
                ),
                const SizedBox(height: 16),

                // Custom Phone Field
                PhoneFormField(
                  initialValue: _phoneNumber,
                  onChanged: (value) {
                    setState(() {
                      _phoneNumber = value;
                    });
                  },
                  validator: ValidationUtils.compose([
                    ValidationUtils.required,
                    ValidationUtils.phone,
                  ]),
                ),
                const SizedBox(height: 24),

                // Submit Button
                FilledButton(
                  onPressed: _isSubmitting ? null : _handleSubmit,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                const SizedBox(height: 16),

                // Reset Button
                OutlinedButton(
                  onPressed: _isSubmitting ? null : _resetForm,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Reset Form'),
                ),
                
                const SizedBox(height: 32),
                
                // Documentation Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Custom FormField Benefits',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '• Complete control over appearance and behavior\n'
                          '• Custom validation logic\n'
                          '• Input formatting and masking\n'
                          '• Reusable across the app\n'
                          '• Proper form integration',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom Phone Form Field Implementation
/// 
/// This demonstrates how to build a custom FormField from scratch.
/// It provides phone number formatting and validation.
class PhoneFormField extends FormField<String> {
  PhoneFormField({
    super.key,
    String? initialValue,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    bool enabled = true,
    AutovalidateMode? autovalidateMode,
    void Function(String?)? onChanged,
    InputDecoration? decoration,
  }) : super(
          initialValue: initialValue,
          validator: validator,
          onSaved: onSaved,
          enabled: enabled,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
          builder: (FormFieldState<String> field) {
            return _PhoneFormFieldState(
              field: field,
              onChanged: onChanged,
              decoration: decoration,
            );
          },
        );
}

/// State class for the custom phone form field
class _PhoneFormFieldState extends StatefulWidget {
  final FormFieldState<String> field;
  final void Function(String?)? onChanged;
  final InputDecoration? decoration;

  const _PhoneFormFieldState({
    required this.field,
    this.onChanged,
    this.decoration,
  });

  @override
  State<_PhoneFormFieldState> createState() => __PhoneFormFieldStateState();
}

class __PhoneFormFieldStateState extends State<_PhoneFormFieldState> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _hasInteractedByUser = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.field.value);
    _focusNode = FocusNode();
    
    // Listen to controller changes
    _controller.addListener(_handleControllerChanged);
    
    // Listen to focus changes for validation timing
    _focusNode.addListener(_handleFocusChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleControllerChanged() {
    final text = _controller.text;
    final formattedText = _formatPhoneNumber(text);
    
    // Update controller if formatting changed the text
    if (formattedText != text) {
      _controller.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
    
    // Update form field value
    widget.field.didChange(formattedText);
    
    // Call onChanged callback
    widget.onChanged?.call(formattedText);
  }

  void _handleFocusChanged() {
    if (!_focusNode.hasFocus && _hasInteractedByUser) {
      widget.field.validate();
    }
  }

  /// Format phone number as user types
  String _formatPhoneNumber(String input) {
    // Remove all non-digit characters
    final digitsOnly = input.replaceAll(RegExp(r'[^\d]'), '');
    
    // Apply formatting based on length
    if (digitsOnly.isEmpty) {
      return '';
    } else if (digitsOnly.length <= 3) {
      return digitsOnly;
    } else if (digitsOnly.length <= 6) {
      return '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3)}';
    } else {
      return '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6, digitsOnly.length.clamp(0, 10))}';
    }
  }

  /// Extract digits only from formatted phone number
  String _extractDigits(String formatted) {
    return formatted.replaceAll(RegExp(r'[^\d]'), '');
  }

  @override
  Widget build(BuildContext context) {
    final decoration = widget.decoration ?? const InputDecoration();
    final hasError = widget.field.hasError;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          enabled: widget.field.widget.enabled,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          inputFormatters: [
            // Allow only digits and formatting characters
            FilteringTextInputFormatter.allow(RegExp(r'[\d\(\)\-\s]')),
            // Limit total length
            LengthLimitingTextInputFormatter(14),
          ],
          decoration: decoration.copyWith(
            labelText: decoration.labelText ?? 'Phone Number',
            hintText: decoration.hintText ?? '(555) 123-4567',
            prefixIcon: decoration.prefixIcon ?? const Icon(Icons.phone_outlined),
            errorText: hasError ? widget.field.errorText : null,
            // Custom styling for error state
            errorStyle: hasError 
                ? TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  )
                : null,
          ),
          onTap: () {
            _hasInteractedByUser = true;
          },
          onChanged: (value) {
            _hasInteractedByUser = true;
          },
          onFieldSubmitted: (_) {
            widget.field.validate();
          },
        ),
        
        // Additional info about the field
        if (widget.field.value != null && widget.field.value!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 16),
            child: Text(
              'Digits: ${_extractDigits(widget.field.value!)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
      ],
    );
  }
}
