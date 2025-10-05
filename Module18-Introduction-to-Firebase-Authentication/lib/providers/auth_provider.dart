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

  // Getters
  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

  // Constructor
  AuthProvider() {
    _init();
  }

  // Initialize auth state listener
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
    notifyListeners();
  }

  // Sign in with email and password
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
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
      _setError(_getErrorMessage(e));
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  // Create user with email and password
  Future<bool> createUserWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      _setLoading(true);
      _setError(null);

      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        // Update display name
        await result.user!.updateDisplayName(name);
        
        // Reload user to get updated info
        await result.user!.reload();
        final User? updatedUser = _auth.currentUser;
        
        if (updatedUser != null) {
          _user = UserModel.fromFirebaseUser(updatedUser);
        }
        
        _setLoading(false);
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      _setError(_getErrorMessage(e));
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('An unexpected error occurred: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  // Sign in with Google
  Future<bool> signInWithGoogle() async {
    try {
      _setLoading(true);
      _setError(null);

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        // User cancelled the sign-in
        _setLoading(false);
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
        _setLoading(false);
        return true;
      }
      return false;
    } catch (e) {
      _setError('Google Sign-In failed: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      _setLoading(true);
      _setError(null);

      // Sign out from Google if signed in with Google
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }

      // Sign out from Firebase
      await _auth.signOut();
      
      _user = null;
      _setLoading(false);
    } catch (e) {
      _setError('Sign out failed: ${e.toString()}');
      _setLoading(false);
    }
  }

  // Send password reset email
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      _setLoading(true);
      _setError(null);

      await _auth.sendPasswordResetEmail(email: email);
      
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setError(_getErrorMessage(e));
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('Password reset failed: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  // Update user profile
  Future<bool> updateUserProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        _setError('No user is currently signed in');
        _setLoading(false);
        return false;
      }

      // Update display name
      if (displayName != null) {
        await currentUser.updateDisplayName(displayName);
      }

      // Update photo URL
      if (photoURL != null) {
        await currentUser.updatePhotoURL(photoURL);
      }

      // Reload user to get updated info
      await currentUser.reload();
      final User? updatedUser = _auth.currentUser;
      
      if (updatedUser != null) {
        _user = UserModel.fromFirebaseUser(updatedUser);
      }

      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Profile update failed: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  // Delete user account
  Future<bool> deleteAccount() async {
    try {
      _setLoading(true);
      _setError(null);

      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        _setError('No user is currently signed in');
        _setLoading(false);
        return false;
      }

      await currentUser.delete();
      
      _user = null;
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Account deletion failed: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  // Get user-friendly error messages
  String _getErrorMessage(FirebaseAuthException e) {
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
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled. Please contact support.';
      case 'invalid-credential':
        return 'Invalid credentials. Please check your email and password.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email address but different sign-in credentials.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user account.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please try again.';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please try again.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      default:
        return 'Authentication failed: ${e.message}';
    }
  }

  // Check if user is signed in
  bool get isSignedIn => _auth.currentUser != null;

  // Get current user
  User? get currentFirebaseUser => _auth.currentUser;

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
