import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleAuth;

  AuthService(this._firebaseAuth, this._googleAuth);

  User get currentUser => _firebaseAuth.currentUser;

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<UserCredential> emailSignIn(
      {BuildContext context,
      Function trySignIn,
      Function failedSignIn,
      String email,
      String password}) async {
    UserCredential userCredential;
    try {
      trySignIn();
      userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } catch (err) {
      failedSignIn();
      var message = 'Please verify your credentials!';
      if (err.message != null) {
        message = err.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      return null;
    }
  }

  Future<UserCredential> emailSignUp(
      {BuildContext context,
      Function trySignUp,
      Function failedSignUp,
      String email,
      String username,
      String password}) async {
    UserCredential userCredential;
    try {
      trySignUp();
      userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } catch (err) {
      failedSignUp();
      var message = 'Please verify your credentials!';
      if (err.message != null) {
        message = err.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      return null;
    }
  }

  Future<UserCredential> googleSignIn({
    BuildContext context,
    Function trySignIn,
    Function failedSignIn,
  }) async {
    UserCredential userCredential;
    try {
      trySignIn();
      final GoogleSignInAccount googleUser = await _googleAuth.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      userCredential = await _firebaseAuth.signInWithCredential(credential);
      return userCredential;
    } catch (err) {
      failedSignIn();
      var message = 'An error occurred, please check your credentials!';

      if (err.message != null) {
        message = err.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      return null;
    }
  }
}