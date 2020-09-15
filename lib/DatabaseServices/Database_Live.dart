import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseLive{


  final CollectionReference live = FirebaseFirestore.instance.collection('Live');


  Future addRecordToLive(String name, String grade) {
    // increaseCount();
    return live
        .add({
      'Name': name,
      'Class': grade,
      'EntryTime': DateTime.now()
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

   // void increaseCount() async {
   //  int count = 0;
   //  await live.doc('Count').get().then((DocumentSnapshot documentSnapshot){
   //    count = documentSnapshot.data()['NumberOfDocuments'];
   //  });
   //  ++count;
   //   await live.doc('Count').set({
   //     'NumberOfDocuments':count,
   //   });
   // }



  Future<int> get numLive  {
    return live.snapshots().length;
  }




}