
import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseAdmin {
  String schoolDB;

  DatabaseAdmin({this.schoolDB});
  
  Future<List<String>> generateRecipientList() async {
    var admin =  FirebaseFirestore.instance.collection('Schools').doc(schoolDB).collection('Admin');
    List<String> recipients = [];
    await admin.get().then((QuerySnapshot){
      QuerySnapshot.docs.forEach((member) {
        recipients.add(member['Email']);
      });
    });
    return recipients;
  }
  
  void addRecipient(String email) async {
    var admin =  FirebaseFirestore.instance.collection('Schools').doc(schoolDB).collection('Admin');
    await admin.add({
      'Email': email,
    }).then((value) => print('Admin Email added')).catchError((error) => print("Failed to add user: ${error}"));
  }
  
  void deleteRecipient(String uid) async {
    var admin =  FirebaseFirestore.instance.collection('Schools').doc(schoolDB).collection('Admin');
    await admin.doc(uid).delete().then((value) => print('Admin Email Deleted')).catchError((error) => print("Failed to delete user: ${error}"));
  }
  
}
