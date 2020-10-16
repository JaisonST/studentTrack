import 'package:flutter/material.dart';
import 'SetupUI.dart';

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
