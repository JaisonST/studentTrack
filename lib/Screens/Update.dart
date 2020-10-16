import 'package:flutter/material.dart';
import 'package:studenttrack/Screens/LogIn.dart';

class Update extends StatelessWidget {
  static String id = "UpdateUI";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          child: Center(
            child: Column(
              children: [
                Expanded(flex: 2, child: SizedBox()),
                Expanded(flex: 3, child: StudentTrackTitle()),
                Expanded(
                    flex: 2,
                    child: Text(
                      "Please Update The App",
                      style: TextStyle(fontSize: 20.0),
                    )),
                Expanded(flex: 3, child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
