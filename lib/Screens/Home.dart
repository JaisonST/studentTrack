import 'package:flutter/material.dart';
import 'package:studenttrack/Screens/Loading.dart';
import 'package:studenttrack/UI/AdminUI.dart';
import 'package:studenttrack/UI/TeacherUI.dart';
import 'package:studenttrack/DatabaseServices/Database.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:studenttrack/UI/ClinicUI.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  String isClinic = "first";
  String studentDB = "first";
  @override
  void initState() {
    DatabaseServices(uid: _auth.currentUser.uid)
        .returnDesignation()
        .then((result) {
      setState(() {
        isClinic = result;
      });
    });
    DatabaseServices(uid: _auth.currentUser.uid).returnDB().then((result) {
      setState(() {
        studentDB = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isClinic == "first" || studentDB == "first") {
      return Loading();
    } else if (isClinic == "Clinic") {
      return ClinicUI();
    } else if (isClinic == "Teacher") {
      return TeacherUI(
        schoolDB: studentDB,
      );
    } else {
      return AdminUI();
    }
  }
}
