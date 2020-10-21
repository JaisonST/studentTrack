import 'package:flutter/material.dart';
import 'package:studenttrack/Screens/Loading.dart';
import 'package:studenttrack/UI/AdminUI.dart';
import 'package:studenttrack/DatabaseServices/Database.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:studenttrack/UI/ClinicUI.dart';
import 'package:studenttrack/UI/TeacherUI.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  String location = "first";
  String studentDB = "first";
  @override
  void initState() {
    DatabaseServices(uid: _auth.currentUser.uid)
        .returnDesignation()
        .then((result) {
      setState(() {
        location = result;
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
    if (location == "first" || studentDB == "first") {
      return Loading();
    } else if (location == "Admin") {
      return AdminUI(schoolDB: studentDB);
    } else if (location == "Teacher") {
      return TeacherUI(schoolDB: studentDB);
    } else {
      print(location);
      return ClinicUI(
        schoolDB: studentDB,
        collectionName: location,
      );
    }
  }
}
