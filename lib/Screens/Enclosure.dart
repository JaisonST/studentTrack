import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:studenttrack/AuthenticationSystem/Auth.dart';
import 'package:studenttrack/AuthenticationSystem/User.dart';
import 'package:studenttrack/Screens/Home.dart';
import 'package:studenttrack/AuthenticationSystem/Wrapper.dart';
import 'package:studenttrack/Screens/Loading.dart';


class Enclosure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      value: AuthServices().user,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/':(context) => Wrapper(),
          '/home':(context) => HomeScreen(),
        },
      ),
    );
  }
}



