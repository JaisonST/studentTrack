import 'package:flutter/material.dart';
import 'package:studenttrack/AuthenticationSystem/Auth.dart';

class ClinicUI extends StatefulWidget {
  @override
  _ClinicUIState createState() => _ClinicUIState();
}

class _ClinicUIState extends State<ClinicUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () {
          AuthServices().signOut(context);
        },
      ),
    );
  }
}
