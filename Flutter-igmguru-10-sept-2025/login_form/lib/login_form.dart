import 'dart:io';

import 'package:flutter/material.dart';
import 'package:login_form/validation_utils.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _isSubmitting = false;

  Future<void> _handleSubmit() async {
    if(!_formKey.currentState!.validate()){
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try{
      await Future.delayed(const Duration(seconds: 2));

      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text("Login Successful"),
            backgroundColor: Theme.of(context).colorScheme.primary,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(24),
          )
        );

        // // Navigate back with result
        // Navigator.pop(context, {
        //   'email': _emailController.text,
        //   'success': true,
        // });

      }
    }
    catch(e){
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login Failed: $e"),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
          )
        );
      }
        }
        finally{
          setState(() {
            _isSubmitting = false;
          });
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
        title: const Text('Login Form'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Icon(
                    //   Icons.lock_outline,
                    //   size: 64,
                    //   color: Theme.of(context).colorScheme.primary,
                    // ),
                    Image.asset('images/Airbnb-Logo.png',
                    width: 150,
                    height: 100,),
                    const SizedBox(height: 16,),
                    Text("Welcome Back",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8,),
                    Text("Sign into your account",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant
                    ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32,),
                    TextFormField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.email_outlined),
                          hintText: 'Enter Your Email Address'
                    ),
                      validator: ValidationUtils.compose([
                        ValidationUtils.required,
                        ValidationUtils.email
                      ]),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                    ),
                    const SizedBox(height: 16,),

                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock_outline),
                        hintText: 'Enter Your Password'
                    ),
                      validator: ValidationUtils.compose([
                        ValidationUtils.required,
                        ValidationUtils.minLength(6)
                      ]),
                      onFieldSubmitted: (_) {
                        _handleSubmit();
                      },
                    ),
                    const SizedBox(height: 16,),
                    FilledButton(
                        onPressed: _isSubmitting ? null : _handleSubmit,
                        child: _isSubmitting
                            ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                    )
                    ) :
                            const Text("Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            )
                    ),),
                    const SizedBox(height: 16,),
                    OutlinedButton(
                        onPressed: _isSubmitting ? null : _resetForm,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )
                        ),
                        child: const Text("Reset Form")
                    )

                  ],
                ),
          )
      ),
      )
    );
  }
}
