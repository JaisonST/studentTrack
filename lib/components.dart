import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:studenttrack/AuthenticationSystem/Auth.dart';
import 'package:studenttrack/DatabaseServices/Database_Live.dart';

//function for the clinic form
clinicForm(context,String str) {
  String studentName;
  String studentClass;
  Alert(
      context: context,
      title: "Clinic Form",
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
          color: Color(0xff4DD172),
          onPressed: () {
            if(str == 'standard') {
              DatabaseLive()
                  .addRecordToLive(studentName, studentClass)
                  .then((value) => Navigator.pop(context));
            }
            else{
              print('Email Sent');
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
          clinicForm(context,'standard');
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
          clinicForm(context,'emergency');
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
