import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Patience is a Virtue',
              style: TextStyle(color: Color(0xff4dd172), fontSize: 30.0)),
        ),
      ),
    );
  }
}
