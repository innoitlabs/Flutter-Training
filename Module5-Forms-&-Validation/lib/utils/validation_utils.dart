/// Reusable Validation Utilities
/// 
/// This file contains pure validation functions that can be:
/// - Used individually or composed together
/// - Easily tested and maintained
/// - Localized by centralizing error messages
class ValidationUtils {
  // Private constructor to prevent instantiation
  ValidationUtils._();

  // Error messages - centralized for easy localization
  static const String _requiredMessage = 'This field is required';
  static const String _emailMessage = 'Please enter a valid email address';
  static const String _minLengthMessage = 'Must be at least {length} characters';
  static const String _maxLengthMessage = 'Must be no more than {length} characters';
  static const String _phoneMessage = 'Please enter a valid phone number';
  static const String _passwordMatchMessage = 'Passwords do not match';

  /// Required field validation
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return _requiredMessage;
    }
    return null;
  }

  /// Email validation using regex
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Let required validator handle empty values
    }
    
    // Email regex pattern
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    
    if (!emailRegex.hasMatch(value)) {
      return _emailMessage;
    }
    return null;
  }

  /// Minimum length validation
  static String? Function(String?) minLength(int length) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return null; // Let required validator handle empty values
      }
      
      if (value.length < length) {
        return _minLengthMessage.replaceAll('{length}', length.toString());
      }
      return null;
    };
  }

  /// Maximum length validation
  static String? Function(String?) maxLength(int length) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return null; // Let required validator handle empty values
      }
      
      if (value.length > length) {
        return _maxLengthMessage.replaceAll('{length}', length.toString());
      }
      return null;
    };
  }

  /// Phone number validation (basic)
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Let required validator handle empty values
    }
    
    // Remove all non-digit characters for validation
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    
    // Check if it's a valid phone number (7-15 digits)
    if (digitsOnly.length < 7 || digitsOnly.length > 15) {
      return _phoneMessage;
    }
    return null;
  }

  /// Password strength validation
  static String? passwordStrength(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Let required validator handle empty values
    }
    
    final hasUppercase = value.contains(RegExp(r'[A-Z]'));
    final hasLowercase = value.contains(RegExp(r'[a-z]'));
    final hasDigits = value.contains(RegExp(r'[0-9]'));
    final hasSpecialCharacters = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    
    if (!hasUppercase) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!hasLowercase) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!hasDigits) {
      return 'Password must contain at least one number';
    }
    if (!hasSpecialCharacters) {
      return 'Password must contain at least one special character';
    }
    
    return null;
  }

  /// Cross-field validation: password confirmation
  static String? Function(String?) passwordMatch(String password) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return null; // Let required validator handle empty values
      }
      
      if (value != password) {
        return _passwordMatchMessage;
      }
      return null;
    };
  }

  /// Username validation (alphanumeric + underscore, 3-20 chars)
  static String? username(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Let required validator handle empty values
    }
    
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
    if (!usernameRegex.hasMatch(value)) {
      return 'Username must be 3-20 characters, letters, numbers, and underscores only';
    }
    return null;
  }

  /// Compose multiple validators
  /// Returns the first non-null error message, or null if all validators pass
  static String? Function(String?) compose(List<String? Function(String?)> validators) {
    return (String? value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) {
          return error; // Return first error found
        }
      }
      return null; // All validators passed
    };
  }

  /// Async validation simulation (for server-side validation)
  static Future<String?> Function(String?) asyncValidation(
    Future<String?> Function(String?) validator,
  ) {
    return (String? value) async {
      try {
        return await validator(value);
      } catch (e) {
        return 'Validation error: ${e.toString()}';
      }
    };
  }

  /// Debounced validation for real-time checks
  static String? Function(String?) debounced(
    String? Function(String?) validator,
    Duration delay,
  ) {
    String? lastValue;
    String? lastResult;
    DateTime? lastCallTime;
    
    return (String? value) {
      final now = DateTime.now();
      
      // If same value and within delay, return cached result
      if (value == lastValue && 
          lastCallTime != null && 
          now.difference(lastCallTime!) < delay) {
        return lastResult;
      }
      
      // Update cache
      lastValue = value;
      lastCallTime = now;
      lastResult = validator(value);
      
      return lastResult;
    };
  }

  /// Custom validation with custom error message
  static String? Function(String?) custom(
    bool Function(String?) condition,
    String errorMessage,
  ) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return null; // Let required validator handle empty values
      }
      
      if (!condition(value)) {
        return errorMessage;
      }
      return null;
    };
  }
}
