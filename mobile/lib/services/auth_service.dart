import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis_auth/googleapis_auth.dart';

enum Authentication { Google, Firebase, Undefined }

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleAuth;
  AuthClient client;

  Authentication _authenticationMethod = Authentication.Undefined;

  AuthService(this._firebaseAuth, this._googleAuth);

  User get currentUser => _firebaseAuth.currentUser;

  AuthClient get getClient => client;

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Authentication get getAuthenticationMethod => _authenticationMethod;

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    if (_authenticationMethod == Authentication.Google)
      await _googleAuth.signOut();
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
      _authenticationMethod = Authentication.Firebase;
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
      _authenticationMethod = Authentication.Firebase;
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
      client = await _googleAuth.authenticatedClient();
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      userCredential = await _firebaseAuth.signInWithCredential(credential);
      _authenticationMethod = Authentication.Google;
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
