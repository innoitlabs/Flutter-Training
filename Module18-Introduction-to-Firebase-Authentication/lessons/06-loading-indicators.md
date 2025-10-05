# Lesson 6: Loading Indicators and State Management

## 🎯 Learning Objectives
- Implement loading indicators for better UX
- Create reusable loading components
- Handle different loading states
- Add skeleton screens and progress indicators
- Implement proper state management

## ⏳ Why Loading Indicators Matter

### User Experience Benefits
1. **Feedback:** Users know something is happening
2. **Patience:** Reduces perceived wait time
3. **Confidence:** Shows the app is working
4. **Professional:** Makes the app feel polished

### Types of Loading States
- **Button Loading:** Show spinner in button
- **Screen Loading:** Full screen loading overlay
- **Skeleton Loading:** Placeholder content
- **Progress Loading:** Show progress percentage

## 🎨 Loading Indicator Components

### Step 1: Create Loading Overlay Widget

Create `lib/widgets/loading_overlay.dart`:

```dart
import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? loadingText;
  final Color? backgroundColor;
  final Color? indicatorColor;

  const LoadingOverlay({
    Key? key,
    required this.isLoading,
    required this.child,
    this.loadingText,
    this.backgroundColor,
    this.indicatorColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: backgroundColor ?? Colors.black.withOpacity(0.5),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        indicatorColor ?? Colors.blue[600]!,
                      ),
                    ),
                    if (loadingText != null) ...[
                      SizedBox(height: 16),
                      Text(
                        loadingText!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
```

### Step 2: Create Loading Button Widget

Create `lib/widgets/loading_button.dart`:

```dart
import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Widget? icon;
  final double? width;
  final double? height;

  const LoadingButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.icon,
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
          backgroundColor: backgroundColor ?? Colors.blue[600],
          foregroundColor: textColor ?? Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: borderColor != null 
                ? BorderSide(color: borderColor!) 
                : BorderSide.none,
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
                      valueColor: AlwaysStoppedAnimation<Color>(
                        textColor ?? Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Loading...',
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
                  if (icon != null) ...[
                    icon!,
                    SizedBox(width: 8),
                  ],
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

### Step 3: Create Skeleton Loading Widget

Create `lib/widgets/skeleton_loading.dart`:

```dart
import 'package:flutter/material.dart';

class SkeletonLoading extends StatefulWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const SkeletonLoading({
    Key? key,
    this.width,
    this.height,
    this.borderRadius,
  }) : super(key: key);

  @override
  _SkeletonLoadingState createState() => _SkeletonLoadingState();
}

class _SkeletonLoadingState extends State<SkeletonLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.grey[300]!,
                Colors.grey[100]!,
                Colors.grey[300]!,
              ],
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ].map((stop) => stop.clamp(0.0, 1.0)).toList(),
            ),
          ),
        );
      },
    );
  }
}

// Skeleton card for user info
class SkeletonUserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Avatar skeleton
          Row(
            children: [
              SkeletonLoading(
                width: 50,
                height: 50,
                borderRadius: BorderRadius.circular(25),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonLoading(
                      width: double.infinity,
                      height: 20,
                    ),
                    SizedBox(height: 8),
                    SkeletonLoading(
                      width: 150,
                      height: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Content skeleton
          SkeletonLoading(
            width: double.infinity,
            height: 16,
          ),
          SizedBox(height: 8),
          SkeletonLoading(
            width: double.infinity,
            height: 16,
          ),
          SizedBox(height: 8),
          SkeletonLoading(
            width: 200,
            height: 16,
          ),
        ],
      ),
    );
  }
}
```

### Step 4: Create Progress Indicator Widget

Create `lib/widgets/progress_indicator.dart`:

```dart
import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double progress;
  final String? label;
  final Color? backgroundColor;
  final Color? progressColor;
  final double? height;

  const CustomProgressIndicator({
    Key? key,
    required this.progress,
    this.label,
    this.backgroundColor,
    this.progressColor,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8),
        ],
        Container(
          height: height ?? 8,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: progressColor ?? Colors.blue[600],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          '${(progress * 100).toInt()}%',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
```

## 🔄 Enhanced State Management

### Step 5: Update AuthProvider with Loading States

```dart
// Add these methods to your AuthProvider:

class AuthProvider extends ChangeNotifier {
  // ... existing code ...

  // Loading states for different operations
  bool _isSigningIn = false;
  bool _isSigningUp = false;
  bool _isSigningOut = false;
  bool _isResettingPassword = false;

  // Getters for specific loading states
  bool get isSigningIn => _isSigningIn;
  bool get isSigningUp => _isSigningUp;
  bool get isSigningOut => _isSigningOut;
  bool get isResettingPassword => _isResettingPassword;

  // Enhanced sign in with specific loading state
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      _isSigningIn = true;
      _setError(null);
      notifyListeners();

      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        _user = UserModel.fromFirebaseUser(result.user!);
        _isSigningIn = false;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _handleError(e);
      _isSigningIn = false;
      notifyListeners();
      return false;
    }
  }

  // Enhanced sign up with specific loading state
  Future<bool> createUserWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      _isSigningUp = true;
      _setError(null);
      notifyListeners();

      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        await result.user!.updateDisplayName(name);
        await result.user!.reload();
        final User? updatedUser = _auth.currentUser;
        
        if (updatedUser != null) {
          _user = UserModel.fromFirebaseUser(updatedUser);
        }
        
        _isSigningUp = false;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _handleError(e);
      _isSigningUp = false;
      notifyListeners();
      return false;
    }
  }

  // Enhanced sign out with loading state
  Future<void> signOut() async {
    try {
      _isSigningOut = true;
      _setError(null);
      notifyListeners();

      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }

      await _auth.signOut();
      
      _user = null;
      _isSigningOut = false;
      notifyListeners();
    } catch (e) {
      _handleError(e);
      _isSigningOut = false;
      notifyListeners();
    }
  }

  // Enhanced password reset with loading state
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      _isResettingPassword = true;
      _setError(null);
      notifyListeners();

      await _auth.sendPasswordResetEmail(email: email);
      
      _isResettingPassword = false;
      notifyListeners();
      return true;
    } catch (e) {
      _handleError(e);
      _isResettingPassword = false;
      notifyListeners();
      return false;
    }
  }
}
```

### Step 6: Enhanced Login Screen with Loading States

```dart
// Update your login screen with better loading states:

