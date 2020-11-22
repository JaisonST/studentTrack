import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:studenttrack/DatabaseServices/Database_Live.dart';
import 'package:studenttrack/components.dart';

class ScanPage extends StatefulWidget {
  static String id = 'ScanPage';
  String localTitle;
  String localDesc;
  Color localColor;
  String schoolDB;
  String collectionName;

  ScanPage({@required this.localDesc,@required this.collectionName,@required this.localColor,@required this.localTitle,@required this.schoolDB});
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String _qrInfo = '';
  bool _camState = false;

  _qrCallback(String code){
    setState((){
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
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  color: Color(0xff4DD172),
                  onPressed: () async {

                    await clinicForm(context, widget.localTitle, widget.localDesc, widget.localColor, widget.schoolDB, widget.collectionName);

                  },
                )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Card'),
      ),
      body: _camState
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: SizedBox(
                        height: 700,
                        width: 500,
                        child: QRBarScannerCamera(
                          onError: (context, error) => Text(
                            error.toString(),
                            style: TextStyle(color: Colors.red),
                          ),
                          qrCodeCallback: (code) async {
                            _qrCallback(code);
                            await DatabaseLive(schoolDB: widget.schoolDB, collectionName: widget.collectionName).scanAddRecordToLive(code);
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            _cameraControlWidget(context),
                          ],
                        ),
                      ),
                    ),
                  )
                ])
          : Center(
              child: Text(_qrInfo),
            ),
    );
  }
}