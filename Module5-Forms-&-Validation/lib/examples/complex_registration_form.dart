import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/validation_utils.dart';

/// Complex Registration Form Example
/// 
/// This example demonstrates:
/// - Multiple form field types (text, dropdown, checkbox, switch)
/// - Cross-field validation (password confirmation)
/// - Async validation simulation
/// - Form submission with loading state
/// - Input formatting and focus management
class ComplexRegistrationForm extends StatefulWidget {
  const ComplexRegistrationForm({super.key});

  @override
  State<ComplexRegistrationForm> createState() => _ComplexRegistrationFormState();
}

class _ComplexRegistrationFormState extends State<ComplexRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers for text fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  
  // Focus nodes
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  
  // Form state
  String _selectedRole = 'User';
  bool _acceptTerms = false;
  bool _newsletterSubscription = false;
  bool _isSubmitting = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  
  // Async validation state
  bool _isCheckingUsername = false;
  String? _usernameAvailabilityMessage;

  // Available roles
  static const List<String> _roles = ['User', 'Admin', 'Moderator', 'Guest'];

  @override
  void dispose() {
    // Dispose all controllers and focus nodes
    _nameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _phoneFocusNode.dispose();
    
    super.dispose();
  }

  /// Simulate async username availability check
  Future<void> _checkUsernameAvailability(String username) async {
    if (username.isEmpty) {
      setState(() {
        _isCheckingUsername = false;
        _usernameAvailabilityMessage = null;
      });
      return;
    }

    setState(() {
      _isCheckingUsername = true;
      _usernameAvailabilityMessage = null;
    });

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 800));
    
    if (mounted) {
      // Simulate some usernames as taken
      final takenUsernames = ['admin', 'user', 'test', 'demo'];
      final isAvailable = !takenUsernames.contains(username.toLowerCase());
      
      setState(() {
        _isCheckingUsername = false;
        _usernameAvailabilityMessage = isAvailable 
            ? 'Username is available' 
            : 'Username is already taken';
      });
    }
  }

  /// Handle form submission
  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the terms and conditions'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 3));
      
      if (mounted) {
        // Show success dialog
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Registration Successful!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${_nameController.text}'),
                Text('Email: ${_emailController.text}'),
                Text('Username: ${_usernameController.text}'),
                Text('Role: $_selectedRole'),
                Text('Phone: ${_phoneController.text}'),
                if (_newsletterSubscription)
                  const Text('Newsletter: Subscribed'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
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
    _usernameController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _phoneController.clear();
    
    setState(() {
      _selectedRole = 'User';
      _acceptTerms = false;
      _newsletterSubscription = false;
      _showPassword = false;
      _showConfirmPassword = false;
      _usernameAvailabilityMessage = null;
    });
    
    _nameFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complex Registration Form'),
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
                  Icons.person_add_outlined,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Personal Information Section
                _buildSectionHeader('Personal Information'),
                
                // Name Field
                TextFormField(
                  controller: _nameController,
                  focusNode: _nameFocusNode,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'Enter your full name',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: ValidationUtils.compose([
                    ValidationUtils.required,
                    ValidationUtils.minLength(2),
                    ValidationUtils.maxLength(50),
                  ]),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_emailFocusNode);
                  },
                ),
                const SizedBox(height: 16),

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
                    FocusScope.of(context).requestFocus(_usernameFocusNode);
                  },
                ),
                const SizedBox(height: 16),

                // Username Field with async validation
                TextFormField(
                  controller: _usernameController,
                  focusNode: _usernameFocusNode,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Choose a username',
                    prefixIcon: const Icon(Icons.alternate_email_outlined),
                    suffixIcon: _isCheckingUsername
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : null,
                  ),
                  validator: ValidationUtils.compose([
                    ValidationUtils.required,
                    ValidationUtils.username,
                  ]),
                  onChanged: (value) {
                    // Debounce username availability check
                    Future.delayed(const Duration(milliseconds: 500), () {
                      if (value == _usernameController.text) {
                        _checkUsernameAvailability(value);
                      }
                    });
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                ),
                if (_usernameAvailabilityMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 16),
                    child: Text(
                      _usernameAvailabilityMessage!,
                      style: TextStyle(
                        color: _usernameAvailabilityMessage!.contains('available')
                            ? Colors.green
                            : Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  obscureText: !_showPassword,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Create a strong password',
                    prefixIcon: const Icon(Icons.lock_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                  validator: ValidationUtils.compose([
                    ValidationUtils.required,
                    ValidationUtils.minLength(8),
                    ValidationUtils.passwordStrength,
                  ]),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
                  },
                ),
                const SizedBox(height: 16),

                // Confirm Password Field
                TextFormField(
                  controller: _confirmPasswordController,
                  focusNode: _confirmPasswordFocusNode,
                  obscureText: !_showConfirmPassword,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Confirm your password',
                    prefixIcon: const Icon(Icons.lock_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showConfirmPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _showConfirmPassword = !_showConfirmPassword;
                        });
                      },
                    ),
                  ),
                  validator: ValidationUtils.compose([
                    ValidationUtils.required,
                    ValidationUtils.passwordMatch(_passwordController.text),
                  ]),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_phoneFocusNode);
                  },
                ),
                const SizedBox(height: 24),

                // Contact Information Section
                _buildSectionHeader('Contact Information'),
                
                // Phone Field
                TextFormField(
                  controller: _phoneController,
                  focusNode: _phoneFocusNode,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(15),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    hintText: 'Enter your phone number',
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                  validator: ValidationUtils.compose([
                    ValidationUtils.required,
                    ValidationUtils.phone,
                  ]),
                ),
                const SizedBox(height: 16),

                // Role Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedRole,
                  decoration: const InputDecoration(
                    labelText: 'Role',
                    prefixIcon: Icon(Icons.work_outline),
                  ),
                  items: _roles.map((role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedRole = value!;
                    });
                  },
                ),
                const SizedBox(height: 24),

                // Preferences Section
                _buildSectionHeader('Preferences'),
                
                // Terms and Conditions
                CheckboxListTile(
                  title: const Text('I accept the terms and conditions'),
                  subtitle: const Text('You must accept to continue'),
                  value: _acceptTerms,
                  onChanged: (value) {
                    setState(() {
                      _acceptTerms = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                
                // Newsletter Subscription
                SwitchListTile(
                  title: const Text('Subscribe to newsletter'),
                  subtitle: const Text('Receive updates and news'),
                  value: _newsletterSubscription,
                  onChanged: (value) {
                    setState(() {
                      _newsletterSubscription = value;
                    });
                  },
                ),
                const SizedBox(height: 32),

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
                          'Create Account',
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
