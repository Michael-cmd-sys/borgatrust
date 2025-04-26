import 'package:firebase_auth/firebase_auth.dart';

/// Authentication service class to handle all Firebase authentication methods
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current authenticated user
  User? get currentUser => _auth.currentUser;

  // Get authentication state changes as a Stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Check if user is authenticated
  bool get isAuthenticated => _auth.currentUser != null;

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Register with email and password
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Update user profile (displayName and photoURL)
  Future<void> updateProfile({String? displayName, String? photoURL}) async {
    try {
      await _auth.currentUser?.updateDisplayName(displayName);
      await _auth.currentUser?.updatePhotoURL(photoURL);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Change user password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      // Re-authenticate user before changing password
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);

      // Change password
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Helper method to handle Firebase auth exceptions
  Exception _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return Exception('No user found with this email');
      case 'wrong-password':
        return Exception('Incorrect password');
      case 'email-already-in-use':
        return Exception('Email is already in use');
      case 'weak-password':
        return Exception('Password is too weak');
      case 'invalid-email':
        return Exception('Email address is invalid');
      case 'user-disabled':
        return Exception('This user account has been disabled');
      case 'too-many-requests':
        return Exception('Too many attempts. Try again later');
      case 'operation-not-allowed':
        return Exception('Operation not allowed. Contact support');
      case 'requires-recent-login':
        return Exception('Please log in again before retrying this request');
      default:
        return Exception('An error occurred: ${e.message}');
    }
  }
}
