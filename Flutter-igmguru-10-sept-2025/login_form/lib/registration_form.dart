import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_form/validation_utils.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();

  String _selectedRole = 'User';
  bool _acceptTerms = false;
  bool _newsletterSubscription = false;
  bool _isSubmitting = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  bool _isCheckingUsername = false;
  String? _usernameAvailabilityMessage;

  static const List<String> _roles = <String>[
    'User',
    'Admin',
    'Moderator',
    'Guest'
  ];

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

    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      final takenUsernames = [
        'admin',
        'moderator',
        'guest',
        'user',
        'test',
        'demo'
      ];
      final isAvailable = !takenUsernames.contains(username.toLowerCase());
      setState(() {
        _isCheckingUsername = false;
        _usernameAvailabilityMessage =
            isAvailable ? 'Username is Available' : 'Username is already Taken';
      });
    }
  }

  Future<void> _handleSubmit() async {
    if(!_formKey.currentState!.validate()){
      return;
    }

    if(!_acceptTerms){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the terms and conditions'),
          backgroundColor: Colors.orange,
        )
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try{
      //Simulate API call
      await Future.delayed(const Duration(seconds: 3));

      if(mounted){
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Registration Successful'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Name: ${_nameController.text}'),
                  Text('Email: ${_emailController.text}'),
                  Text('Username: ${_usernameController.text}'),
                  Text('Role: ${_selectedRole}'),
                  Text('Phone: ${_phoneController.text}'),
                  if(_newsletterSubscription)
                    const Text('Newsletter: Subscribed'),
                ],
              ),
              actions: [
                TextButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: const Text('OK')),
              ],
            )
        );
      }
    }
    catch(e){
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration failed: ${e.toString()}"),
          backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
    finally{
      if(mounted){
        setState(() {
          _isSubmitting = false;
        });
      }
    }



  }

  Future<void> _resetForm() async {
    _formKey.currentState!.reset();
    _nameController.clear();
    _emailController.clear();
    _usernameController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _phoneController.clear();

    setState(() {
      _selectedRole = _roles.first;
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
        title: const Text('Registration Form'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Header
                Icon(
                  Icons.person_add_outlined,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Create an account',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                _buildSectionHeader("Personal Information"),

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
                    ValidationUtils.minLength(3),
                    ValidationUtils.maxLength(50),
                  ]),
                  onFieldSubmitted: (_) {
                    _nameFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(_usernameFocusNode);
                  },
                ),

                const SizedBox(
                  height: 16,
                ),

                TextFormField(
                  controller: _usernameController,
                  focusNode: _usernameFocusNode,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter a username',
                    prefixIcon: Icon(Icons.alternate_email_outlined),
                    suffixIcon: _isCheckingUsername
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          )
                        : null,
                  ),
                  validator: ValidationUtils.compose(
                      [ValidationUtils.required, ValidationUtils.username]),
                  onChanged: (value) {
                    Future.delayed(const Duration(milliseconds: 500), () {
                      if (value == _usernameController.text) {
                        _checkUsernameAvailability(value);
                      }
                    });
                  },
                  onFieldSubmitted: (_) {
                    _usernameFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(_emailFocusNode);
                  },
                ),

                if (_usernameAvailabilityMessage != null)
                  Padding(
                    padding: EdgeInsets.only(top: 8, left: 16),
                    child: Text(
                      _usernameAvailabilityMessage!,
                      style: TextStyle(
                          color: _usernameAvailabilityMessage!
                                  .contains('available')
                              ? Colors.green
                              : Colors.red,
                          fontSize: 12),
                    ),
                  ),
                const SizedBox(
                  height: 16,
                ),

                TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    obscureText: !_showPassword,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter a password',
                        prefixIcon: Icon(Icons.lock_outline),
                        suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            icon: Icon(
                              _showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ))),
                    validator: ValidationUtils.compose([
                      ValidationUtils.required,
                      ValidationUtils.minLength(8),
                      ValidationUtils.passwordStrength,
                    ]),
                    onFieldSubmitted: (_) {
                      _passwordFocusNode.unfocus();
                      FocusScope.of(context)
                          .requestFocus(_confirmPasswordFocusNode);
                    }),

                const SizedBox(
                  height: 16,
                ),

                TextFormField(
                    controller: _confirmPasswordController,
                    focusNode: _confirmPasswordFocusNode,
                    obscureText: !_showConfirmPassword,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm your password',
                        prefixIcon: Icon(Icons.lock_outline),
                        suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                _showConfirmPassword = !_showConfirmPassword;
                              });
                            },
                            icon: Icon(
                              _showConfirmPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ))),
                    validator: ValidationUtils.compose([
                      ValidationUtils.required,
                      ValidationUtils.passwordMatch(_passwordController.text),
                    ]),
                ),

                const SizedBox(
                  height: 16,
                ),

                _buildSectionHeader("Contact Information"),
                
                TextFormField(
                  controller: _phoneController,
                  focusNode: _phoneFocusNode,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(15)
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    hintText: 'Enter your phone number',
                    prefixIcon: Icon(Icons.phone_android_outlined),
                )
                ),

                const SizedBox(
                  height: 16,
                ),

                DropdownButtonFormField(
                  value: _selectedRole,
                    decoration: const InputDecoration(
                      labelText: 'Role',
                      prefixIcon: Icon(Icons.work_outline),
                    ),
                    items: _roles.map((role) {
                      return DropdownMenuItem(
                          value: role,
                          child: Text(role));
                    }).toList(),
                    onChanged: (value){
                      setState(() {
                        _selectedRole = value!;
                      });
                    }),

                const SizedBox(
                  height: 16,
                ),

                _buildSectionHeader('Preferences'),

                CheckboxListTile(
                  title: const Text('Accept Terms and Conditions'),
                  subtitle: const Text('You mush accept to continue'),
                    value: _acceptTerms,
                    onChanged: (value){
                      setState(() {
                        _acceptTerms = value!;
                      });
                    },
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                SwitchListTile(
                  title: const Text('Subscribe to Newsletter'),
                  subtitle: const Text('Receive updates and news'),
                    value: _newsletterSubscription,
                    onChanged: (value){
                      setState(() {
                        _newsletterSubscription = value;
                      });
                    }
                ),
                const SizedBox(height: 32,),

                FilledButton(
                    onPressed: _isSubmitting ? null : _handleSubmit,
                    child: _isSubmitting ?
                        const SizedBox(
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
                      )
                    )
                ),

                const SizedBox(height: 16,),

                OutlinedButton(
                    onPressed: _isSubmitting ? null : _resetForm,
                    child: const Text('Reset Form'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                )


              ],
            )),
      )),
    );
  }
}

Widget _buildSectionHeader(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16, top: 8),
    child: Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 16, color: Colors.purple),
    ),
  );
}
