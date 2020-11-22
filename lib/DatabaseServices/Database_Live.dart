import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studenttrack/AuthenticationSystem/Auth.dart';
import 'package:studenttrack/DatabaseServices/Database_Admin.dart';

class DatabaseLive {
  String schoolDB;
  String collectionName;

  DatabaseLive({this.schoolDB, this.collectionName});
  //Wrapper Functions

  void createNewLocation(String description) async {
    var live = FirebaseFirestore.instance.collection('Schools').doc(schoolDB);

    await live.collection(collectionName).doc('Details').set({
      'Description': description,
    });
  }

  void deleteLocation() async {
    var live = FirebaseFirestore.instance.collection('Schools').doc(schoolDB);

    await live.collection(collectionName).get().then((QuerySnapshot) {
      for (DocumentSnapshot d in QuerySnapshot.docs) {
        d.reference.delete();
      }
    });
  }

  //Washroom Functions
  Future<void> createNewWashroom(int cap) async {
    String username = collectionName + "." + schoolDB + "@strack.com";
    String password = collectionName + "_" + schoolDB; //Default password
    var live = FirebaseFirestore.instance.collection('Schools').doc(schoolDB);
    DatabaseAdmin(schoolDB: schoolDB).addToWashroomList(collectionName);

    await AuthServices().createNewUser(
        collectionName, schoolDB, username, password, "Washroom");
    await FirebaseFirestore.instance
        .collection('Schools')
        .doc(schoolDB)
        .collection('Admin')
        .doc('Cap')
        .set({
      collectionName: cap,
    }, SetOptions(merge: true));
  }

  Future<void> deleteWashroom() async {
    AuthServices().deleteUser(collectionName, schoolDB);
    var live = FirebaseFirestore.instance.collection('Schools').doc(schoolDB);
    DatabaseAdmin(schoolDB: schoolDB).deleteFromWashroomList(collectionName);
    await live.collection(collectionName).get().then((QuerySnapshot) {
      for (DocumentSnapshot d in QuerySnapshot.docs) {
        d.reference.delete();
      }
      FirebaseFirestore.instance
          .collection('Schools')
          .doc(schoolDB)
          .collection("Admin")
          .doc('Cap')
          .update({collectionName: FieldValue.delete()});
    });
  }

  //Room Functions
  Future<void> createNewRoom(int cap) async {
    String username = collectionName + "." + schoolDB + "@strack.com";
    String password = collectionName + "_" + schoolDB; //Default password
    DatabaseAdmin(schoolDB: schoolDB).addToRoomList(collectionName);
    await AuthServices()
        .createNewUser(collectionName, schoolDB, username, password, "Room");
    await FirebaseFirestore.instance
        .collection('Schools')
        .doc(schoolDB)
        .collection('Admin')
        .doc('Cap')
        .set({
      collectionName: cap,
    }, SetOptions(merge: true));
  }

  Future<void> deleteRoom() async {
    AuthServices().deleteUser(collectionName, schoolDB);
    var live = FirebaseFirestore.instance.collection('Schools').doc(schoolDB);
    DatabaseAdmin(schoolDB: schoolDB).deleteFromRoomList(collectionName);
    await live.collection(collectionName).get().then((QuerySnapshot) {
      for (DocumentSnapshot d in QuerySnapshot.docs) {
        d.reference.delete();
      }
      FirebaseFirestore.instance
          .collection('Schools')
          .doc(schoolDB)
          .collection("Admin")
          .doc('Cap')
          .update({collectionName: FieldValue.delete()});
    });
  }

  //Live Functions
  Future addRecordToLive(String name, String grade,String doc_id) {
    var live = FirebaseFirestore.instance
        .collection('Schools')
        .doc(schoolDB)
        .collection(collectionName);
    return live
        .add({
          'Name': name,
          'Class': grade,
          'EntryTime': DateTime.now().toString(),
          'Location': collectionName,
          'Index': DateTime.now(),
          'ID': doc_id
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future addRecordToHistory(String name, String grade, String t, Timestamp d,String doc_id) {
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
          'ID': doc_id
        })
        .then((value) => print('User moved to history'))
        .catchError((error) => print('Failed to move user:$error'));
  }

  Future moveRecordFromLiveToHistory(String uid) async {
    String name;
    String grade;
    String t;
    Timestamp d;
    String doc_id;
    var live = FirebaseFirestore.instance
        .collection('Schools')
        .doc(schoolDB)
        .collection(collectionName);
    await live.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
      name = documentSnapshot.data()['Name'];
      grade = documentSnapshot.data()['Class'];
      t = documentSnapshot.data()['EntryTime'];
      d = documentSnapshot.data()['Index'];
      doc_id = documentSnapshot.data()['ID'];
    });

    addRecordToHistory(name, grade, t, d,doc_id);

    return live
        .doc(uid)
        .delete()
        .then((value) => print("User deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<bool> scanAddRecordToLive(String doc_id) async{
    var studentData = FirebaseFirestore.instance
        .collection('Schools')
        .doc(schoolDB)
        .collection('StudentData');

    String name;
    String grade;
    bool found = true;

    await studentData.doc(doc_id).get().then((DocumentSnapshot documentSnapshot){
      if (!documentSnapshot.exists) {
        found = false;
      }
      else {
        name = documentSnapshot['Name'];
        grade = documentSnapshot['Class'];
      }
    });

    if(found) {
      await addRecordToLive(name, grade,doc_id);
    }

    return found;
  }
}
