import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseEmergency {
  String uid;
  final CollectionReference emergency =
  FirebaseFirestore.instance.collection('Emergency');


  Future addRecordToEmergency(String name, String grade) {
    return emergency
        .add({'Name': name, 'Class': grade, 'EntryTime': DateTime.now()})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  deleteRecord(String uid) async {
    await emergency
        .doc(uid)
        .delete()
        .then((value) => print("User deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}



