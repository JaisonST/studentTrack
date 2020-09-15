import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time/time.dart';

class DatabaseServices {
  final String uid;
  DatabaseServices({this.uid});

  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');
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

  Future<String> returnDesignation() async {
    String returnValue;
    await users.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
      returnValue = documentSnapshot.data()['Designation'];
    });
    return returnValue;
  }
}
