

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices{
  final String uid;
  DatabaseServices({this.uid});

  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');

  String returnDesignation(){
    Map<String, dynamic> data;
    FirebaseFirestore.instance.collection('Users').doc(uid).snapshots().listen((snapshot){
       data = snapshot.data();
    });
    return data['Designation'];
  }
}