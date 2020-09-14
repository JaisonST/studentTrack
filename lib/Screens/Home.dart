import 'package:flutter/material.dart';
import 'package:studenttrack/components.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return TeacherUI();
  }
}

class TeacherUI extends StatefulWidget {
  @override
  _TeacherUIState createState() => _TeacherUIState();
}

class _TeacherUIState extends State<TeacherUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
              onPressed: () {},
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
      ),
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        child: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 40.0,
          ),
          backgroundColor: Color(0xff4DD172),
          onPressed: () {
            clinicForm(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: SizedBox(),
            ),
            Expanded(
              flex: 6,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Number of Students',
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'at clinic:',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Center(
                            child: Text(
                              '#',
                              style: TextStyle(
                                fontSize: 100.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        color: Color(0xfff2f9f3),
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
            Expanded(
              flex: 4,
              child: SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
