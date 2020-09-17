import 'package:flutter/material.dart';
import 'package:studenttrack/AuthenticationSystem/Auth.dart';
import 'package:studenttrack/Screens/Loading.dart';

class LogIn extends StatefulWidget {
  static String id = "LoginScreen";
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  bool loading = false;
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              titleSpacing: 0.0,
              leading: FlatButton(
                child: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              iconTheme: IconThemeData(
                  color: Color(0xff696969), size: 30.0 //change your color here
                  ),
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Student',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          color: Color(0xff4dd172),
                        )),
                    Text('Track',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          color: Color(0xff696969),
                        ))
                  ]),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 50.0, 30.0, 0.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 40.0),
                      Flexible(child: StudentTrackTitle()),
                      SizedBox(height: 60.0),
                      TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Email Address',
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color(0xff696969),
                                width: 2.0,
                              ))),
                          validator: (val) =>
                              val.isEmpty ? "Enter a valid id" : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          }),
                      SizedBox(height: 10.0),
                      TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Password',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff696969), width: 2.0))),
                          validator: (val) =>
                              val.length < 6 ? 'Password not Valid' : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => password = val);
                          }),
                      SizedBox(height: 30.0),
                      SizedBox(
                        height: 50.0,
                        width: 100.0,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xff4dd172))),
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              if (_formKey.currentState.validate()) {
                                dynamic result = await _auth.signIn(
                                    email, password, context);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error =
                                        'Please enter a valid Email Id and corresponding Password';
                                  });
                                }
                              }
                            },
                            child: Text('Sign In',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0)),
                            color: Color(0xff4dd172)),
                      ),
                      SizedBox(height: 20.0),
                      Text(error,
                          style: TextStyle(
                              color: Colors.black, fontStyle: FontStyle.italic))
                    ],
                  )),
            ));
  }
}

class StudentTrackTitle extends StatelessWidget {
  const StudentTrackTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Student',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 70.0,
              color: Color(0xff4dd172),
            )),
        Text('Track',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 70.0,
              color: Color(0xff696969),
            )),
      ],
    );
  }
}
