import 'package:flutter/material.dart';
import 'package:studenttrack/AuthenticationSystem/Auth.dart';
import 'package:studenttrack/Screens/Loading.dart';
import 'package:studenttrack/UI/ContactUI.dart';

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
    bool _keyboardIsVisible() {
      if (MediaQuery.of(context).viewInsets.bottom != 0.0) {
        error = "";
      }
      return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
    }

    return loading
        ? Loading()
        : Scaffold(
            body:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              flex: 14,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 50.0, 30.0, 20.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Expanded(flex: 1, child: SizedBox()),
                        _keyboardIsVisible()
                            ? Expanded(
                                flex: 1,
                                child: SizedBox(),
                              )
                            : StudentTrackTitle(),
                        Expanded(flex: 2, child: SizedBox(height: 60.0)),
                        TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Email Address',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
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
                        SizedBox(
                          height: 20,
                        ),
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
                        Expanded(flex: 1, child: SizedBox()),
                        SizedBox(
                          width: 100.0,
                          height: 50.0,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
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
                        Expanded(
                          flex: 1,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: error == "" ? 1 : 2,
                          child: Text(error,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic)),
                        ),
                      ],
                    )),
              ),
            ),
            _keyboardIsVisible()
                ? Expanded(
                    flex: 1,
                    child: SizedBox(),
                  )
                : Expanded(
                    flex: 2,
                    child: Container(
                      color: Color(0xff4dd172),
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              "If you don't have an account",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 2,
                            child: MaterialButton(
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Color(0xff4dd172))),
                              child: Text(
                                'Click Here',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xff4dd172),
                                ),
                              ),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ContactUI()));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
          ]));
  }
}

class StudentTrackTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('Student',
            style: TextStyle(
              fontSize: 70.0,
              fontWeight: FontWeight.bold,
              color: Color(0xff4dd172),
            )),
        Text('Track',
            style: TextStyle(
              fontSize: 70.0,
              fontWeight: FontWeight.bold,
              color: Color(0xff696969),
            )),
      ],
    );
  }
}
