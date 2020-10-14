import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseEmergency {


  String schoolDB;
  DatabaseEmergency({this.schoolDB});





  Future addRecordToEmergency(String name, String grade) {
    var  emergency = FirebaseFirestore.instance.collection('Schools').doc(schoolDB).collection('Emergency');
    return emergency
        .add({'Name': name, 'Class': grade, 'EntryTime': DateTime.now()})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  deleteRecord(String uid) async {
    var  emergency = FirebaseFirestore.instance.collection('Schools').doc(schoolDB).collection('Emergency');
    await emergency
        .doc(uid)
        .delete()
        .then((value) => print("User deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}



