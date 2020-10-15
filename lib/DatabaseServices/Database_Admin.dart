
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

  //Washroom List Functions

  Future<List<String>> returnWashroomList() async {
    var admin =  FirebaseFirestore.instance.collection('Schools').doc(schoolDB).collection('Admin').doc('WashroomList');
    return await admin.get().then((value){
      return value['WashroomList'];
    });
  }


  void addToWashroomList(String washroom) async {
    List<String> washroomList = await returnWashroomList();
    washroomList.add(washroom);
    var admin =  FirebaseFirestore.instance.collection('Schools').doc(schoolDB).collection('Admin');
    return admin.doc('WashroomList').set({
      'Washrooms': washroomList,
    });
  }

  void deleteFromWashroomList(String washroom) async {
    List<String> washroomList = await returnWashroomList();
    int i;
    for(i = 0;i<washroomList.length;++i){
      if(washroom == washroomList[i])
              break;
    }
    washroomList.removeAt(i);
    var admin =  FirebaseFirestore.instance.collection('Schools').doc(schoolDB).collection('Admin');
    return admin.doc('WashroomList').set({
      'Washrooms': washroomList,
    });
  }


}
