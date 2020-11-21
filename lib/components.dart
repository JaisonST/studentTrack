import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:studenttrack/AuthenticationSystem/Auth.dart';
import 'package:studenttrack/DatabaseServices/Database.dart';
import 'package:studenttrack/DatabaseServices/Database_Admin.dart';
import 'package:studenttrack/DatabaseServices/Database_Emergency.dart';
import 'package:studenttrack/DatabaseServices/Database_Live.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:studenttrack/ScanPage.dart';

//function for the clinic form
clinicForm(context, String localTitle, String localDesc, Color localColor,
    String schoolDB, String collectionName) {
  String studentName;
  String studentClass;
  Alert(
      context: context,
      title: localTitle,
      desc: localDesc,
      content: Column(
        children: <Widget>[
          TextField(
            onChanged: (value) {
              studentName = value;
            },
            decoration: InputDecoration(
              icon: Icon(Icons.account_circle),
              labelText: 'Student Name',
            ),
          ),
          TextField(
            onChanged: (value) {
              studentClass = value;
            },
            decoration: InputDecoration(
              icon: Icon(Icons.book),
              labelText: 'Class',
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          color: localColor,
          onPressed: () async {
            if (studentName == null || studentClass == null) {
              Alert(
                context: context,
                title: 'Please Fill in All values',
                buttons: [],
                style: AlertStyle(titleStyle: TextStyle(color: Colors.red)),
              ).show();
            } else {
              if (localTitle == 'Emergency - Form') {
                List<dynamic> emails =
                    await DatabaseAdmin(schoolDB: schoolDB).getRecipientList();
                print(emails);
                String subject = 'Emergency Case';
                String body =
                    'Sir/Madam,\nThis is to inform you that $studentName of class $studentClass is in dire need of visiting the clinic, however the clinic has too many patients at the moment. Please do the needful.\n\nYours sincerely,\nStudent Track\n\n\nNote: This message was computer generated, Do not reply to this email.';
                Navigator.pop((context));
                sendMail(
                    emails: emails, subject: subject, body: body, attach: null);
                DatabaseEmergency(schoolDB: schoolDB)
                    .addRecordToEmergency(studentName, studentClass);
              } else {
                Navigator.pop((context));
                DatabaseLive(schoolDB: schoolDB, collectionName: collectionName)
                    .addRecordToLive(studentName, studentClass);
              }
            }
          },
          child: Text(
            "SUBMIT",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}

//Clinic Button to add the form made here
class ClinicAddButton extends StatelessWidget {
  final schoolDB;
  final collectionName;
  ClinicAddButton({@required this.schoolDB, this.collectionName});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      width: 70.0,
      child: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 40.0,
        ),
        backgroundColor: Color(0xff4DD172),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScanPage(),
            ),
          );
          //clinicForm(context, '$collectionName', 'Please Fill in Details',Color(0xff4DD172), schoolDB, collectionName);
        },
      ),
    );
  }
}

class EmergencyAddButton extends StatelessWidget {
  final schoolDB;
  final collectionName;
  EmergencyAddButton({@required this.schoolDB, this.collectionName});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      width: 70.0,
      child: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 40.0,
        ),
        backgroundColor: Colors.red,
        onPressed: () {
          clinicForm(
              context,
              'Emergency - Form',
              'Alert will be sent to MSO team',
              Colors.red,
              schoolDB,
              collectionName);
        },
      ),
    );
  }
}

//App bar used in TeacherUi and ClinicUI
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            color: Color(0xff4dd172),
            child: Text(
              'Sign Out',
              style: TextStyle(color: Colors.white),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            onPressed: () {
              AuthServices().signOut(context);
            },
          ),
        ),
      ],
      centerTitle: false,
      backgroundColor: Colors.white, //Color(0xff4DD172),
      title: Row(
        children: <Widget>[
          Text(
            'Student',
            style: TextStyle(
                color: Color(0xff4DD172),
                fontWeight: FontWeight.bold,
                fontSize: 30.0),
          ),
          Text(
            'Track',
            style: TextStyle(
              color: Colors.grey[400],
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}

sendMail(
    {@required List<dynamic> emails,
    String subject,
    String body,
    List<Attachment> attach}) async {
  String username = 'studenttrackteam@gmail.com';
  String password = '';

  password = await DatabaseServices(uid: 'Admin').returnPass();

  final smtpServer = gmail(username, password);

  // Create our message.
  final message = Message()
    ..from = Address(username, 'Student Track')
    ..recipients.addAll(emails)
    ..subject = subject
    ..text = body
    ..attachments = attach;

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent. \n: $e');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}

//Date pciker Format
class PickerFormat extends StatelessWidget {
  PickerFormat({@required this.localText, this.pickerFunction});

  final Function pickerFunction;
  final String localText;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: pickerFunction,
      child: Text(
        localText,
        style: TextStyle(color: Colors.white),
      ),
      fillColor: Colors.pinkAccent,
      constraints: BoxConstraints(minHeight: 50.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
    );
  }
}

class HomeAppBarWithBack extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  final Function backBuild;
  HomeAppBarWithBack({@required this.backBuild});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            color: Color(0xff4dd172),
            child: Text(
              'Sign Out',
              style: TextStyle(color: Colors.white),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            onPressed: () {
              AuthServices().signOut(context);
            },
          ),
        ),
      ],
      centerTitle: false,
      backgroundColor: Colors.white, //Color(0xff4DD172),
      title: Row(
        children: <Widget>[
          Icon(Icons.arrow_back_ios),
          Text(
            'Student',
            style: TextStyle(
                color: Color(0xff4DD172),
                fontWeight: FontWeight.bold,
                fontSize: 30.0),
          ),
          Text(
            'Track',
            style: TextStyle(
              color: Colors.grey[400],
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}
