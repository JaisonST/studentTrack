import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

//function for the clinic form
clinicForm(context) {
  Alert(
      context: context,
      title: "Clinic Form",
      content: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.account_circle),
              labelText: 'Student Name',
            ),
          ),
          TextField(
            obscureText: true,
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
          onPressed: () => Navigator.pop(context),
          child: Text(
            "SUBMIT",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
