import 'package:flutter/material.dart';

class ConfigUI extends StatefulWidget {
  final String schoolDB;

  ConfigUI({@required this.schoolDB});
  @override
  _ConfigUIState createState() => _ConfigUIState();
}

class _ConfigUIState extends State<ConfigUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4DD172),
        title: Text(
          "CONFIGURATION",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
