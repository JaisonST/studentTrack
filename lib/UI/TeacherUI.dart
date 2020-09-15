import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studenttrack/components.dart';

class TeacherUI extends StatefulWidget {
  @override
  _TeacherUIState createState() => _TeacherUIState();
}

class _TeacherUIState extends State<TeacherUI> {
  int liveCases = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Live').snapshots(),
        builder: (context, snapshot) {
          liveCases = snapshot.data.documents.length;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: HomeAppBar(),
            floatingActionButton:
                liveCases >= 4 ? EmergencyAddButton() : ClinicAddButton(),
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
                                      fontSize: 100, color: Color(0xff4DD172)),
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
                  EmergencyWarning(liveCases: liveCases),
                  Expanded(
                    flex: 4,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class EmergencyWarning extends StatelessWidget {
  final int liveCases;
  EmergencyWarning({@required this.liveCases});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: liveCases < 4
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
                    padding: EdgeInsets.only(top: 15.0),
                    child: Column(
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
