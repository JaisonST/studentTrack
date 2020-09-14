import 'package:flutter/material.dart';
import 'package:studenttrack/UI/TeacherUI.dart';

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
