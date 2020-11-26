import 'package:flutter/material.dart';

class ContactUI extends StatefulWidget {
  @override
  _ContactUIState createState() => _ContactUIState();
}

class _ContactUIState extends State<ContactUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Contact Us',
          style: TextStyle(color: Color(0xff4dd172)),
        ),
        elevation: 0.0,
        leading: BackButton(
          color: Color(0xff4dd172),
        ),
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
              flex: 6,
              child: Image.asset("images/icon.png"),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 2,
              child: Text(
                "Hey, we are a closed-system app. Although if interested in creating a system at your organization please contact us at:",
                style: TextStyle(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Icon(
                          Icons.mail,
                          color: Colors.black,
                          size: 25.0,
                        )),
                    Expanded(
                      flex: 5,
                      child: Text(
                        "studenttrackteam@gmail.com",
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
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
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Icon(
                          Icons.phone,
                          color: Colors.black,
                          size: 25.0,
                        )),
                    Expanded(
                      flex: 5,
                      child: Text(
                        "+971529906429",
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
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
