import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studenttrack/DatabaseServices/Database_Admin.dart';
import 'package:studenttrack/Screens/Loading.dart';
import 'package:studenttrack/components.dart';

class TeacherWashroomUI extends StatefulWidget {
  final String schoolDB;
  final List<dynamic> washroomList;
  TeacherWashroomUI({@required this.schoolDB, this.washroomList});

  @override
  _TeacherWashroomUIState createState() => _TeacherWashroomUIState();
}

class _TeacherWashroomUIState extends State<TeacherWashroomUI> {
  int liveCases = 0;
  int cap = 0;
  String val;
  List<DropdownMenuItem<dynamic>> _items = [];

  List<DropdownMenuItem<dynamic>> buildItems(List<dynamic> washrooms) {
    List<DropdownMenuItem<dynamic>> i2 = List();
    for (dynamic i in washrooms) {
      i2.add(DropdownMenuItem(
          value: i,
          child: Text(
            i.toString(),
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          )));
    }
    return i2;
  }

  @override
  initState() {
    val = widget.washroomList[0];
    _items = buildItems(widget.washroomList);
    DatabaseAdmin(schoolDB: widget.schoolDB).returnCap(val).then((value){
      setState(() {
        cap = value;
      });

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Schools')
            .doc(widget.schoolDB)
            .collection(val)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Loading();
          } else {
            liveCases = snapshot.data.documents.length;
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  "WASHROOM",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: Color(0xff4DD172),
              ),
              floatingActionButton: liveCases >= cap
                  ? FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.add),
                    )
                  : ClinicAddButton(
                      schoolDB: widget.schoolDB,
                      collectionName: val,
                    ),
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            Expanded(
                              flex: 8,
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Color(0xff4DD172),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                      dropdownColor: Colors.grey,
                                      value: val,
                                      items: _items,
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.white,
                                      ),
                                      onChanged: (value) {
                                        setState(() async {
                                          val = value;
                                          cap = await DatabaseAdmin(schoolDB: widget.schoolDB).returnCap(val);
                                        });
                                      }),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                          ],
                        )),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 7,
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
                                    'at $val:',
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
                                    '$liveCases',
                                    style: TextStyle(
                                        fontSize: 100,
                                        color: Color(0xff4DD172)),
                                  ))
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
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
                      flex: 1,
                      child: SizedBox(),
                    ),
                    //EmergencyWarning(liveCases: liveCases),
                    Expanded(
                      flex: 4,
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
