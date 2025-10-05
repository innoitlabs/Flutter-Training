# Lesson 5: Exception Handling and Error Management

## 🎯 Learning Objectives
- Understand different types of authentication errors
- Implement comprehensive error handling
- Create user-friendly error messages
- Handle network and Firebase-specific errors
- Add retry mechanisms and fallback options

## 🚨 Types of Authentication Errors

### 1. **Firebase Auth Exceptions**
These are specific to Firebase Authentication and have error codes:

```dart
// Common Firebase Auth error codes:
'user-not-found'           // No user with this email
'wrong-password'           // Incorrect password
'email-already-in-use'     // Email already registered
'weak-password'           // Password too weak
'invalid-email'           // Invalid email format
'user-disabled'           // Account disabled
'too-many-requests'       // Rate limiting
'operation-not-allowed'   // Sign-in method disabled
'invalid-credential'      // Invalid credentials
'network-request-failed'  // Network issues
```

### 2. **Network Errors**
These occur when there's no internet connection or server issues:

```dart
// Common network error scenarios:
- No internet connection
- Server timeout
- DNS resolution failure
- SSL certificate issues
- API rate limiting
```

### 3. **Validation Errors**
These are client-side validation errors:

```dart
// Common validation errors:
- Empty email field
- Invalid email format
- Password too short
- Password mismatch
- Required fields missing
```

## 🛠️ Comprehensive Error Handling Implementation

### Step 1: Enhanced AuthProvider with Better Error Handling

Update your `AuthProvider` with these improvements:

```dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;
  AuthErrorType? _errorType;

  // Getters
  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  AuthErrorType? get errorType => _errorType;
  bool get isAuthenticated => _user != null;

  // Enhanced error handling
  void _handleError(dynamic error, {String? customMessage}) {
    _setLoading(false);
    
    if (error is FirebaseAuthException) {
      _errorType = AuthErrorType.firebaseAuth;
      _errorMessage = _getFirebaseErrorMessage(error);
    } else if (error.toString().contains('network')) {
      _errorType = AuthErrorType.network;
      _errorMessage = 'Network error. Please check your internet connection.';
    } else if (error.toString().contains('timeout')) {
      _errorType = AuthErrorType.timeout;
      _errorMessage = 'Request timed out. Please try again.';
    } else {
      _errorType = AuthErrorType.unknown;
      _errorMessage = customMessage ?? 'An unexpected error occurred. Please try again.';
    }
    
    notifyListeners();
  }

  // Get user-friendly Firebase error messages
  String _getFirebaseErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found with this email address. Please check your email or create a new account.';
      case 'wrong-password':
        return 'Incorrect password. Please try again or reset your password.';
      case 'email-already-in-use':
        return 'An account already exists with this email address. Please sign in instead.';
      case 'weak-password':
        return 'Password is too weak. Please choose a stronger password with at least 6 characters.';
      case 'invalid-email':
        return 'Invalid email address. Please check your email format.';
      case 'user-disabled':
        return 'This account has been disabled. Please contact support for assistance.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please wait a few minutes before trying again.';
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled. Please contact support.';
      case 'invalid-credential':
        return 'Invalid credentials. Please check your email and password.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different sign-in method.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different account.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection and try again.';
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please sign in again.';
      default:
        return 'Authentication failed: ${e.message ?? 'Unknown error'}';
    }
  }

  // Enhanced sign in with retry mechanism
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    int retryCount = 0;
    const maxRetries = 3;
    
    while (retryCount < maxRetries) {
      try {
        _setLoading(true);
        _setError(null);

        final UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (result.user != null) {
          _user = UserModel.fromFirebaseUser(result.user!);
          _setLoading(false);
          return true;
        }
        return false;
      } on FirebaseAuthException catch (e) {
        // Don't retry for certain errors
        if (_shouldNotRetry(e.code)) {
          _handleError(e);
          return false;
        }
        
        retryCount++;
        if (retryCount >= maxRetries) {
          _handleError(e);
          return false;
        }
        
        // Wait before retry
        await Future.delayed(Duration(seconds: retryCount));
      } catch (e) {
        retryCount++;
        if (retryCount >= maxRetries) {
          _handleError(e);
          return false;
        }
        
        await Future.delayed(Duration(seconds: retryCount));
      }
    }
    return false;
  }

  // Check if error should not be retried
  bool _shouldNotRetry(String errorCode) {
    const nonRetryableErrors = [
      'user-not-found',
      'wrong-password',
      'invalid-email',
      'user-disabled',
      'invalid-credential',
    ];
    return nonRetryableErrors.contains(errorCode);
  }

  // Clear error
  void clearError() {
    _errorMessage = null;
    _errorType = null;
    notifyListeners();
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set error
  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }
}

// Error type enum
enum AuthErrorType {
  firebaseAuth,
  network,
  timeout,
  validation,
  unknown,
}
```

### Step 2: Enhanced Error Display Widget

Create `lib/widgets/error_display.dart`:

