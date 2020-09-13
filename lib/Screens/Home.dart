import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  String id;
  HomeScreen({this.id});
  @override
  _HomeScreenState createState() => _HomeScreenState(id:id);
}

class _HomeScreenState extends State<HomeScreen> {
  String id;
  _HomeScreenState({this.id});
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
