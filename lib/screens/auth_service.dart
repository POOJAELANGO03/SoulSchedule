import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Add Firestore instance

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // --- Updated method to add user data to Firestore ---
  Future<void> _addUserToFirestore(User user, {String? displayName}) async {
    final userDoc = _firestore.collection('Users').doc(user.uid);
    final snapshot = await userDoc.get();

    // Only create the document if it doesn't already exist
    if (!snapshot.exists) {
      await userDoc.set({
        'uid': user.uid,
        'email': user.email,
        // Use the passed displayName for email signups, or the one from the User object for Google Sign-In
        'displayName': displayName ?? user.displayName,
        'photoURL': user.photoURL,
        'createdAt': DateTime.now(),
      });
    }
  }

  // Sign in with email and password
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // No need to add user here, as they would have been added at signup
      return result.user;
    } on FirebaseAuthException catch (e) {
      debugPrint('Failed to sign in with Email & Password: ${e.message}');
      return null;
    }
  }

  // --- Updated Sign up with email and password to accept a displayName ---
  Future<User?> signUpWithEmail(String email, String password, String displayName) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        // Update the user's profile in Firebase Auth
        await result.user!.updateDisplayName(displayName);

        // After creating the user, add their data to Firestore, passing the name
        await _addUserToFirestore(result.user!, displayName: displayName);
      }
      return result.user;
    } on FirebaseAuthException catch (e) {
      debugPrint('Failed to sign up with Email & Password: ${e.message}');
      return null;
    }
  }

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential result = await _auth.signInWithCredential(credential);

      if (result.user != null) {
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
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      debugPrint('Error signing out: $e');
    }
  }
}
