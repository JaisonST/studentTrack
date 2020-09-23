import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'dart:io';
import 'package:studenttrack/components.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseHistory {
  File f;
  String directory;
  void getCSV() async {
    Platform.isIOS
        ? directory = (await getApplicationDocumentsDirectory()).path
        : directory = (await getExternalStorageDirectory()).path;
    f = File(directory + '/Records.csv');
    print(directory);

    List<List<dynamic>> rows = List<List<dynamic>>();
    rows.add(['Name', 'Class', 'Time of Entry', 'Time of Exit']);

    var cloud = FirebaseFirestore.instance.collection('History');

    await cloud.get().then((QuerySnapshot snapshot) {
      List<dynamic> row = List<dynamic>();
      snapshot.docs.forEach((doc) {
        row = [];
        row.add(doc.data()['Name']);
        row.add(doc.data()['Class']);
        row.add(doc.data()['EntryTime']);
        print(doc.data()['Name']);
        row.add(doc.data()['ExitTime']);
        rows.add(row);
      });
    });
    print(rows);
    String csv = ListToCsvConverter().convert(rows);

    f.writeAsString(csv).then((value) => uploadFile(f));

    //  String email = 'joelmathewcherian@gmail.com';
    //  String subject = 'Records of Patient History';
    //  String body = 'Dear Sir/Madam,\n Attached below is the record of patient history.\n\nStudent Track Team';
    //
    //  FileAttachment att = FileAttachment(f);
    //  List<Attachment> att_list = List<Attachment>();
    //  att_list.add(att);
    //
    // await sendMail(email: email,subject: subject,body: body,attach: att_list);
  }
}

uploadFile(File record) async {
  StorageReference storageFirebase =
      FirebaseStorage.instance.ref().child('History_xls/StudentTrackRecord');
  StorageUploadTask uploadTask = storageFirebase.putFile(record);

  String uploadedFileURL =
      await (await uploadTask.onComplete).ref.getDownloadURL();
  print(uploadedFileURL);
}
