import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

// Custom exception for better error handling in the UI
class GoogleSignInException implements Exception {
  final String message;
  GoogleSignInException(this.message);

  @override
  String toString() => message;
}
=======
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
>>>>>>> 9e9cfc30ef04b1e10d6c5933f99b029e7b0d7ee0

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
<<<<<<< HEAD
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

=======
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Add Firestore instance

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // --- Updated method to add user data to Firestore ---
>>>>>>> 9e9cfc30ef04b1e10d6c5933f99b029e7b0d7ee0
  Future<void> _addUserToFirestore(User user, {String? displayName}) async {
    final userDoc = _firestore.collection('Users').doc(user.uid);
    final snapshot = await userDoc.get();

<<<<<<< HEAD
=======
    // Only create the document if it doesn't already exist
>>>>>>> 9e9cfc30ef04b1e10d6c5933f99b029e7b0d7ee0
    if (!snapshot.exists) {
      await userDoc.set({
        'uid': user.uid,
        'email': user.email,
<<<<<<< HEAD
        'displayName': displayName ?? user.displayName,
        'photoURL': user.photoURL,
        'createdAt': FieldValue.serverTimestamp(),
=======
        // Use the passed displayName for email signups, or the one from the User object for Google Sign-In
        'displayName': displayName ?? user.displayName,
        'photoURL': user.photoURL,
        'createdAt': DateTime.now(),
>>>>>>> 9e9cfc30ef04b1e10d6c5933f99b029e7b0d7ee0
      });
    }
  }

<<<<<<< HEAD
=======
  // Sign in with email and password
>>>>>>> 9e9cfc30ef04b1e10d6c5933f99b029e7b0d7ee0
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
<<<<<<< HEAD
=======
      // No need to add user here, as they would have been added at signup
>>>>>>> 9e9cfc30ef04b1e10d6c5933f99b029e7b0d7ee0
      return result.user;
    } on FirebaseAuthException catch (e) {
      debugPrint('Failed to sign in with Email & Password: ${e.message}');
      return null;
    }
  }

<<<<<<< HEAD
=======
  // --- Updated Sign up with email and password to accept a displayName ---
>>>>>>> 9e9cfc30ef04b1e10d6c5933f99b029e7b0d7ee0
  Future<User?> signUpWithEmail(String email, String password, String displayName) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
<<<<<<< HEAD
        await result.user!.updateDisplayName(displayName);
=======
        // Update the user's profile in Firebase Auth
        await result.user!.updateDisplayName(displayName);

        // After creating the user, add their data to Firestore, passing the name
>>>>>>> 9e9cfc30ef04b1e10d6c5933f99b029e7b0d7ee0
        await _addUserToFirestore(result.user!, displayName: displayName);
      }
      return result.user;
    } on FirebaseAuthException catch (e) {
      debugPrint('Failed to sign up with Email & Password: ${e.message}');
      return null;
    }
  }

<<<<<<< HEAD
=======
  // Sign in with Google
>>>>>>> 9e9cfc30ef04b1e10d6c5933f99b029e7b0d7ee0
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
<<<<<<< HEAD
        // User canceled the sign-in flow.
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
=======
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
>>>>>>> 9e9cfc30ef04b1e10d6c5933f99b029e7b0d7ee0
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential result = await _auth.signInWithCredential(credential);

      if (result.user != null) {
<<<<<<< HEAD
        await _addUserToFirestore(result.user!);
      }
      return result.user;
    } on PlatformException catch (e) {
      // This is a common error for misconfiguration.
      debugPrint('Google Sign-In PlatformException: ${e.code} - ${e.message}');
      throw GoogleSignInException(
          'Google Sign-In Error. Please check your app configuration (e.g., SHA-1 fingerprint in Firebase) and network connection. Error code: ${e.code}');
    } on FirebaseAuthException catch (e) {
      debugPrint('Google Sign-In FirebaseAuthException: ${e.code} - ${e.message}');
      throw GoogleSignInException('Firebase authentication failed. ${e.message}');
    } catch (e) {
      debugPrint('An unexpected error occurred during Google Sign-In: $e');
      throw GoogleSignInException('An unexpected error occurred. Please try again.');
    }
  }

=======
        // For Google sign-in, the displayName is already part of the user object
        await _addUserToFirestore(result.user!);
      }
      return result.user;
    } on FirebaseAuthException catch (e) {
      debugPrint('Failed to sign in with Google: ${e.message}');
      return null;
    }
  }

  // Sign out
>>>>>>> 9e9cfc30ef04b1e10d6c5933f99b029e7b0d7ee0
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      debugPrint('Error signing out: $e');
    }
  }
}
