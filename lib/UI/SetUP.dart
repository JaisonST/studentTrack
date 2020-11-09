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
      display: "Room",
    );
  }
}

class WashroomSetup extends StatefulWidget {
  final List<dynamic> washrooms;
  final String schoolDB;
  WashroomSetup({@required this.washrooms, this.schoolDB});

  @override
  _WashroomSetupState createState() => _WashroomSetupState();
}

class _WashroomSetupState extends State<WashroomSetup> {
  @override
  Widget build(BuildContext context) {
    return SetupUI(
      items: widget.washrooms,
      schoolDB: widget.schoolDB,
      display: "Washroom",
    );
  }
}

class EmailSetup extends StatefulWidget {
  final List<dynamic> emails;
  final String schoolDB;
  EmailSetup({@required this.emails, this.schoolDB});

  @override
  _EmailSetupState createState() => _EmailSetupState();
}

class _EmailSetupState extends State<EmailSetup> {
  @override
  Widget build(BuildContext context) {
    return SetupUI(
      items: widget.emails,
      schoolDB: widget.schoolDB,
      display: "Email",
    );
  }
}
