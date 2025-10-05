# Lesson 8: Google Sign-In Implementation

## 🎯 Learning Objectives
- Set up Google Sign-In for Flutter
- Configure Google OAuth in Firebase Console
- Implement Google Sign-In functionality
- Handle Google Sign-In errors
- Integrate with existing authentication flow

## 🔐 Understanding Google Sign-In

### What is Google Sign-In?
Google Sign-In allows users to authenticate using their Google account instead of creating a new account with email/password.

### Benefits of Google Sign-In
- **Faster Registration:** No need to create new accounts
- **Better Security:** Google handles password security
- **User Convenience:** One-click authentication
- **Reduced Friction:** Higher conversion rates

### How Google Sign-In Works
```
1. User taps "Sign in with Google"
2. Google OAuth popup appears
3. User grants permissions
4. Google returns access token
5. Firebase validates token
6. User is authenticated
```

## 🛠️ Setup Google Sign-In

### Step 1: Configure Google Sign-In in Firebase Console

1. **Go to Firebase Console**
   - Open your Firebase project
   - Navigate to Authentication → Sign-in method

2. **Enable Google Sign-In**
   - Click on "Google" provider
   - Toggle "Enable"
   - Select project support email
   - Click "Save"

3. **Get OAuth Configuration**
   - Note down the Web SDK configuration
   - You'll need the client ID for iOS setup

### Step 2: Configure Android

The Android configuration is already done with `google-services.json`, but let's verify:

1. **Check google-services.json**
   - Ensure it's in `android/app/` directory
   - Verify it contains Google Sign-In configuration

2. **Update Android Dependencies**
   - Open `android/app/build.gradle`
   - Ensure Google Services plugin is applied:

```gradle
apply plugin: 'com.google.gms.google-services'
```

3. **Add Internet Permission**
   - Open `android/app/src/main/AndroidManifest.xml`
   - Ensure internet permission is present:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

### Step 3: Configure iOS

1. **Add GoogleService-Info.plist**
   - Ensure it's added to Xcode project
   - Verify it's in the app target

2. **Update Info.plist**
   - Open `ios/Runner/Info.plist`
   - Add URL scheme for Google Sign-In:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>REVERSED_CLIENT_ID</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>YOUR_REVERSED_CLIENT_ID</string>
        </array>
    </dict>
</array>
```

**Note:** Replace `YOUR_REVERSED_CLIENT_ID` with the value from your `GoogleService-Info.plist` file.

### Step 4: Install Dependencies

Update your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Firebase Dependencies
  firebase_core: ^3.6.0
  firebase_auth: ^5.3.1
  
  # Google Sign-In
  google_sign_in: ^6.2.1
  
  # State Management
  provider: ^6.1.2
  
  # UI Dependencies
  cupertino_icons: ^1.0.8
  flutter_svg: ^2.0.10+1
  
  # Environment Variables
  flutter_dotenv: ^5.1.0
```

Run `flutter pub get` to install dependencies.

## 🔧 Implementation

### Step 1: Enhanced AuthProvider with Google Sign-In

