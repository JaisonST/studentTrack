import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studenttrack/Screens/Home.dart';
import 'package:studenttrack/Screens/Designation.dart';
import 'package:flutter/cupertino.dart';
import 'package:studenttrack/Screens/LogIn.dart';

import '../Screens/Designation.dart';
import '../Screens/Home.dart';

class Wrapper extends StatefulWidget {
  static String id = 'Wrapper';
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool loggedIn;

  @override
  void initState() {
    loggedIn = false;
    FirebaseAuth.instance.currentUser != null
        ? setState(() {
            loggedIn = true;
          })
        : print('no user');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: loggedIn ? HomeScreen.id : Designation.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        Designation.id: (context) => Designation(),
        LogIn.id: (context) => LogIn(),
      },
    );
  }
}
