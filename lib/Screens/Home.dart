import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return TeacherUI();
  }
}

class TeacherUI extends StatefulWidget {
  @override
  _TeacherUIState createState() => _TeacherUIState();
}

class _TeacherUIState extends State<TeacherUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,

        backgroundColor: Colors.white, //Color(0xff4DD172),
        title: Row(
          children: <Widget>[
            Text(
              'STUDENT -',
              style: TextStyle(
                color: Color(0xff4DD172),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '- TRACK',
              style: TextStyle(
                color: Colors.grey[350],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        child: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 40.0,
          ),
          backgroundColor: Color(0xff4DD172),
          onPressed: () {},
        ),
      ),
      body: Center(
        child: Container(
          color: Colors.yellow,
        ),
      ),
    );
  }
}
