import 'package:flutter/material.dart';
import 'package:studenttrack/DatabaseServices/Database_History.dart';
import 'package:studenttrack/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:studenttrack/DatabaseServices/Database_Emergency.dart';
import 'package:studenttrack/Screens/Loading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'ConfigUI.dart';

class AdminUI extends StatefulWidget {
  final String schoolDB;
  AdminUI({this.schoolDB});
  @override
  _AdminUIState createState() => _AdminUIState();
}

class _AdminUIState extends State<AdminUI> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Schools')
              .doc(widget.schoolDB)
              .collection('Emergency')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Loading();
            } else {
              return Column(
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: snapshot.data.documents.length == 0
                        ? Center(
                            child: Text(
                              'There are no Emergency Cases right now',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          )
                        : ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot student =
                                  snapshot.data.documents[index];

                              return Container(
                                decoration: BoxDecoration(
                                  color: Color(0xfff2f9f3),
                                  border: Border(
                                    top: BorderSide(
                                      width: 2.0,
                                      color: Color(0xff4DD172),
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 20.0),
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 10, top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${student.data()["Name"]}',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Color(0xff4DD172),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${student.data()["Class"]}',
                                        ),
                                      ],
                                    ),
                                    RawMaterialButton(
                                      onPressed: () {
                                        Alert(
                                          context: context,
                                          title: "Confirmation",
                                          desc:
                                              "Do you want to Delete ${student.data()["Name"]}'s record",
                                          buttons: [
                                            DialogButton(
                                              child: Text(
                                                'DELETE',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0),
                                              ),
                                              color: Colors.red,
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                await DatabaseEmergency(
                                                        schoolDB: widget.schoolDB)
                                                    .deleteRecord(student.id);
                                              },
                                            )
                                          ],
                                        ).show();
                                      },
                                      elevation: 1,
                                      fillColor: Colors.white,
                                      child: Icon(
                                        Icons.delete_forever,
                                        size: 35.0,
                                        color: Colors.red,
                                      ),
                                      padding: EdgeInsets.all(15.0),
                                      shape: CircleBorder(),
                                    )
                                  ],
                                ),
                              );
                            }),
                  ),
                  Expanded(
                    flex: 2,
                    child: PrintContainer(
                      description: 'App Configuration',
                      schoolDB: widget.schoolDB,
                      color: Color(0xff4DD172),
                      title: 'Config',
                      fn: 'Config',
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: PrintContainer(
                      description: 'Want to Print database?',
                      schoolDB: widget.schoolDB,
                      color: Colors.pinkAccent,
                      title: 'Print',
                      fn: 'Print',
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}

class PrintContainer extends StatelessWidget {
  PrintContainer(
      {@required this.description,
      this.schoolDB,
      this.color,
      this.title,
      this.fn});
  String schoolDB;
  String description;
  Color color;
  String title;
  String fn;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      margin: EdgeInsets.all(15),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 7,
              child: Text(
                description,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            Expanded(
              flex: 3,
              child: FlatButton(
                child: Text('$title'),
                onPressed: () async {
                  if (fn == 'Print') {
                    if (await Permission.storage.isGranted) {
                      recordDateForm(context, DateTime.now(), schoolDB);
                    } else {
                      await Permission.storage.request().then((value) =>
                          recordDateForm(context, DateTime.now(), schoolDB));
                    }
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfigUI(
                          schoolDB: schoolDB,
                        ),
                      ),
                    );
                  }
                },
                color: Colors.white,
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: 5.0,
              ),
            )
          ]),
    );
  }
}
