import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:studenttrack/Screens/Designation.dart';
import 'package:studenttrack/Screens/Home.dart';

class AuthServices {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Future signIn(String email, String password, context) async {
    try {
      auth.UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.id, (Route<dynamic> route) => false);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut(context) async {
    try {
      await _auth.signOut();
      Navigator.pushNamedAndRemoveUntil(
          context, Designation.id, (Route<dynamic> route) => false);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
