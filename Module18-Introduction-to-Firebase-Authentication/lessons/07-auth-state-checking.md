# Lesson 7: Authentication State Checking with StreamBuilder

## 🎯 Learning Objectives
- Understand authentication state management
- Implement StreamBuilder for real-time auth state
- Create automatic navigation based on auth state
- Handle authentication state changes
- Build persistent user sessions

## 🔄 Understanding Authentication State

### What is Authentication State?
Authentication state refers to whether a user is currently logged in or not. This state can change in real-time and needs to be monitored throughout the app.

### Why Use StreamBuilder?
- **Real-time Updates:** Automatically updates when auth state changes
- **Reactive UI:** UI responds immediately to state changes
- **Persistent Sessions:** Maintains login state across app restarts
- **Automatic Navigation:** Redirects users based on auth status

## 🏗️ Implementation Strategy

### Step 1: Enhanced AuthProvider with Stream Support

Update your `AuthProvider` to include stream support:

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

  // Stream for authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Stream for user changes
  Stream<UserModel?> get userStream {
    return authStateChanges.map((User? firebaseUser) {
      if (firebaseUser != null) {
        return UserModel.fromFirebaseUser(firebaseUser);
      }
      return null;
    });
  }

  // Constructor with stream listener
  AuthProvider() {
    _init();
  }

  void _init() {
    // Listen to authentication state changes
    _auth.authStateChanges().listen((User? firebaseUser) {
      if (firebaseUser != null) {
        _user = UserModel.fromFirebaseUser(firebaseUser);
      } else {
        _user = null;
      }
      notifyListeners();
    });
  }

  // ... rest of your existing methods ...
}
```

### Step 2: Create Auth Wrapper Widget

Create `lib/widgets/auth_wrapper.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show loading screen while checking auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        }
        
        // If user is logged in, show home screen
        if (snapshot.hasData && snapshot.data != null) {
          return HomeScreen();
        }
        
        // If user is not logged in, show login screen
        return LoginScreen();
      },
    );
  }
}
```

### Step 3: Enhanced Splash Screen with Auth State

Update your `splash_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _checkAuthStatus();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _animationController.forward();
  }

  void _checkAuthStatus() async {
    // Wait for minimum splash time
    await Future.delayed(Duration(seconds: 2));
    
    if (mounted) {
      final User? user = FirebaseAuth.instance.currentUser;
      
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
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Logo with animation
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
          },
        ),
      ),
    );
  }
}
```

### Step 4: Create Auth State Listener Widget

Create `lib/widgets/auth_state_listener.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';

class AuthStateListener extends StatelessWidget {
  final Widget child;

  const AuthStateListener({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show loading screen while checking auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingScreen();
        }
        
        // Update auth provider with current user
        if (snapshot.hasData && snapshot.data != null) {
          final authProvider = Provider.of<AuthProvider>(context, listen: false);
          if (authProvider.user == null) {
            // User just logged in, update provider
            WidgetsBinding.instance.addPostFrameCallback((_) {
              authProvider._updateUser(snapshot.data!);
            });
          }
        } else {
          // User logged out, clear provider
          final authProvider = Provider.of<AuthProvider>(context, listen: false);
          if (authProvider.user != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              authProvider._clearUser();
            });
          }
        }
        
        return child;
      },
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              'Checking authentication...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Step 5: Enhanced Main App with Auth State

Update your `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'widgets/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Firebase Auth',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
```

### Step 6: Create Auth State Indicator Widget

Create `lib/widgets/auth_state_indicator.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthStateIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingIndicator();
        }
        
        if (snapshot.hasData && snapshot.data != null) {
          return _buildAuthenticatedIndicator(snapshot.data!);
        }
        
        return _buildUnauthenticatedIndicator();
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 12,
            height: 12,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[600]!),
            ),
          ),
          SizedBox(width: 8),
          Text(
            'Checking...',
            style: TextStyle(
              color: Colors.orange[800],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthenticatedIndicator(User user) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green[600],
            size: 16,
          ),
          SizedBox(width: 8),
          Text(
            'Authenticated',
            style: TextStyle(
              color: Colors.green[800],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnauthenticatedIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.red[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cancel,
            color: Colors.red[600],
            size: 16,
          ),
          SizedBox(width: 8),
          Text(
            'Not Authenticated',
            style: TextStyle(
              color: Colors.red[800],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
```

### Step 7: Enhanced Home Screen with Auth State

Update your home screen to include auth state monitoring:

```dart
// Add this to your home screen:

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
          // Auth state indicator
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: AuthStateIndicator(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          // Show loading if auth state is being checked
          if (authProvider.isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading user data...'),
                ],
              ),
            );
          }

          // Show error if no user data
          if (authProvider.user == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[400],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No user data available',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please sign in again',
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
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

  // ... rest of your existing methods ...
}
```

## 🔄 Real-time Auth State Updates

### Step 8: Create Auth State Monitor

Create `lib/widgets/auth_state_monitor.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class AuthStateMonitor extends StatefulWidget {
  final Widget child;

  const AuthStateMonitor({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _AuthStateMonitorState createState() => _AuthStateMonitorState();
}

class _AuthStateMonitorState extends State<AuthStateMonitor> {
  late StreamSubscription<User?> _authStateSubscription;

  @override
  void initState() {
    super.initState();
    _startMonitoring();
  }

  void _startMonitoring() {
    _authStateSubscription = FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        
        if (user != null) {
          // User logged in
          authProvider._updateUser(user);
        } else {
          // User logged out
          authProvider._clearUser();
        }
      },
    );
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
```

## 🧪 Testing Authentication State

### Test Scenarios

1. **App Launch**
   - Open app
   - Should check auth state
   - Navigate to appropriate screen

2. **Login Flow**
   - Sign in with valid credentials
   - Should automatically navigate to home
   - Auth state should update

3. **Logout Flow**
   - Sign out from home screen
   - Should automatically navigate to login
   - Auth state should clear

4. **Session Persistence**
   - Close and reopen app
   - Should maintain login state
   - Navigate directly to home

5. **Network Issues**
   - Turn off internet
   - Should handle gracefully
   - Show appropriate error

## ✅ What We've Implemented

1. **Real-time Auth State Monitoring**
   - StreamBuilder for auth state changes
   - Automatic UI updates
   - Persistent session management

2. **Enhanced Navigation**
   - Automatic redirects based on auth state
   - Smooth transitions
   - Proper loading states

3. **Auth State Indicators**
   - Visual feedback for auth status
   - Loading indicators
   - Error states

4. **Robust State Management**
   - Provider pattern integration
   - Stream-based updates
   - Error handling

## 🎯 Next Steps

In **Lesson 8**, we'll implement Google Sign-In functionality to complete our authentication system.

### Key Takeaways
- StreamBuilder provides real-time updates
- Authentication state should be monitored continuously
- Proper navigation prevents user confusion
- Loading states improve user experience
- Session persistence is crucial for good UX

---

**Ready to add Google Sign-In? Let's go to Lesson 8! 🔐**
