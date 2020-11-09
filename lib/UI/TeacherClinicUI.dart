import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studenttrack/DatabaseServices/Database_Admin.dart';
import 'package:studenttrack/components.dart';
import 'package:studenttrack/Screens/Loading.dart';

import '../components.dart';

class TeacherClinicUI extends StatefulWidget {
  final String schoolDB;
  static String id = "TeacherClinicUI";
  TeacherClinicUI({@required this.schoolDB});
  @override
  _TeacherClinicUIState createState() => _TeacherClinicUIState();
}

class _TeacherClinicUIState extends State<TeacherClinicUI> {
  int liveCases = 0;
  int cap = 20;

  @override
  void initState() {
    DatabaseAdmin(schoolDB: widget.schoolDB).returnCap('Clinic').then((value) {
      setState(() {
        cap = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Schools')
            .doc(widget.schoolDB)
            .collection('Clinic')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Loading();
          } else {
            liveCases = snapshot.data.documents.length;
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  "CLINIC",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: Color(0xff4DD172),
              ),
              floatingActionButton: liveCases >= cap
                  ? EmergencyAddButton(
                      schoolDB: widget.schoolDB,
                      collectionName: 'Clinic',
                    )
                  : ClinicAddButton(
                      schoolDB: widget.schoolDB,
                      collectionName: 'Clinic',
                    ),
              body: Center(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 6,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 8,
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Number of Students',
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    'at clinic:',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Center(
                                      child: Text(
                                    '$liveCases',
                                    style: TextStyle(
                                        fontSize: 100,
                                        color: Color(0xff4DD172)),
                                  ))
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                color: Color(0xfff2f9f3),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    EmergencyWarning(
                      liveCases: liveCases,
                      cap: cap,
                    ),
                    Expanded(
                      flex: 4,
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}

class EmergencyWarning extends StatelessWidget {
  final int liveCases;
  final int cap;
  EmergencyWarning({@required this.liveCases, @required this.cap});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: liveCases < cap
          ? Container()
          : Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'CLINIC LIMIT REACHED',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        Text('Add only If emergency',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ))
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      color: Colors.red[400],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
              ],
            ),
    );
  }
}
