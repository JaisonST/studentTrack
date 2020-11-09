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
            body: Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 50.0, 30.0, 20.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Expanded(flex: 1, child: SizedBox()),
                    Expanded(flex: 5, child: StudentTrackTitle()),
                    Expanded(flex: 2, child: SizedBox(height: 60.0)),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
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
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
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
                    ),
                    Expanded(flex: 2, child: SizedBox()),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
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
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(error,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.italic)),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        child: Container(
                          color: Color(0xff4dd172),
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "If you don't have an accoount please:",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: SizedBox(),
                              ),
                              Expanded(
                                child: MaterialButton(
                                  child: Text(
                                    'Click Here',
                                    textAlign: TextAlign.center,
                                  ),
                                  color: Colors.white,
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ));
  }
}

class StudentTrackTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text('Student',
              style: TextStyle(
                fontSize: 70.0,
                fontWeight: FontWeight.bold,
                color: Color(0xff4dd172),
              )),
        ),
        Expanded(
          flex: 1,
          child: Text('Track',
              style: TextStyle(
                fontSize: 70.0,
                fontWeight: FontWeight.bold,
                color: Color(0xff696969),
              )),
        ),
      ],
    );
  }
}
