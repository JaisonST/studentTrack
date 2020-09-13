import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:studenttrack/AuthenticationSystem/Auth.dart';
import 'package:studenttrack/AuthenticationSystem/User.dart';
import 'package:studenttrack/Screens/Home.dart';
import 'package:studenttrack/AuthenticationSystem/Wrapper.dart';


void main() => runApp(StudentTrack());

class StudentTrack extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
        builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.done){
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
        );

  }
}

