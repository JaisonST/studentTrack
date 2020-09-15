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

                  return new Text('${student.data()["Name"]}');
                });
          }),
    );
  }
}