Update your `AuthProvider` with Google Sign-In methods:

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

  // Google Sign-In specific loading states
  bool _isGoogleSigningIn = false;
  bool _isGoogleSigningOut = false;

  // Getters
  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  AuthErrorType? get errorType => _errorType;
  bool get isAuthenticated => _user != null;
  bool get isGoogleSigningIn => _isGoogleSigningIn;
  bool get isGoogleSigningOut => _isGoogleSigningOut;

  // Constructor
  AuthProvider() {
    _init();
  }

  void _init() {
    _auth.authStateChanges().listen((User? firebaseUser) {
      if (firebaseUser != null) {
        _user = UserModel.fromFirebaseUser(firebaseUser);
      } else {
        _user = null;
      }
      notifyListeners();
    });
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set error message
  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _errorMessage = null;
    _errorType = null;
    notifyListeners();
  }

  // Google Sign-In implementation
  Future<bool> signInWithGoogle() async {
    try {
      _isGoogleSigningIn = true;
      _setLoading(true);
      _setError(null);
      notifyListeners();

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        // User cancelled the sign-in
        _isGoogleSigningIn = false;
        _setLoading(false);
        notifyListeners();
        return false;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential result = await _auth.signInWithCredential(credential);

      if (result.user != null) {
        _user = UserModel.fromFirebaseUser(result.user!);
        _isGoogleSigningIn = false;
        _setLoading(false);
        notifyListeners();
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      _handleGoogleSignInError(e);
      _isGoogleSigningIn = false;
      _setLoading(false);
      notifyListeners();
      return false;
    } catch (e) {
      _handleGoogleSignInError(e);
      _isGoogleSigningIn = false;
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  // Handle Google Sign-In specific errors
  void _handleGoogleSignInError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'account-exists-with-different-credential':
          _errorType = AuthErrorType.firebaseAuth;
          _errorMessage = 'An account already exists with the same email but different sign-in method. Please sign in with your original method.';
          break;
        case 'invalid-credential':
          _errorType = AuthErrorType.firebaseAuth;
          _errorMessage = 'Google Sign-In failed. Please try again.';
          break;
        case 'operation-not-allowed':
          _errorType = AuthErrorType.firebaseAuth;
          _errorMessage = 'Google Sign-In is not enabled. Please contact support.';
          break;
        case 'user-disabled':
          _errorType = AuthErrorType.firebaseAuth;
          _errorMessage = 'This Google account has been disabled. Please contact support.';
          break;
        default:
          _errorType = AuthErrorType.firebaseAuth;
          _errorMessage = 'Google Sign-In failed: ${error.message}';
      }
    } else {
      _errorType = AuthErrorType.unknown;
      _errorMessage = 'Google Sign-In failed: ${error.toString()}';
    }
  }

  // Enhanced sign out with Google Sign-In support
  Future<void> signOut() async {
    try {
      _isGoogleSigningOut = true;
      _setLoading(true);
      _setError(null);
      notifyListeners();

      // Sign out from Google if signed in with Google
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }

      // Sign out from Firebase
      await _auth.signOut();
      
      _user = null;
      _isGoogleSigningOut = false;
      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setError('Sign out failed: ${e.toString()}');
      _isGoogleSigningOut = false;
      _setLoading(false);
      notifyListeners();
    }
  }

  // Check if user signed in with Google
  bool get isGoogleUser {
    if (_user == null) return false;
    return _user!.photoURL != null && _user!.photoURL!.contains('googleusercontent.com');
  }

  // Get Google profile information
  Future<GoogleSignInAccount?> getGoogleProfile() async {
    try {
      return await _googleSignIn.signInSilently();
    } catch (e) {
      return null;
    }
  }

  // Disconnect Google account
  Future<void> disconnectGoogle() async {
    try {
      await _googleSignIn.disconnect();
    } catch (e) {
      _setError('Failed to disconnect Google account: ${e.toString()}');
    }
  }

  // ... rest of your existing methods ...
}
```

### Step 2: Create Google Sign-In Button Widget

Create `lib/widgets/google_sign_in_button.dart`:

```dart
import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String text;
  final double? width;
  final double? height;

  const GoogleSignInButton({
    Key? key,
    this.onPressed,
    this.isLoading = false,
    this.text = 'Continue with Google',
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey[800],
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey[300]!),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[600]!),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Signing in...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Google Logo
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/google_logo.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
```

### Step 3: Add Google Logo Asset

Create `assets/images/google_logo.png` or use this SVG approach:

Create `lib/widgets/google_logo.dart`:

```dart
import 'package:flutter/material.dart';

class GoogleLogo extends StatelessWidget {
  final double size;

