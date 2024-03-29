import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:studenttrack/DatabaseServices/Database.dart';
import 'package:studenttrack/Screens/Home.dart';
import 'package:studenttrack/Screens/LogIn.dart';
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

  Future createNewUser(String loc, String schoolDB, String email,
      String password, String type) async {
    email = email.replaceAll(' ', '');
    password = password.replaceAll(' ', '');
    String subject = "$loc Setup Complete: Ready to Track";
    String body =
        "Sir/Madam,\n\n$type: $loc has been set up for tracking. A unique username and password has been assigned to access the control page of $loc. The details are as follows:\n\n\tName of Collection:$loc \n\tUsername:  $email\n\tPassword:  $password\n\nWith Regards\nStudent Track Team\n\nNote:Do not reply to this message as it is a computer generated one.";
    String id = "";
    List<dynamic> emails =
        await DatabaseAdmin(schoolDB: schoolDB).getRecipientList();
    try {
      //temp firebase app so doesnt log into main app
      FirebaseApp newApp = await Firebase.initializeApp(
          name: 'Secondary', options: Firebase.app().options);
      //sending temp account to use details
      auth.UserCredential userCredential =
          await auth.FirebaseAuth.instanceFor(app: newApp)
              .createUserWithEmailAndPassword(email: email, password: password);
      newApp.delete();

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

  Future deleteUser(String val, String schoolDB) async {
    try {
      String localEmail = val + "." + schoolDB + "@strack.com";
      String localPassword = val + "_" + schoolDB;

      //temp firebase app so doesnt log into main app
      FirebaseApp newApp = await Firebase.initializeApp(
          name: 'Secondary', options: Firebase.app().options);
      auth.UserCredential userCredential =
          await auth.FirebaseAuth.instanceFor(app: newApp)
              .signInWithEmailAndPassword(
                  email: localEmail, password: localPassword);
      userCredential.user.delete();
      newApp.delete();
    } catch (e) {
      print(e);
    }
  }

  Future signOut(context) async {
    try {
      await _auth.signOut();
      Navigator.pushNamedAndRemoveUntil(
          context, LogIn.id, (Route<dynamic> route) => false);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
