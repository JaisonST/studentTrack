import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'package:studenttrack/components.dart';

class DatabaseHistory {
  File f;
  String directory;
  String schoolDB;
  Future<void> getCSV({DateTime date,String schoolDB}) async {
    Platform.isIOS
        ? directory = (await getApplicationDocumentsDirectory()).path
        : directory = (await getExternalStorageDirectory()).path;
    f = File(directory + '/Records.csv');
    print(directory);

    List<List<dynamic>> rows = List<List<dynamic>>();
    rows.add(['Name', 'Class', 'Time of Entry', 'Time of Exit', 'Index']);

    var cloud = FirebaseFirestore.instance.collection('Schools').doc(schoolDB).collection('History');

    await cloud.get().then((QuerySnapshot snapshot) {
      List<dynamic> row = List<dynamic>();
      snapshot.docs.forEach((doc) {
        row = [];
        Timestamp t = doc.data()['Index'];
        DateTime recordDate = t.toDate();
        if (!recordDate.difference(date).isNegative) {
          row.add(doc.data()['Name']);
          row.add(doc.data()['Class']);
          row.add(doc.data()['EntryTime']);
          row.add(doc.data()['ExitTime']);
          row.add(doc.data()['Index'].millisecondsSinceEpoch);
          rows.add(row);
        }
      });
    });

    print(rows);

    int i, j;
    List<dynamic> temp = [];
    for (i = 1; i < rows.length; ++i) {
      j = i;
      while (j > 1 && rows[j - 1][4] > rows[j][4]) {
        temp = rows[j];
        rows[j] = rows[j - 1];
        rows[j - 1] = temp;
      }
    }

    for (i = 0; i < rows.length; ++i) {
      rows[i].removeAt(4);
    }
    print('SORTED = ');
    print(rows);

    String csv = ListToCsvConverter().convert(rows);

    f.writeAsString(csv).then((value) => uploadFile(f));
  }
}

uploadFile(File record) async {
  StorageReference storageFirebase = FirebaseStorage.instance
      .ref()
      .child('History_xls/StudentTrackRecord.csv');
  StorageUploadTask uploadTask = storageFirebase.putFile(record);

  String uploadedFileURL =
      await (await uploadTask.onComplete).ref.getDownloadURL();
  print(uploadedFileURL);
  openUrl(uploadedFileURL);
}

openUrl(String url) {
  launch(url);
}

/////////////////////////////////////////////////////////////////////////
// this segment of code pulls up the alert
recordDateForm(context, DateTime setDate,String schoolDB) {
  Alert(
      context: context,
      title: 'Print Record',
      desc: 'Choose date of oldest Record',
      content: Column(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Row(children: <Widget>[
            Expanded(
                flex: 3,
                child: PickerFormat(
                  localText: '${setDate.day}-${setDate.month}-${setDate.year}',
                  pickerFunction: () => selectedDate(context, setDate,schoolDB),
                )),
          ]),
        ],
      ),
      buttons: [
        DialogButton(
          color: Colors.pinkAccent,
          onPressed: () async {
            Navigator.pop((context));
            await DatabaseHistory().getCSV(date: setDate,schoolDB: schoolDB);
          },
          child: Text(
            "SUBMIT",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}

Future<Null> selectedDate(BuildContext context, DateTime setDate,String schoolDB) async {
  await showDatePicker(
          context: context,
          initialDate: setDate,
          firstDate: DateTime(2020),
          lastDate: DateTime.now())
      .then((picked) {
    if (picked != null && picked != setDate) {

      setDate = picked;
      Navigator.pop(context);
      recordDateForm(context, setDate,schoolDB);
    }
  });
}

// alert
///////////////////////////////////////////////////////////////////////////
