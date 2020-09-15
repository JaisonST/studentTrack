import 'package:flutter/material.dart';
import 'package:studenttrack/components.dart';

class ClinicUI extends StatefulWidget {
  @override
  _ClinicUIState createState() => _ClinicUIState();
}

class _ClinicUIState extends State<ClinicUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      floatingActionButton: ClinicAddButton(),
    );
  }
}
