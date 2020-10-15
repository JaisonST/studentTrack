import 'package:flutter/material.dart';
import 'package:studenttrack/DatabaseServices/Database_Live.dart';
import 'package:studenttrack/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:studenttrack/Screens/Loading.dart';

class ClinicUI extends StatefulWidget {
  final String schoolDB;
  final String collectionName;
  ClinicUI({@required this.schoolDB,@required this.collectionName});
  @override
  _ClinicUIState createState() => _ClinicUIState();
}

class _ClinicUIState extends State<ClinicUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      floatingActionButton: ClinicAddButton(schoolDB: widget.schoolDB,collectionName: widget.collectionName,),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Schools')
              .doc(widget.schoolDB)
              .collection(widget.collectionName)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Loading();
            } else {
              if (snapshot.data.documents.length == 0) {
                return Center(
                  child: Text(
                    'There are no Cases right now',
                    style: TextStyle(fontSize: 20.0),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot student = snapshot.data.documents[index];

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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      "Do you want to Archive ${student.data()["Name"]}'s record",
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        'ARCHIVE',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                      ),
                                      color: Color(0xff4DD172),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        await DatabaseLive(
                                                schoolDB: widget.schoolDB,collectionName: widget.collectionName)
                                            .moveRecordFromLiveToHistory(
                                                student.id);
                                      },
                                    )
                                  ],
                                ).show();
                              },
                              elevation: 1,
                              fillColor: Colors.white,
                              child: Icon(
                                Icons.folder,
                                size: 35.0,
                                color: Colors.grey,
                              ),
                              padding: EdgeInsets.all(15.0),
                              shape: CircleBorder(),
                            )
                          ],
                        ),
                      );
                    });
              }
            }
          }),
    );
  }
}
