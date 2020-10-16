import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:studenttrack/DatabaseServices/Database.dart';
import 'package:studenttrack/Screens/Designation.dart';
import 'package:studenttrack/Screens/Home.dart';
import 'package:studenttrack/components.dart';
import 'package:studenttrack/DatabaseServices/Database_Admin.dart';

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

  Future createNewUser(
      String loc, String schoolDB, String email, String password) async {
    String subject = "$loc Setup Complete: Ready to Track";
    String body =
        "Sir/Madam,\n\nWashroom:$loc has been set up for tracking. A unique username and password has been assigned to access the control page of $loc. The details are as follows:\n\tName of Collection:$loc \n\tUsername:  $email\n\tPassword:  $password\n\nWith Regards\nStudent Track Team\n\nNote:Do not reply to this message as it is a computer generated one.";
    String id = "";
    List<dynamic> emails =
        await DatabaseAdmin(schoolDB: schoolDB).getRecipientList();
    try {
      auth.UserCredential userCredential = await register(email, password);
      if (userCredential.user != null) {
        id = userCredential.user.uid;
        await DatabaseServices(uid: id).createUser(schoolDB, loc);
        sendMail(emails: emails, subject: subject, body: body, attach: null);
      }
    } catch (e) {
      print("or here");
      print(e.toString());
      return null;
    }
  }

  //register without login
  Future<auth.UserCredential> register(String email, String password) async {
    FirebaseApp newApp = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);
    return auth.FirebaseAuth.instanceFor(app: newApp)
        .createUserWithEmailAndPassword(email: email, password: password);
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
