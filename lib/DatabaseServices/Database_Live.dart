import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseLive {
  final String schoolDB;
  CollectionReference history;
  CollectionReference live;
  DatabaseLive({@required this.schoolDB}) {
    print(schoolDB);
    live = FirebaseFirestore.instance
        .collection('Schools')
        .doc(schoolDB)
        .collection('LiveC');
    history = FirebaseFirestore.instance
        .collection('Schools')
        .doc(schoolDB)
        .collection('History');
  }

  Future addRecordToLive(String name, String grade) {
    return live
        .add({
          'Name': name,
          'Class': grade,
          'EntryTime': DateTime.now().toString(),
          'Index': DateTime.now()
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future addRecordToHistory(String name, String grade, String t, Timestamp d) {
    return history
        .add({
          'Name': name,
          'Class': grade,
          'EntryTime': t,
          'ExitTime': DateTime.now().toString(),
          'Index': d,
        })
        .then((value) => print('User moved to history'))
        .catchError((error) => print('Failed to move user:$error'));
  }

  Future moveRecordFromLiveToHistory(String uid) async {
    String name;
    String grade;
    String t;
    Timestamp d;
    await live.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
      name = documentSnapshot.data()['Name'];
      grade = documentSnapshot.data()['Class'];
      t = documentSnapshot.data()['EntryTime'];
      d = documentSnapshot.data()['Index'];
    });

    addRecordToHistory(name, grade, t, d);

    return live
        .doc(uid)
        .delete()
        .then((value) => print("User deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  deleteRecord(String uid) async {
    await live
        .doc(uid)
        .delete()
        .then((value) => print("User deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
