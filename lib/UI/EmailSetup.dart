import 'package:flutter/material.dart';
import 'SetupUI.dart';

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
