import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(Trial());
}

class Trial extends StatefulWidget {
  @override
  _TrialState createState() => _TrialState();
}

class _TrialState extends State<Trial> {
  String password;
  String email;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('firebase test'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'email',
              ),
              onChanged: (value) {
                email = value;
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'password',
              ),
              onChanged: (value) {
                password = value;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
