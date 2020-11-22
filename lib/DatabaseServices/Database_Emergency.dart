import 'package:cloud_firestore/cloud_firestore.dart';

import '../components.dart';
import 'Database_Admin.dart';

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
      List<dynamic> emails = await DatabaseAdmin(schoolDB: schoolDB).getRecipientList();
      print(emails);
      String subject = 'Emergency Case';
      String body =
          'Sir/Madam,\nThis is to inform you that $name of class $grade is in dire need of visiting the clinic, however the clinic has too many patients at the moment. Please do the needful.\n\nYours sincerely,\nStudent Track\n\n\nNote: This message was computer generated, Do not reply to this email.';

      sendMail(
          emails: emails, subject: subject, body: body, attach: null);
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



