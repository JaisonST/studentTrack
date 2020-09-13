import 'package:flutter/material.dart';
import 'package:studenttrack/Screens/Enclosure.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Text('Loading',
            style: TextStyle(color: Colors.black, fontSize: 20.0)),
      ),
    );
  }
}
