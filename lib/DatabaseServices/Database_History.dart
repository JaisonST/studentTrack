import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';

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
  }
}

uploadFile(File record) async {
  StorageReference storageFirebase =
      FirebaseStorage.instance.ref().child('History_xls/StudentTrackRecord.csv');
  StorageUploadTask uploadTask = storageFirebase.putFile(record);

  String uploadedFileURL =
      await (await uploadTask.onComplete).ref.getDownloadURL();
  print(uploadedFileURL);
  openUrl(uploadedFileURL);
}

openUrl(String url) {
  launch(url);
}
