import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:studenttrack/DatabaseServices/Database_Admin.dart';

class EmailSetup extends StatefulWidget {
  final List<dynamic> emails;
  final String schoolDB;
  EmailSetup({@required this.emails, this.schoolDB});

  @override
  _EmailSetupState createState() => _EmailSetupState();
}

class _EmailSetupState extends State<EmailSetup> {
  @override
  Widget build(BuildContext context) {
    return SetupUI(
      setupItems: widget.emails,
      schoolDB: widget.schoolDB,
      display: "Email",
    );
  }
}

class SetupUI extends StatelessWidget {
  final List<dynamic> setupItems;
  final String schoolDB;
  final String display;
  SetupUI({@required this.setupItems, this.schoolDB, this.display});

  @override
  Widget build(BuildContext context) {
    String newVal;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$display Setup",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xff4DD172),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 8,
              child: ListView.builder(
                  itemCount: setupItems.length,
                  itemBuilder: (context, index) {
                    //DocumentSnapshot student = snapshot.data.documents[index];

                    return Container(
                      decoration: BoxDecoration(
                        color: Color(0xfff2f9f3),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10.0),
                      margin: EdgeInsets.only(bottom: 10, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '${setupItems[index]}',
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Color(0xff4DD172),
                                fontWeight: FontWeight.bold),
                          ),
                          RawMaterialButton(
                            onPressed: () {
                              Alert(
                                context: context,
                                title: "Confirmation",
                                desc:
                                    "Do you want to delete ${setupItems[index]}",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20.0),
                                    ),
                                    color: Color(0xff4DD172),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      DatabaseAdmin(schoolDB: schoolDB);
                                    },
                                  )
                                ],
                              ).show();
                            },
                            elevation: 1,
                            fillColor: Colors.white,
                            child: Icon(
                              Icons.delete_outline,
                              size: 35.0,
                              color: Colors.red,
                            ),
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: MaterialButton(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.pinkAccent,
                  onPressed: () {
                    Alert(
                      context: context,
                      title: "Add $display",
                      content: TextField(
                        onChanged: (value) {
                          newVal = value;
                        },
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.account_circle,
                            color: Color(0xff4DD172),
                          ),
                          labelText: 'Enter $display',
                        ),
                      ),
                      buttons: [
                        DialogButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "ADD",
                            style: TextStyle(color: Color(0xff4DD172)),
                          ),
                          color: Color(0xfff2f9f3),
                        )
                      ],
                    ).show();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add $display",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
