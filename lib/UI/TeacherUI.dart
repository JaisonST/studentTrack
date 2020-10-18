import 'package:flutter/material.dart';
import 'package:studenttrack/UI/TeacherWashroomUI.dart';
import '../DatabaseServices/Database_Admin.dart';
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
        padding: EdgeInsets.symmetric(vertical: 30.0),
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 6,
                child: MaterialButton(
                  padding: EdgeInsets.all(0),
                  elevation: 0.0,
                  color: Colors.white,
                  child: Image.asset("images/clinic.png"),
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
                  padding: EdgeInsets.all(0),
                  elevation: 0.0,
                  color: Colors.white,
                  child: Image.asset("images/washroom.png"),
                  onPressed: () {
                    DatabaseAdmin(schoolDB: widget.schoolDB)
                        .returnWashroomList()
                        .then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeacherWashroomUI(
                            schoolDB: widget.schoolDB,
                            washroomList: value,
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
