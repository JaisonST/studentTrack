import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  String userID;
  static String id = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState(userID: id);
}

class _HomeScreenState extends State<HomeScreen> {
  String userID;
  _HomeScreenState({this.userID});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Text(
      'Home',
    ));
  }
}
