/// Service for handling authentication operations
/// This is a fake implementation that simulates real authentication
class AuthService {
  /// Attempts to log in with the provided credentials
  /// Returns true if login is successful, false otherwise
  Future<bool> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Simple validation logic
    if (email.isEmpty || password.isEmpty) {
      return false;
    }
    
    // Fake authentication - accept any valid email format with password length >= 6
    final isValidEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    final isValidPassword = password.length >= 6;
    
    return isValidEmail && isValidPassword;
  }

  /// Logs out the current user
  Future<void> logout() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));
    // In a real app, this would clear tokens, etc.
  }

  /// Checks if the user is currently logged in
  Future<bool> isLoggedIn() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));
    // For this demo, we'll always return false
    // In a real app, this would check for valid tokens
    return false;
  }
}

