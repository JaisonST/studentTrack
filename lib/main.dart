import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:studenttrack/AuthenticationSystem/Auth.dart';
import 'package:studenttrack/AuthenticationSystem/User.dart';
import 'package:studenttrack/Screens/Home.dart';
import 'package:studenttrack/AuthenticationSystem/Wrapper.dart';
import 'package:studenttrack/Screens/Loading.dart';
import 'package:studenttrack/Screens/Designation.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xff4DD172),
                title: Text('Something went wrong'),
              ),
              body: Center(
                child: Text('Are you connected to the Network?'),
              )));
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Loading();
    }

    return StreamProvider<Users>.value(
      value: AuthServices().user,
      child: MaterialApp(
        initialRoute: Wrapper.id,
        routes: {
          Wrapper.id: (context) => Wrapper(),
          HomeScreen.id: (context) => HomeScreen(),
          Designation.id: (context) => Designation(),
        },
      ),
    );
  }
}
