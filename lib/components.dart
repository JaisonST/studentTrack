import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:studenttrack/AuthenticationSystem/Auth.dart';
import 'package:studenttrack/DatabaseServices/Database_Live.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

//function for the clinic form
clinicForm(context, String localTitle, String localDesc, Color localColor) {
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
            if (localTitle == 'Emergency - Form') {
              String email = 'jaisonmanu@gmail.com';
              String subject = 'Emergency Case';
              String body =
                  'Sir/Madam,\nThis is to inform you that $studentName of class $studentClass is in dire need of visiting the clinic, however the clinic has too many patients at the moment. Please do the needful.\n\nYours sincerely,\nStudent Track\n\n\nNote: This message was computer generated, Do not reply to this email.';

              sendMail(email: email, subject: subject, body: body)
                  .then((value) => Navigator.pop(context));
            } else {
              DatabaseLive()
                  .addRecordToLive(studentName, studentClass)
                  .then((value) => Navigator.pop(context));
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
          clinicForm(context, 'Clinic Form', 'Please Fill in Details',
              Color(0xff4DD172));
        },
      ),
    );
  }
}

class EmergencyAddButton extends StatelessWidget {
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
          clinicForm(context, 'Emergency - Form',
              'Alert will be sent to MSO team', Colors.red);
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

sendMail({@required String email, String subject, String body}) async {
  String username = 'studenttrack.ois@gmail.com';
  String password = 'jaisonjoelsanath';

  final smtpServer = gmail(username, password);

  // Create our message.
  final message = Message()
    ..from = Address(username, 'Student Track')
    ..recipients.add(email)
    ..subject = subject
    ..text = body;

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
