import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseLive{


  final CollectionReference live =
  FirebaseFirestore.instance.collection('Live');

  Future addRecordToLive(String name, String grade) {
    return live
        .add({
      'Name': name,
      'Class': grade,
      'EntryTime': DateTime.now().toUtc().millisecondsSinceEpoch
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}