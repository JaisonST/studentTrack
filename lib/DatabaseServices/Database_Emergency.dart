import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseEmergency {


  String schoolDB;
  DatabaseEmergency({this.schoolDB});





  Future addRecordToEmergency(String name, String grade,doc_id) {
    var  emergency = FirebaseFirestore.instance.collection('Schools').doc(schoolDB).collection('Emergency');
    return emergency
        .add({'Name': name, 'Class': grade, 'EntryTimeOfLog': DateTime.now(), 'ID':doc_id})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<bool> scanAddRecordToEmergency(String doc_id) async{
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
      await addRecordToEmergency(name, grade,doc_id);
    }

    return found;
  }

  deleteRecord(String uid) async {
    print(uid);
    var  emergency = FirebaseFirestore.instance.collection('Schools').doc(schoolDB).collection('Emergency');

    await emergency
        .doc(uid)
        .delete()
        .then((value) => print("User deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}



