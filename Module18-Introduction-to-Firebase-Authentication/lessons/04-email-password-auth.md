# Lesson 4: Email and Password Authentication

## 🎯 Learning Objectives
- Implement email/password authentication using Firebase Auth
- Handle user registration and login
- Manage authentication state
- Add proper error handling
- Create user-friendly feedback

## 🔐 Understanding Firebase Authentication

### How Email/Password Authentication Works

```
1. User enters email and password
2. Firebase validates credentials
3. If valid → Create session → User logged in
4. If invalid → Show error message
5. Session persists until user logs out
```

### Key Concepts

**1. User Registration**
- Create new account with email/password
- Firebase automatically handles password hashing
- Email verification can be enabled
- User profile is created

**2. User Login**
- Verify email/password combination
- Create authenticated session
- Return user object with profile data

**3. Session Management**
- Sessions persist across app restarts
- Automatic token refresh
- Secure logout functionality

## 🏗️ Implementation Steps

### Step 1: Create Authentication Provider

We've already created the `AuthProvider` class. Let's understand its key methods:

```dart
// Key methods in AuthProvider:

// 1. Sign in with email/password
Future<bool> signInWithEmailAndPassword(String email, String password)

// 2. Create new user account
Future<bool> createUserWithEmailAndPassword(String name, String email, String password)

// 3. Sign out
Future<void> signOut()

// 4. Send password reset email
Future<bool> sendPasswordResetEmail(String email)

// 5. Update user profile
Future<bool> updateUserProfile({String? displayName, String? photoURL})
```

### Step 2: Create Splash Screen

