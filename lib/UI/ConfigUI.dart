import 'package:flutter/material.dart';

class ConfigUI extends StatefulWidget {
  final String schoolDB;

  ConfigUI({@required this.schoolDB});
  @override
  _ConfigUIState createState() => _ConfigUIState();
}

class _ConfigUIState extends State<ConfigUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4DD172),
        title: Text(
          "CONFIGURATION",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 2,
            child: ConfigChoice(display: "Edit Emergency Emails"),
          ),
          Expanded(
            flex: 2,
            child: ConfigChoice(
              display: "Set Up Washrooms",
            ),
          ),
          Expanded(
            flex: 6,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}

class ConfigChoice extends StatelessWidget {
  final String display;
  ConfigChoice({@required this.display});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
        onPressed: () {},
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Text(
                display,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 1,
              child: Icon(Icons.build, color: Colors.white),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xff4DD172),
      ),
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    );
  }
}