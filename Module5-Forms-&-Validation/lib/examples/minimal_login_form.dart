import 'package:flutter/material.dart';
import '../utils/validation_utils.dart';

/// Minimal Login Form Example
/// 
/// This example demonstrates:
/// - Basic Form with GlobalKey<FormState>
/// - TextFormField with validators
/// - AutovalidateMode.onUserInteraction for real-time validation
/// - Form submission with validation
/// - Focus management and keyboard actions
class MinimalLoginForm extends StatefulWidget {
  const MinimalLoginForm({super.key});

  @override
  State<MinimalLoginForm> createState() => _MinimalLoginFormState();
}

class _MinimalLoginFormState extends State<MinimalLoginForm> {
  // GlobalKey to access form state (validate, save, reset)
  final _formKey = GlobalKey<FormState>();
  
  // Controllers for form fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // Focus nodes for keyboard navigation
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  
  // Track form submission state
  bool _isSubmitting = false;

  @override
  void dispose() {
    // Always dispose controllers and focus nodes to prevent memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    // Validate all form fields
    if (!_formKey.currentState!.validate()) {
      return; // Stop if validation fails
    }
    
    setState(() {
      _isSubmitting = true;
    });
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Login successful!'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        
        // Navigate back with result
        Navigator.pop(context, {
          'email': _emailController.text,
          'success': true,
        });
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${e.toString()}'),
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
    _emailController.clear();
    _passwordController.clear();
    _emailFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minimal Login Form'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            // Enable real-time validation after user interaction
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Icon(
                  Icons.lock_outline,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to your account',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                
                // Email Field
                TextFormField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email address',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: ValidationUtils.compose([
                    ValidationUtils.required,
                    ValidationUtils.email,
                  ]),
                  onFieldSubmitted: (_) {
                    // Move focus to password field
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                ),
                const SizedBox(height: 16),
                
                // Password Field
                TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: Icon(Icons.lock_outlined),
                  ),
                  validator: ValidationUtils.compose([
                    ValidationUtils.required,
                    ValidationUtils.minLength(6),
                  ]),
                  onFieldSubmitted: (_) {
                    // Submit form when user presses done
                    _handleSubmit();
                  },
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
                          'Sign In',
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
                
                // Form State Info
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Form State Information',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '• Email: ${_emailController.text.isEmpty ? "Empty" : "Filled"}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '• Password: ${_passwordController.text.isEmpty ? "Empty" : "Filled"}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '• Form Valid: ${_formKey.currentState?.validate() ?? false}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '• Submitting: $_isSubmitting',
                          style: Theme.of(context).textTheme.bodySmall,
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