```dart
import 'package:flutter/material.dart';
import '../providers/auth_provider.dart';

class ErrorDisplay extends StatelessWidget {
  final AuthProvider authProvider;
  final VoidCallback? onRetry;

  const ErrorDisplay({
    Key? key,
    required this.authProvider,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (authProvider.errorMessage == null) {
      return SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _getErrorColor(authProvider.errorType).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getErrorColor(authProvider.errorType).withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getErrorIcon(authProvider.errorType),
                color: _getErrorColor(authProvider.errorType),
                size: 20,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  _getErrorTitle(authProvider.errorType),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _getErrorColor(authProvider.errorType),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, size: 20),
                onPressed: () => authProvider.clearError(),
                color: _getErrorColor(authProvider.errorType),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            authProvider.errorMessage!,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
          if (onRetry != null && _isRetryable(authProvider.errorType)) ...[
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getErrorColor(authProvider.errorType),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Try Again'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getErrorColor(AuthErrorType? errorType) {
    switch (errorType) {
      case AuthErrorType.network:
      case AuthErrorType.timeout:
        return Colors.orange;
      case AuthErrorType.firebaseAuth:
        return Colors.red;
      case AuthErrorType.validation:
        return Colors.amber;
      default:
        return Colors.red;
    }
  }

  IconData _getErrorIcon(AuthErrorType? errorType) {
    switch (errorType) {
      case AuthErrorType.network:
        return Icons.wifi_off;
      case AuthErrorType.timeout:
        return Icons.timer_off;
      case AuthErrorType.firebaseAuth:
        return Icons.error_outline;
      case AuthErrorType.validation:
        return Icons.warning_outlined;
      default:
        return Icons.error_outline;
    }
  }

  String _getErrorTitle(AuthErrorType? errorType) {
    switch (errorType) {
      case AuthErrorType.network:
        return 'Connection Error';
      case AuthErrorType.timeout:
        return 'Request Timeout';
      case AuthErrorType.firebaseAuth:
        return 'Authentication Error';
      case AuthErrorType.validation:
        return 'Validation Error';
      default:
        return 'Error';
    }
  }

  bool _isRetryable(AuthErrorType? errorType) {
    return errorType == AuthErrorType.network || 
           errorType == AuthErrorType.timeout;
  }
}
```

### Step 3: Enhanced Login Screen with Error Handling

Update your login screen to include error display:

```dart
// In your login screen, add this widget:

Widget _buildErrorDisplay() {
  return Consumer<AuthProvider>(
    builder: (context, authProvider, child) {
      return ErrorDisplay(
        authProvider: authProvider,
        onRetry: () {
          authProvider.clearError();
          _handleLogin();
        },
      );
    },
  );
}

// Add it to your build method:
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[50],
    body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 60),
            
            // App Logo/Title
            _buildHeader(),
            
            SizedBox(height: 48),
            
            // Error Display
            _buildErrorDisplay(),
            
            // Login Form
            _buildLoginForm(),
            
            // ... rest of your widgets
          ],
        ),
      ),
    ),
  );
}
```

### Step 4: Network Connectivity Check

Create `lib/utils/connectivity_checker.dart`:

```dart
import 'dart:io';
import 'package:flutter/material.dart';

class ConnectivityChecker {
  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static Future<void> checkConnectivityAndShowError(
    BuildContext context,
    VoidCallback onRetry,
  ) async {
    final hasConnection = await hasInternetConnection();
    
    if (!hasConnection) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('No Internet Connection'),
          content: Text(
            'Please check your internet connection and try again.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onRetry();
              },
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }
  }
}
```

### Step 5: Form Validation Enhancement

Create `lib/utils/validators.dart`:

```dart
class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    
    if (value.length > 128) {
      return 'Password must be less than 128 characters';
    }
    
    return null;
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (value != password) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    
    if (value.length > 50) {
      return 'Name must be less than 50 characters';
    }
    
    return null;
  }
}
```

## 🧪 Testing Error Scenarios

### Test Cases to Implement

1. **Network Errors**
   - Turn off WiFi/mobile data
   - Try to sign in
   - Should show network error

2. **Invalid Credentials**
   - Enter wrong email
   - Enter wrong password
   - Should show appropriate error

3. **Weak Password**
   - Enter password less than 6 characters
   - Should show validation error

4. **Email Already in Use**
   - Try to register with existing email
   - Should show appropriate error

5. **Rate Limiting**
   - Make multiple failed attempts
   - Should show rate limiting error

## 🎯 Best Practices for Error Handling

### 1. **User-Friendly Messages**
- Avoid technical jargon
- Provide actionable advice
- Use positive language when possible

### 2. **Error Categorization**
- Group similar errors
- Provide appropriate icons and colors
- Suggest solutions

### 3. **Retry Mechanisms**
- Allow retry for network errors
- Don't retry for authentication errors
- Show loading states during retry

### 4. **Logging and Monitoring**
- Log errors for debugging
- Monitor error rates
- Track user experience

## ✅ What We've Implemented

1. **Comprehensive Error Handling**
   - Firebase Auth exceptions
   - Network connectivity issues
   - Form validation errors
   - Timeout handling

2. **User-Friendly Error Display**
   - Categorized error messages
   - Appropriate icons and colors
   - Retry mechanisms
   - Clear error titles

3. **Enhanced Validation**
   - Email format validation
   - Password strength requirements
   - Name validation
   - Confirm password matching

4. **Network Awareness**
   - Connectivity checking
   - Offline error handling
   - Retry mechanisms

## 🎯 Next Steps

In **Lesson 6**, we'll add loading indicators and improve the overall user experience with better state management.

### Key Takeaways
- Error handling is crucial for good UX
- Categorize errors for better user experience
- Provide actionable error messages
- Implement retry mechanisms for recoverable errors
- Always validate input on the client side

---

**Ready to add loading indicators? Let's go to Lesson 6! ⏳**
