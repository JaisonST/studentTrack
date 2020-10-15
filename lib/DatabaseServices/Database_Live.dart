import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:studenttrack/DatabaseServices/Database_Admin.dart';

class DatabaseLive {
  String schoolDB;
  String collectionName;

  DatabaseLive({this.schoolDB,this.collectionName});
  //Wrapper Functions

  void createNewLocation(String description) async {
    var live = FirebaseFirestore.instance.collection('Schools').doc(schoolDB);

    await live.collection(collectionName).doc('Details').set({
      'Description': description,
    });
  }

  void deleteLocation() async {
    var live = FirebaseFirestore.instance.collection('Schools').doc(schoolDB);

    await live.collection(collectionName).get().then((QuerySnapshot){
      for(DocumentSnapshot d in QuerySnapshot.docs){
        d.reference.delete();
      }
    });
  }

  //Washroom Functions
  void createNewWashroom(String description) async {
    var live = FirebaseFirestore.instance.collection('Schools').doc(schoolDB);
    DatabaseAdmin(schoolDB: schoolDB).addToWashroomList(collectionName);
    await live.collection(collectionName).doc('Details').set({
      'Description': description,
    });
  }

  void deleteWashroom() async {
    var live = FirebaseFirestore.instance.collection('Schools').doc(schoolDB);
    DatabaseAdmin(schoolDB: schoolDB).deleteFromWashroomList(collectionName);
    await live.collection(collectionName).get().then((QuerySnapshot){
      for(DocumentSnapshot d in QuerySnapshot.docs){
        d.reference.delete();
      }
    });
  }
  //Live Functions

  Future addRecordToLive(String name, String grade) {
    var live = FirebaseFirestore.instance.collection('Schools').doc(schoolDB).collection(collectionName);
    return live
        .add({
      'Name': name,
      'Class': grade,
      'EntryTime': DateTime.now().toString(),
      'Location': collectionName,
      'Index': DateTime.now()
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future addRecordToHistory(String name, String grade, String t, Timestamp d) {
    var history = FirebaseFirestore.instance
        .collection('Schools')
        .doc(schoolDB)
        .collection('History');
    return history
        .add({
      'Name': name,
      'Class': grade,
      'EntryTime': t,
      'ExitTime': DateTime.now().toString(),
      'Location': collectionName,
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
    var live = FirebaseFirestore.instance.collection('Schools').doc(schoolDB).collection(collectionName);
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


}
