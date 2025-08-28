import 'package:flutter/material.dart';

class ProfileFormScreen extends StatefulWidget {
  const ProfileFormScreen({super.key});

  @override
  State<ProfileFormScreen> createState() => _ProfileFormScreenState();
}

class _ProfileFormScreenState extends State<ProfileFormScreen> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();
  
  // Text editing controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();
  
  // State variables
  String _selectedGender = 'Prefer not to say';
  String _selectedCountry = 'United States';
  bool _newsletterSubscription = false;
  bool _isFormSubmitted = false;
  bool _isLoading = false;

  // Available options
  final List<String> _genderOptions = [
    'Male',
    'Female',
    'Non-binary',
    'Prefer not to say',
  ];

  final List<String> _countryOptions = [
    'United States',
    'Canada',
    'United Kingdom',
    'Australia',
    'Germany',
    'France',
    'Japan',
    'India',
    'Brazil',
    'Other',
  ];

  @override
  void dispose() {
    // Clean up controllers
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Profile Form'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mini Project: Interactive Profile Form',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This project demonstrates all the concepts learned:\n'
              '• Form validation with setState\n'
              '• User interactions (dropdowns, switches)\n'
              '• State management for complex forms\n'
              '• Real-time validation feedback',
            ),
            const SizedBox(height: 24),
            
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // Personal Information Section
                    _buildSectionHeader('Personal Information', Icons.person),
                    
                    // Name Field
                    _buildFormField(
                      controller: _nameController,
                      label: 'Full Name',
                      hint: 'Enter your full name',
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        }
                        if (value.length < 2) {
                          return 'Name must be at least 2 characters';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Email Field
                    _buildFormField(
                      controller: _emailController,
                      label: 'Email Address',
                      hint: 'Enter your email address',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Phone Field
                    _buildFormField(
                      controller: _phoneController,
                      label: 'Phone Number',
                      hint: 'Enter your phone number',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]+$');
                          if (!phoneRegex.hasMatch(value)) {
                            return 'Please enter a valid phone number';
                          }
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Additional Information Section
                    _buildSectionHeader('Additional Information', Icons.info_outline),
                    
                    // Gender Dropdown
                    _buildDropdownField(
                      label: 'Gender',
                      icon: Icons.person_outline,
                      value: _selectedGender,
                      items: _genderOptions,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Country Dropdown
                    _buildDropdownField(
                      label: 'Country',
                      icon: Icons.location_on_outlined,
                      value: _selectedCountry,
                      items: _countryOptions,
                      onChanged: (value) {
                        setState(() {
                          _selectedCountry = value!;
                        });
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Bio Field
                    _buildFormField(
                      controller: _bioController,
                      label: 'Bio',
                      hint: 'Tell us about yourself (optional)',
                      icon: Icons.description_outlined,
                      maxLines: 3,
                      validator: (value) {
                        if (value != null && value.length > 200) {
                          return 'Bio must be less than 200 characters';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Newsletter Subscription
                    SwitchListTile(
                      title: const Text('Subscribe to Newsletter'),
                      subtitle: const Text('Receive updates about new features'),
                      value: _newsletterSubscription,
                      onChanged: (value) {
                        setState(() {
                          _newsletterSubscription = value;
                        });
                      },
                      secondary: const Icon(Icons.email_outlined),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submitForm,
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text(
                                'Submit Profile',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Form Results
                    if (_isFormSubmitted)
                      _buildResultsCard(),
                    
                    const SizedBox(height: 24),
                    
                    // Best Practices Section
                    _buildBestPracticesCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      validator: validator,
      onChanged: (value) {
        if (_isFormSubmitted) {
          setState(() {
            _isFormSubmitted = false;
          });
        }
      },
    );
  }

  Widget _buildDropdownField({
    required String label,
    required IconData icon,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildResultsCard() {
    return Card(
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  'Profile Submitted Successfully!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildResultRow('Name', _nameController.text),
            _buildResultRow('Email', _emailController.text),
            if (_phoneController.text.isNotEmpty)
              _buildResultRow('Phone', _phoneController.text),
            _buildResultRow('Gender', _selectedGender),
            _buildResultRow('Country', _selectedCountry),
            if (_bioController.text.isNotEmpty)
              _buildResultRow('Bio', _bioController.text),
            _buildResultRow('Newsletter', _newsletterSubscription ? 'Subscribed' : 'Not subscribed'),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildBestPracticesCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Best Practices Demonstrated:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '✅ Keep widgets small and reusable\n'
              '✅ Use setState only for local, simple state\n'
              '✅ Avoid heavy logic in build() method\n'
              '✅ Clean up controllers in dispose()\n'
              '✅ Provide real-time validation feedback\n'
              '✅ Use appropriate input types and validation\n'
              '✅ Implement loading states for better UX',
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    // Validate the form
    if (_formKey.currentState!.validate()) {
      // Show loading state
      setState(() {
        _isLoading = true;
      });
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Check if widget is still mounted before updating state
      if (!mounted) return;
      
      // Update state
      setState(() {
        _isFormSubmitted = true;
        _isLoading = false;
      });
      
      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Profile submitted successfully!'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fix the errors in the form'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
