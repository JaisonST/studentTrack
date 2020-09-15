import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time/time.dart';

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
}
