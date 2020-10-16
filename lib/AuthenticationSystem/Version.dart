import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studenttrack/DatabaseServices/Database.dart';
import 'package:studenttrack/Screens/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:studenttrack/Screens/LogIn.dart';
import 'package:studenttrack/Screens/Update.dart';
import 'package:studenttrack/UI/TeacherClinicUI.dart';
import '../Screens/Home.dart';
import '../UI/TeacherUI.dart';

class Version extends StatefulWidget {
  static String id = 'Version';
  final String uid;
  Version({this.uid});
  @override
  _VersionState createState() => _VersionState();
}

class _VersionState extends State<Version> {
  int version;
  bool isVersionCorrect;
  @override
  void initState() {
    version = 1;
    isVersionCorrect = false;
    DatabaseServices(uid: widget.uid).returnVersion().then((value) {
      if (version == value) {
        setState(() {
          isVersionCorrect = true;
        });
      }
      print(value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isVersionCorrect ? HomeScreen() : Update();
  }
}
