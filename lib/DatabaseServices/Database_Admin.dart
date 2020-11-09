import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseAdmin {
  String schoolDB;

  DatabaseAdmin({this.schoolDB});

  Future<List<dynamic>> getRecipientList() async {
    var admin = FirebaseFirestore.instance
        .collection('Schools')
        .doc(schoolDB)
        .collection('Admin')
        .doc('EmailList');
    List<dynamic> recipients = [];
    await admin.get().then((value) {
      recipients = value['Emails'];
    });

    return recipients;
  }

  Future<void> addRecipient(String email) async {
    List<dynamic> emails = await getRecipientList();
    emails.add(email);
    var admin = FirebaseFirestore.instance
        .collection('Schools')
        .doc(schoolDB)
        .collection('Admin');
    await admin
        .doc('EmailList')
        .set({
          'Emails': emails,
        })
        .then((value) => print('Admin Email added'))
        .catchError((error) => print("Failed to add email: $error"));
  }

  Future<void> deleteRecipient(String email) async {
    List<dynamic> emails = await getRecipientList();
    int i;
    for (i = 0; i < emails.length; ++i) {
      if (emails[i] == email) break;
    }
    emails.removeAt(i);
    var admin = FirebaseFirestore.instance
        .collection('Schools')
        .doc(schoolDB)
        .collection('Admin');
    await admin
        .doc('EmailList')
        .set({
          'Emails': emails,
        })
        .then((value) => print('Admin Email deleted'))
        .catchError((error) => print("Failed to delete email: $error"));
  }

  //Washroom List Functions
  Future returnWashroomList() async {
    var admin = FirebaseFirestore.instance
        .collection('Schools')
        .doc(schoolDB)
        .collection('Admin')
        .doc('WashroomList');
    return await admin.get().then((value) {
      return value['Washrooms'];
    });
  }

  Future<void> addToWashroomList(String washroom) async {
    List<dynamic> washroomList = await returnWashroomList();
    washroomList.add(washroom);
    var admin = FirebaseFirestore.instance
        .collection('Schools')
        .doc(schoolDB)
        .collection('Admin');
    return admin.doc('WashroomList').set({
      'Washrooms': washroomList,
    });
  }

  Future<void> deleteFromWashroomList(String washroom) async {
    List<dynamic> washroomList = await returnWashroomList();
    int i;
    for (i = 0; i < washroomList.length; ++i) {
      if (washroom == washroomList[i]) break;
    }
    washroomList.removeAt(i);
    var admin = FirebaseFirestore.instance
        .collection('Schools')
        .doc(schoolDB)
        .collection('Admin');
    return admin.doc('WashroomList').set({
      'Washrooms': washroomList,
    });
  }

  //Rooms List Functions
  Future returnRoomList() async {
    var admin = FirebaseFirestore.instance
        .collection('Schools')
        .doc(schoolDB)
        .collection('Admin')
        .doc('List');
    return await admin.get().then((value) {
      return value['Rooms'];
    });
  }

  Future<void> addToRoomList(String room) async {
    List<dynamic> roomList = await returnRoomList();
    roomList.add(room);
    var admin = FirebaseFirestore.instance
        .collection('Schools')
        .doc(schoolDB)
        .collection('Admin');
    return admin.doc('List').set({
      'Rooms': roomList,
    });
  }

  Future<void> deleteFromRoomList(String washroom) async {
    List<dynamic> washroomList = await returnRoomList();
    int i;
    for (i = 0; i < washroomList.length; ++i) {
      if (washroom == washroomList[i]) break;
    }
    washroomList.removeAt(i);
    var admin = FirebaseFirestore.instance
        .collection('Schools')
        .doc(schoolDB)
        .collection('Admin');
    return admin.doc('List').set({
      'Rooms': washroomList,
    });
  }

  Future<int> returnCap(String collectionName) async {
    var adminCap = FirebaseFirestore.instance
        .collection('Schools')
        .doc(schoolDB)
        .collection('Admin')
        .doc('Cap');

    return await adminCap.get().then((DocumentSnapshot d) {
      return d[collectionName];
    });
  }
}
