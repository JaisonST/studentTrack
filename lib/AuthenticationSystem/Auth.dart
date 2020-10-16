import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
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

  Future createNewUser(String loc,String schoolDB,String email,String password,context) async {
    String subject = "$loc Setup Complete: Ready to Track";
    String body = "Sir/Madam,\n\n $loc has been set up for tracking. A unique username and password has been assigned to access the control page of $loc. The details are as follows:\n\tName of Collection:$loc \n\t Username:$email\n\tPassword:$password\n\n With Regards\nStudent Track Team\n\nNote:Do not reply to this message as it is a computer generated one.";
    List<String> emails = await DatabaseAdmin(schoolDB: schoolDB)
        .getRecipientList();
    try{
      auth.UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if(userCredential.user != null){
        Navigator.pop((context));
        sendMail(emails: emails,subject: subject,body: body,attach: null);
      }
    }catch(e){
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
