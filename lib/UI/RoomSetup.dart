import 'package:flutter/material.dart';
import 'SetupUI.dart';

class RoomSetup extends StatefulWidget {
  final List<dynamic> rooms;
  final String schoolDB;
  RoomSetup({@required this.rooms, this.schoolDB});

  @override
  _RoomSetupState createState() => _RoomSetupState();
}

class _RoomSetupState extends State<RoomSetup> {
  @override
  Widget build(BuildContext context) {
    return SetupUI(
      items: widget.rooms,
      schoolDB: widget.schoolDB,
      display: "Rooms",
    );
  }
}
