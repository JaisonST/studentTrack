import 'package:flutter/material.dart';

class TeacherWashroomUI extends StatefulWidget {
  final String schoolDB;
  TeacherWashroomUI({@required this.schoolDB});

  @override
  _TeacherWashroomUIState createState() => _TeacherWashroomUIState();
}

class _TeacherWashroomUIState extends State<TeacherWashroomUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4DD172),
        title: Text(
          "WASHROOM",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
