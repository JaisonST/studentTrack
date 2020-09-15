import 'package:flutter/material.dart';
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
  bool isClinic = true;

  @override
  void initState() {
    isClinic =
        DatabaseServices(uid: _auth.currentUser.uid).returnDesignation() ==
            "Clinic";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isClinic ? ClinicUI() : TeacherUI();
  }
}