class _LoginScreenState extends State<LoginScreen> {
  // ... existing code ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return LoadingOverlay(
            isLoading: authProvider.isLoading,
            loadingText: _getLoadingText(authProvider),
            child: SafeArea(
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
                    
                    SizedBox(height: 24),
                    
                    // Social Login
                    _buildSocialLogin(),
                    
                    SizedBox(height: 24),
                    
                    // Register Link
                    _buildRegisterLink(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _getLoadingText(AuthProvider authProvider) {
    if (authProvider.isSigningIn) {
      return 'Signing you in...';
    } else if (authProvider.isSigningUp) {
      return 'Creating your account...';
    } else if (authProvider.isSigningOut) {
      return 'Signing you out...';
    } else if (authProvider.isResettingPassword) {
      return 'Sending reset email...';
    }
    return 'Loading...';
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email Field
          CustomTextField(
            controller: _emailController,
            label: 'Email',
            hint: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email_outlined,
            validator: (value) => Validators.validateEmail(value),
          ),
          
          SizedBox(height: 16),
          
          // Password Field
          CustomTextField(
            controller: _passwordController,
            label: 'Password',
            hint: 'Enter your password',
            obscureText: _obscurePassword,
            prefixIcon: Icons.lock_outlined,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey[600],
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            validator: (value) => Validators.validatePassword(value),
          ),
          
          SizedBox(height: 16),
          
          // Forgot Password
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => _showForgotPasswordDialog(),
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Colors.blue[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          
          SizedBox(height: 24),
          
          // Login Button with Loading State
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return LoadingButton(
                text: 'Sign In',
                onPressed: authProvider.isLoading ? null : _handleLogin,
                isLoading: authProvider.isSigningIn,
                backgroundColor: Colors.blue[600],
              );
            },
          ),
        ],
      ),
    );
  }

  void _showForgotPasswordDialog() {
    final emailController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reset Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Enter your email address and we\'ll send you a reset link.'),
            SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return TextButton(
                onPressed: authProvider.isResettingPassword 
                    ? null 
                    : () => _handlePasswordReset(emailController.text),
                child: authProvider.isResettingPassword
                    ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text('Send Reset Link'),
              );
            },
          ),
        ],
      ),
    );
  }

  void _handlePasswordReset(String email) async {
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your email address')),
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.sendPasswordResetEmail(email);
    
    if (success) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset email sent!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
```

## 🎨 Loading Animation Examples

### Step 7: Create Animated Loading Widget

Create `lib/widgets/animated_loading.dart`:

```dart
import 'package:flutter/material.dart';

class AnimatedLoading extends StatefulWidget {
  final double size;
  final Color? color;

  const AnimatedLoading({
    Key? key,
    this.size = 50,
    this.color,
  }) : super(key: key);

  @override
  _AnimatedLoadingState createState() => _AnimatedLoadingState();
}

class _AnimatedLoadingState extends State<AnimatedLoading>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          child: Stack(
            children: [
              // Outer ring
              Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: (widget.color ?? Colors.blue[600]!).withOpacity(0.3),
                    width: 3,
                  ),
                ),
              ),
              // Animated arc
              CustomPaint(
                size: Size(widget.size, widget.size),
                painter: LoadingPainter(
                  progress: _animation.value,
                  color: widget.color ?? Colors.blue[600]!,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class LoadingPainter extends CustomPainter {
  final double progress;
  final Color color;

  LoadingPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;

    final startAngle = -90 * (3.14159 / 180);
    final sweepAngle = 270 * (3.14159 / 180) * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
```

## ✅ What We've Implemented

1. **Comprehensive Loading States**
   - Button loading indicators
   - Screen loading overlays
   - Skeleton loading screens
   - Progress indicators

2. **Enhanced State Management**
   - Specific loading states for different operations
   - Proper loading state cleanup
   - User-friendly loading messages

3. **Reusable Loading Components**
   - Custom loading buttons
   - Loading overlays
   - Skeleton screens
   - Animated loading indicators

4. **Better User Experience**
   - Clear feedback during operations
   - Appropriate loading messages
   - Smooth animations
   - Professional appearance

## 🎯 Next Steps

In **Lesson 7**, we'll implement authentication state checking with StreamBuilder for real-time updates.

### Key Takeaways
- Loading indicators improve user experience
- Different operations need different loading states
- Skeleton screens reduce perceived loading time
- Proper state management prevents UI issues
- Loading messages should be descriptive

---

**Ready to add real-time authentication state? Let's go to Lesson 7! 🔄**
