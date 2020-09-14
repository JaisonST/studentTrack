import 'package:flutter/material.dart';
import 'package:studenttrack/Screens/LogIn.dart';
class Designation extends StatelessWidget {
  static String id = "DesignationScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: Text(
          'Select Designation',
          style: TextStyle(
              color: Colors.grey, fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RatioSpace(ratio: 2),
            DesignationButton(image: 'images/nurse.png'),
            RatioSpace(ratio: 1),
            DesignationButton(image: 'images/teacher.png'),
            RatioSpace(ratio: 4),
          ],
        ),
      ),
    );
  }
}

class RatioSpace extends StatelessWidget {
  RatioSpace({@required this.ratio});
  final int ratio;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: ratio,
      child: SizedBox(),
    );
  }
}

class DesignationButton extends StatelessWidget {
  DesignationButton({@required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: MaterialButton(
        elevation: 5.0,
        child: Image.asset(image),
        onPressed: () {
          Navigator.pushReplacementNamed(context, LogIn.id);
        },
        shape: CircleBorder(),
      ),
    );
  }
}
