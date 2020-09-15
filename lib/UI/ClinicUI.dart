import 'package:flutter/material.dart';
import 'package:studenttrack/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClinicUI extends StatefulWidget {
  @override
  _ClinicUIState createState() => _ClinicUIState();
}

class _ClinicUIState extends State<ClinicUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      floatingActionButton: ClinicAddButton(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Live').snapshots(),
          builder: (context, snapshot) {
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
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
                          onPressed: () {},
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
          }),
    );
  }
}

//Text('${student.data()["Name"]}'
