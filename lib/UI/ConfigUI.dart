import 'package:flutter/material.dart';
import 'package:studenttrack/UI/EmailSetup.dart';
import 'package:studenttrack/DatabaseServices/Database_Admin.dart';
import 'package:studenttrack/UI/WashroomSetup.dart';
import 'package:studenttrack/UI/RoomSetup.dart';

class ConfigUI extends StatefulWidget {
  final String schoolDB;

  ConfigUI({@required this.schoolDB});
  @override
  _ConfigUIState createState() => _ConfigUIState();
}

class _ConfigUIState extends State<ConfigUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4DD172),
        title: Text(
          "CONFIGURATION",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 2,
            child: ConfigChoice(
              display: "Edit Emergency Emails",
              fn: () {
                DatabaseAdmin(schoolDB: widget.schoolDB)
                    .getRecipientList()
                    .then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmailSetup(
                        emails: value,
                        schoolDB: widget.schoolDB,
                      ),
                    ),
                  );
                });
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: ConfigChoice(
              display: "Set Up Washrooms",
              fn: () {
                DatabaseAdmin(schoolDB: widget.schoolDB)
                    .returnWashroomList()
                    .then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WashroomSetup(
                        washrooms: value,
                        schoolDB: widget.schoolDB,
                      ),
                    ),
                  );
                });
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: ConfigChoice(
              display: "Set Up Rooms",
              fn: () {
                DatabaseAdmin(schoolDB: widget.schoolDB)
                    .returnRoomList()
                    .then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoomSetup(
                        rooms: value,
                        schoolDB: widget.schoolDB,
                      ),
                    ),
                  );
                });
              },
            ),
          ),
          Expanded(
            flex: 5,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}

class ConfigChoice extends StatelessWidget {
  final String display;
  final Function fn;
  ConfigChoice({@required this.display, this.fn});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
        onPressed: fn,
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Text(
                display,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 1,
              child: Icon(Icons.build, color: Colors.white),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xff4DD172),
      ),
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    );
  }
}
