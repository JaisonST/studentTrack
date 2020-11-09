import 'package:flutter/material.dart';

class ContactUI extends StatefulWidget {
  @override
  _ContactUIState createState() => _ContactUIState();
}

class _ContactUIState extends State<ContactUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f9f3),
      appBar: AppBar(
        backgroundColor: Color(0xff4dd172),
        title: Text('Contact Us'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 2,
              child: Text(
                "Hey, we are a closed app although if interested in creating a system at your organization please contact us at:",
                style: TextStyle(
                  color: Color(0xff4dd172),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              flex: 6,
              child: Image.asset("images/icon.png"),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff4dd172),
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Icon(
                          Icons.mail,
                          color: Colors.white,
                          size: 25.0,
                        )),
                    Expanded(
                      flex: 5,
                      child: Text(
                        "studenttrackteam@gmail.com",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff4dd172),
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 25.0,
                        )),
                    Expanded(
                      flex: 5,
                      child: Text(
                        "+971529906429",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
