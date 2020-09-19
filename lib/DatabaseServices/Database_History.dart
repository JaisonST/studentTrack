
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:mailer/mailer.dart';
import 'package:studenttrack/FileSystem.dart';
import 'dart:io';
import 'package:studenttrack/components.dart';
class DatabaseHistory{

  void getCSV() async {

    FileSystem f;

    List<List<dynamic>> rows = List<List<dynamic>>();
    rows.add([
      'Name',
      'Class',
      'Time of Entry',
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

    String csv = ListToCsvConverter().convert(rows);

     f.writeFile(csv);

    String email = 'joelmathewcherian@gmail.com';
    String subject = 'Records of Patient History';
    String body = 'Dear Sir/Madam,\n Attached below is the record of patient history.\n\nStudent Track Team';






  }
}

