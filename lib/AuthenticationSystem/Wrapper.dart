import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studenttrack/Screens/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:studenttrack/Screens/LogIn.dart';
import 'package:studenttrack/UI/TeacherClinicUI.dart';
import '../Screens/Home.dart';
import '../UI/TeacherUI.dart';

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
      initialRoute: loggedIn ? HomeScreen.id : LogIn.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        LogIn.id: (context) => LogIn(),
      },
    );
  }
}
