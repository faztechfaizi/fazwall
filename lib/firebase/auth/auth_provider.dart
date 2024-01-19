// ignore_for_file: use_build_context_synchronously

import 'package:fazwalls/utils/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProviderr with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  //signup method

  Future<void> signUp(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // await _auth.currentUser?.updateDisplayName(username);

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message.toString());
      throw e;
    }
  }

  // signin method
  Future<void> signIn(
      BuildContext context, String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await _updateSignInStatus(true);

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message!);
      throw e;
    }
  }

  //google signin

  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await _updateSignInStatus(true);

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //password reset

  Future passwordReset(BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      showSnackbar(context, 'Password reset link sent! Check your email');
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message!);
    }
  }

  // Sign out method
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      await _updateSignInStatus(false);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message.toString());
      throw e;
    }
  }

  Future<void> _updateSignInStatus(bool isSignedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isUserSignedIn', isSignedIn);
  }
}




