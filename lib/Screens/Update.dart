import 'package:flutter/material.dart';

class Update extends StatelessWidget {
  static String id = "UpdateUI";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('App OutDated'),
          ),
          body: Center(
            child: Text("Please Download the Latest Version Of Our APP"),
          )),
    );
  }
}
