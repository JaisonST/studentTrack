import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenttrack/AuthenticationSystem/User.dart';
import 'package:studenttrack/Screens/Home.dart';
import 'package:studenttrack/Screens/Designation.dart';

class Wrapper extends StatelessWidget {
  static String id = 'Wrapper';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);

    if (user == null)
      return Designation();
    else
      return HomeScreen();
  }
}