Create `lib/screens/splash_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  void _checkAuthStatus() async {
    // Wait for 2 seconds to show splash screen
    await Future.delayed(Duration(seconds: 2));
    
    // Check if user is already logged in
    final User? user = FirebaseAuth.instance.currentUser;
    
    if (mounted) {
      if (user != null) {
        // User is logged in, go to home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // User is not logged in, go to login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                Icons.lock_outline,
                color: Colors.blue[600],
                size: 60,
              ),
            ),
            
            SizedBox(height: 32),
            
            // App Name
            Text(
              'Flutter Auth',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            
            SizedBox(height: 8),
            
            Text(
              'Firebase Authentication',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            
            SizedBox(height: 48),
            
            // Loading Indicator
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Step 3: Create Home Screen

Create `lib/screens/home_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.user == null) {
            return Center(
              child: Text('No user data available'),
            );
          }

          final user = authProvider.user!;

          return SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Card
                _buildWelcomeCard(user),
                
                SizedBox(height: 24),
                
                // User Info Card
                _buildUserInfoCard(user),
                
                SizedBox(height: 24),
                
                // Actions Card
                _buildActionsCard(context, authProvider),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildWelcomeCard(user) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[600]!, Colors.blue[400]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          
          SizedBox(height: 8),
          
          Text(
            user.displayNameOrEmail,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
          
          SizedBox(height: 16),
          
          Row(
            children: [
              Icon(
                Icons.verified_user,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Authenticated',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoCard(user) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          
          SizedBox(height: 16),
          
          _buildInfoRow('Email', user.email ?? 'Not provided'),
          _buildInfoRow('Name', user.displayName ?? 'Not provided'),
          _buildInfoRow('User ID', user.uid),
          _buildInfoRow('Email Verified', user.isEmailVerified ? 'Yes' : 'No'),
          _buildInfoRow('Account Created', 
            user.creationTime != null 
                ? _formatDate(user.creationTime!)
                : 'Unknown'
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsCard(BuildContext context, AuthProvider authProvider) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          
          SizedBox(height: 16),
          
          // Update Profile Button
          _buildActionButton(
            icon: Icons.edit,
            title: 'Update Profile',
            subtitle: 'Change your name and photo',
            onTap: () => _showUpdateProfileDialog(context, authProvider),
          ),
          
          SizedBox(height: 12),
          
          // Change Password Button
          _buildActionButton(
            icon: Icons.lock,
            title: 'Change Password',
            subtitle: 'Update your password',
            onTap: () => _showChangePasswordDialog(context, authProvider),
          ),
          
          SizedBox(height: 12),
          
          // Sign Out Button
          _buildActionButton(
            icon: Icons.logout,
            title: 'Sign Out',
            subtitle: 'Sign out of your account',
            onTap: () => _showLogoutDialog(context),
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDestructive ? Colors.red[50] : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDestructive ? Colors.red[200]! : Colors.grey[200]!,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDestructive ? Colors.red[100] : Colors.blue[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isDestructive ? Colors.red[600] : Colors.blue[600],
                size: 20,
              ),
            ),
            
            SizedBox(width: 16),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDestructive ? Colors.red[800] : Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDestructive ? Colors.red[600] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: isDestructive ? Colors.red[400] : Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign Out'),
          content: Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
                await authProvider.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateProfileDialog(BuildContext context, AuthProvider authProvider) {
    // TODO: Implement profile update dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile update feature coming soon!')),
    );
  }

  void _showChangePasswordDialog(BuildContext context, AuthProvider authProvider) {
    // TODO: Implement password change dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password change feature coming soon!')),
    );
  }
}
```

## 🔧 Error Handling Implementation

### Common Firebase Auth Errors

```dart
// In AuthProvider, we handle these common errors:

switch (e.code) {
  case 'user-not-found':
    return 'No user found with this email address.';
  case 'wrong-password':
    return 'Incorrect password. Please try again.';
  case 'email-already-in-use':
    return 'An account already exists with this email address.';
  case 'weak-password':
    return 'Password is too weak. Please choose a stronger password.';
  case 'invalid-email':
    return 'Invalid email address. Please check your email.';
  case 'user-disabled':
    return 'This account has been disabled. Please contact support.';
  case 'too-many-requests':
    return 'Too many failed attempts. Please try again later.';
  case 'network-request-failed':
    return 'Network error. Please check your internet connection.';
  default:
    return 'Authentication failed: ${e.message}';
}
```

### Error Display in UI

```dart
// In login/register screens, show errors like this:

void _handleLogin() async {
  if (_formKey.currentState!.validate()) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    try {
      await authProvider.signInWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text,
      );
      
      if (authProvider.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } catch (e) {
      // Show error in SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
```

## 🧪 Testing Authentication

### Test User Registration

1. **Open the app**
2. **Tap "Sign Up"**
3. **Enter test details:**
   - Name: "Test User"
   - Email: "test@example.com"
   - Password: "password123"
   - Confirm Password: "password123"
4. **Tap "Create Account"**
5. **Should navigate to Home Screen**

### Test User Login

1. **Open the app**
2. **Enter credentials:**
   - Email: "test@example.com"
   - Password: "password123"
3. **Tap "Sign In"**
4. **Should navigate to Home Screen**

### Test Error Handling

1. **Try wrong password**
2. **Try invalid email**
3. **Try weak password**
4. **Check error messages appear**

## 🔒 Security Best Practices

### Password Requirements
- Minimum 6 characters (Firebase default)
- Consider adding complexity requirements
- Never store passwords in plain text

### Email Validation
- Always validate email format
- Consider email verification
- Handle email already in use

### Session Management
- Sessions persist until logout
- Automatic token refresh
- Secure logout clears all data

## ✅ What We've Implemented

1. **Complete Authentication Flow**
   - User registration with email/password
   - User login with email/password
   - Secure logout functionality

2. **State Management**
   - AuthProvider handles all auth state
   - Automatic navigation based on auth status
   - Loading states and error handling

3. **User Interface**
   - Beautiful login/register screens
   - Home screen with user information
   - Error messages and loading indicators

4. **Error Handling**
   - User-friendly error messages
   - Network error handling
   - Form validation

## 🎯 Next Steps

In **Lesson 5**, we'll add loading indicators and improve the user experience with better state management.

### Key Takeaways
- Firebase Auth handles all security aspects
- State management is crucial for good UX
- Error handling prevents user confusion
- Loading states provide feedback
- Authentication state persists across app restarts

---

**Ready to add loading indicators? Let's go to Lesson 5! ⏳**
