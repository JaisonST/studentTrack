import 'package:flutter/material.dart';
import 'package:studenttrack/UI/TeacherWashroomUI.dart';
import 'package:studenttrack/UI/TeacherRoomUI.dart';
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
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 6,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Color(0xff4dd172), width: 3.0),
                  ),
                  padding: EdgeInsets.all(10),
                  elevation: 0.0,
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.only(
                        right: 20.0, top: 10.0, bottom: 10.0, left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: SizedBox(),
                              ),
                              Expanded(
                                  flex: 9,
                                  child: Image.asset("images/clinic.png")),
                              Expanded(
                                flex: 1,
                                child: SizedBox(),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 2,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              'CLINIC',
                              style: TextStyle(color: Color(0xff848080)),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Color(0xff4dd172), width: 3.0),
                  ),
                  padding: EdgeInsets.all(10),
                  elevation: 0.0,
                  color: Colors.white,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Image.asset("images/washroom.png"),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 6,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              'WASHROOM',
                              style: TextStyle(color: Color(0xff848080)),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 6,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Color(0xff4dd172), width: 3.0),
                  ),
                  padding: EdgeInsets.all(10),
                  elevation: 0.0,
                  color: Colors.white,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Image.asset("images/room.png"),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 3,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              'OTHERS',
                              style: TextStyle(color: Color(0xff848080)),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    DatabaseAdmin(schoolDB: widget.schoolDB)
                        .returnRoomList()
                        .then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeacherRoomUI(
                            schoolDB: widget.schoolDB,
                            roomList: value,
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
