import 'package:flutter/material.dart';
import 'package:studenttrack/UI/TeacherWashroomUI.dart';
import '../components.dart';
import '../components.dart';
import 'TeacherClinicUI.dart';
import 'package:studenttrack/components.dart';

class TeacherUI extends StatefulWidget {
  final String schoolDB;
  TeacherUI({@required this.schoolDB});

  @override
  _TeacherUIState createState() => _TeacherUIState();
}

class _TeacherUIState extends State<TeacherUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 6,
              child: MaterialButton(
                color: Colors.red,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TeacherClinicUI(schoolDB: widget.schoolDB),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 6,
              child: MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TeacherWashroomUI(schoolDB: widget.schoolDB),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
