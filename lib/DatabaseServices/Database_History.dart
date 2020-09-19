
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHistory{

  void getCSV() async {


    List<List<dynamic>> rows = List<List<dynamic>>();
    rows.add([
      'Name',
      'Class',
      'Time of Entry'
          'Time of Exit'
    ]);

    var cloud = FirebaseFirestore.instance.collection('History');



    await cloud.get().then((QuerySnapshot snapshot){
      List<dynamic> row= List<dynamic>();
      snapshot.docs.forEach((doc) {
        row.clear();
        row.add(doc.data()['Name']);
        row.add(doc.data()['Class']);
        row.add(doc.data()['TimeOfEntry']);
        row.add(doc.data()['TimeOfExit']);
      });
      rows.add(row);
    });




  }
}

// await live.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
// name = documentSnapshot.data()['Name'];
// grade = documentSnapshot.data()['Class'];
// t = documentSnapshot.data()['EntryTime'];
// });