  const GoogleLogo({
    Key? key,
    this.size = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Center(
        child: Text(
          'G',
          style: TextStyle(
            color: Colors.blue[600],
            fontSize: size * 0.6,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
```

### Step 4: Update Login Screen with Google Sign-In

Update your login screen to include Google Sign-In:

```dart
// In your login screen, update the social login section:

Widget _buildSocialLogin() {
  return Column(
    children: [
      // Divider
      Row(
        children: [
          Expanded(child: Divider(color: Colors.grey[300])),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'OR',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey[300])),
        ],
      ),
      
      SizedBox(height: 24),
      
      // Google Sign In Button
      Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return GoogleSignInButton(
            onPressed: authProvider.isLoading ? null : _handleGoogleSignIn,
            isLoading: authProvider.isGoogleSigningIn,
          );
        },
      ),
    ],
  );
}

void _handleGoogleSignIn() async {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  
  try {
    final success = await authProvider.signInWithGoogle();
    
    if (success && authProvider.user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Google Sign-In failed: ${e.toString()}'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
```

### Step 5: Update Register Screen with Google Sign-In

Similarly, update your register screen:

```dart
// In your register screen, update the social login section:

Widget _buildSocialLogin() {
  return Column(
    children: [
      // Divider
      Row(
        children: [
          Expanded(child: Divider(color: Colors.grey[300])),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'OR',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey[300])),
        ],
      ),
      
      SizedBox(height: 24),
      
      // Google Sign In Button
      Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return GoogleSignInButton(
            onPressed: authProvider.isLoading ? null : _handleGoogleSignIn,
            isLoading: authProvider.isGoogleSigningIn,
            text: 'Sign up with Google',
          );
        },
      ),
    ],
  );
}
```

### Step 6: Enhanced Home Screen with Google User Info

Update your home screen to show Google user information:

```dart
// In your home screen, update the user info card:

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
        
        // User Avatar (if Google user)
        if (user.photoURL != null) ...[
          Center(
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.photoURL!),
            ),
          ),
          SizedBox(height: 16),
        ],
        
        _buildInfoRow('Email', user.email ?? 'Not provided'),
        _buildInfoRow('Name', user.displayName ?? 'Not provided'),
        _buildInfoRow('User ID', user.uid),
        _buildInfoRow('Sign-in Method', 
          user.photoURL != null && user.photoURL!.contains('googleusercontent.com')
              ? 'Google'
              : 'Email/Password'
        ),
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
```

## 🧪 Testing Google Sign-In

### Test Scenarios

1. **Successful Google Sign-In**
   - Tap "Continue with Google"
   - Complete Google OAuth flow
   - Should navigate to home screen

2. **Cancelled Google Sign-In**
   - Tap "Continue with Google"
   - Cancel in Google OAuth popup
   - Should return to login screen

3. **Google Sign-In Error**
   - Test with invalid Google account
   - Should show appropriate error message

4. **Account Linking**
   - Try to sign in with Google when account exists with email
   - Should handle account linking

## 🔒 Security Considerations

### Best Practices

1. **OAuth Scopes**
   - Only request necessary permissions
   - Don't ask for excessive data

2. **Token Management**
   - Firebase handles token refresh
   - Don't store tokens manually

3. **Error Handling**
   - Handle all Google Sign-In errors
   - Provide fallback options

4. **User Privacy**
   - Respect user's Google privacy settings
   - Handle account deletion properly

## ✅ What We've Implemented

1. **Complete Google Sign-In Integration**
   - OAuth configuration
   - Firebase credential handling
   - Error management

2. **Enhanced UI Components**
   - Google Sign-In button
   - Loading states
   - Error display

3. **Account Management**
   - Google user profile display
   - Sign-in method detection
   - Proper logout handling

4. **Cross-Platform Support**
   - Android configuration
   - iOS configuration
   - Web support (if needed)

## 🎯 Next Steps

In **Lesson 9**, we'll create the complete Flutter Firebase Auth app with all features integrated.

### Key Takeaways
- Google Sign-In requires OAuth configuration
- Proper error handling is crucial
- UI should reflect Google user information
- Security considerations are important
- Testing on both platforms is essential

---

**Ready to build the complete app? Let's go to Lesson 9! 🚀**
