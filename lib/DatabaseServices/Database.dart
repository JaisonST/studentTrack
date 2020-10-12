import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String uid;
  DatabaseServices({this.uid});

  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  Future<String> returnDesignation() async {
    String returnValue;
    await users.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
      returnValue = documentSnapshot.data()['Designation'];
    });
    return returnValue;
  }

  Future<String> returnDB() async {
    String returnValue;
    await users.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
      returnValue = documentSnapshot.data()['DB'];
    });
    return returnValue;
  }

  Future<String> returnPass() async {
    String pass;
    await users.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
      pass = documentSnapshot.data()['Pass'];
    });
    return pass;
  }
}
