import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studenttrack/AuthenticationSystem/Wrapper.dart';
import 'package:studenttrack/DatabaseServices/Database.dart';
import 'package:flutter/cupertino.dart';
import 'package:studenttrack/Screens/Loading.dart';
import 'package:studenttrack/Screens/Update.dart';

class Version extends StatefulWidget {
  @override
  _VersionState createState() => _VersionState();
}

class _VersionState extends State<Version> {
  int version;
  bool isVersionCorrect;
  @override
  void initState() {
    version = 2;
    isVersionCorrect = false;
    DatabaseServices().returnVersion().then((value) {
      if (version == value) {
        setState(() {
          isVersionCorrect = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc('Admin')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data == null)
          return Loading();
        else if (snapshot.data['Version'] == version) {
          return Wrapper();
        } else
          return Update();
      },
    );
    //return isVersionCorrect ? Wrapper() : Update();
  }
}
