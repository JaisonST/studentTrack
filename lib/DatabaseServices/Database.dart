import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String uid;
  DatabaseServices({this.uid});

  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  Future<void> createUser(String schoolDB, String collectionName) async {
    await users.doc(uid).set({
      'DB': schoolDB,
      'Designation': collectionName,
    });
  }

  Future<String> returnDesignation() async {
    String returnValue;
    try {
      await users.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
        returnValue = documentSnapshot.data()['Designation'];
      });
    } catch (e) {
      print(e);
      returnValue = null;
    }
    return returnValue;
  }

  Future<String> returnDB() async {
    String returnValue;
    try {
      await users.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
        returnValue = documentSnapshot.data()['DB'];
      });
    } catch (e) {
      returnValue = null;
    }
    return returnValue;
  }

  Future<String> returnPass() async {
    String pass;
    await users.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
      pass = documentSnapshot.data()['Pass'];
    });
    return pass;
  }

  Future<int> returnVersion() async {
    return await users.doc('Admin').get().then((DocumentSnapshot d) {
      return d['Version'];
    });
  }
}
