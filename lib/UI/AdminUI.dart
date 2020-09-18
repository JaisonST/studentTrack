import 'package:flutter/material.dart';
import 'package:studenttrack/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:studenttrack/DatabaseServices/Database_Live.dart';
import 'package:studenttrack/Screens/Loading.dart';

class AdminUI extends StatefulWidget {
  @override
  _AdminUIState createState() => _AdminUIState();
}

class _AdminUIState extends State<AdminUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Live').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Loading();
            } else {
              return Column(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: ListView.builder(
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
                                            await DatabaseLive()
                                                .deleteRecord(student.id)
                                                .then((value) =>
                                                    Navigator.pop(context));
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
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.all(15),
                        color: Colors.pinkAccent,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Do you want to Print database?',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              FlatButton(
                                child: Text('Print'),
                                onPressed: () {},
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5.0,
                              )
                            ]),
                      )),
                ],
              );
            }
          }),
    );
  }
}