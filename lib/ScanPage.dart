import 'package:flutter/material.dart';
import 'package:scan_preview/scan_preview.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scan_preview/scan_preview_widget.dart';
import 'package:studenttrack/DatabaseServices/Database_Emergency.dart';
import 'package:studenttrack/DatabaseServices/Database_Live.dart';
import 'package:studenttrack/Screens/Loading.dart';
import 'package:studenttrack/components.dart';

import 'DatabaseServices/Database_Admin.dart';

class ScanPage extends StatefulWidget {
  static String id = 'ScanPage';
  String localTitle;
  String localDesc;
  Color localColor;
  String schoolDB;
  String collectionName;

  ScanPage(
      {@required this.localDesc,
      @required this.collectionName,
      @required this.localColor,
      @required this.localTitle,
      @required this.schoolDB});
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String _qrInfo = '';
  bool _camState = false;

  _qrCallback(String code) {
    setState(() {
      _camState = false;
      _qrInfo = code;
    });
  }

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _scanCode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _cameraControlWidget(context) {
    return Expanded(
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              RaisedButton(
      child: Text(
              'Enter Details Manually',
              style: TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      color: widget.localColor,
      onPressed: () async {
              await clinicForm(context, widget.localTitle, widget.localDesc,
                  widget.localColor, widget.schoolDB, widget.collectionName);
      },
    ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    bool found = false;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: widget.localColor,
          title: Text(widget.localTitle),
        ),
        body: _camState
            ? Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                Widget>[
                Expanded(
                  flex: 5,
                  child: Center(
                    child: SizedBox(
                      height: 700,
                      width: 500,
                      child: ScanPreviewWidget(
                        onScanResult: (code) async  {
                          debugPrint('scan result: $code');
                          _qrCallback(code);

                          if(widget.localTitle == 'Emergency - Form'){
                            found = await DatabaseEmergency(
                                schoolDB: widget.schoolDB)
                                .scanAddRecordToEmergency(code);

                          }else {
                            found = await DatabaseLive(
                                schoolDB: widget.schoolDB,
                                collectionName: widget.collectionName)
                                .scanAddRecordToLive(code);
                          }
                          print('Found:');
                          print(found);
                          if (found) {
                            await Alert(
                              context: context,
                              title: 'Success',
                              buttons: [
                                DialogButton(
                                    color: Color(0xff4DD172),
                                    child: Text(
                                      'Done',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                              ],
                              style: AlertStyle(
                                  titleStyle: TextStyle(color: Colors.black)),
                            ).show().then((value) => Navigator.pop(context));
                          } else {
                            await Alert(
                              context: context,
                              title: 'Could not find Student record',
                              buttons: [
                                DialogButton(
                                    color: Colors.red,
                                    child: Text(
                                      'Try Again',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                              ],
                              style: AlertStyle(
                                  titleStyle: TextStyle(color: Colors.black)),
                            ).show();
                            setState(() {
                              _camState = true;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        _cameraControlWidget(context),
                      ],
                    ),

                  ),
                )
              ])
            : Loading());
  }
}
