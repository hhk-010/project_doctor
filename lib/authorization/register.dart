import 'package:flutter/material.dart';
import 'package:project_doctor/authorization/loading.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'dart:io';
import '../pages/doctor_form.dart';

class Register extends StatefulWidget {
  final Function toogleView;
  Register({this.toogleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';

  // check internet connection
  bool _isInternet = true;
  checkInternet() async {
    try {
      final response = await InternetAddress.lookup('google.com');
      if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
        _isInternet = true; // internet
        setState(() {});
      }
    } on SocketException catch (_) {
      _isInternet = false; // no internet
      setState(() {});
    }
  }

  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  TextStyle _textStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: Colors.deepOrange,
              title: Text('Register', style: _textStyle.copyWith(fontSize: 25)),
              centerTitle: true,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Enter an Email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.emailAddress,
                        decoration: textInputdecoration.copyWith(
                          hintText: 'Email',
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6 or long'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.visiblePassword,
                        decoration:
                            textInputdecoration.copyWith(hintText: 'Password'),
                      ),
                      SizedBox(
                        height: 250.0,
                      ),
                      Builder(builder: (context) {
                        return Container(
                          height: 40.0,
                          width: 200.0,
                          child: RaisedButton(
                            onPressed: _isInternet
                                ? () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => DoctorForm(
                                                    email: email,
                                                    password: password,
                                                  )));
                                    }
                                  }
                                : () {
                                    SnackBar errorSnackBar = SnackBar(
                                        content:
                                            Text('No internet Connection'));
                                    Scaffold.of(context)
                                        .showSnackBar(errorSnackBar);
                                  },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0)),
                            color: Colors.deepOrange,
                            child: Text('Register',
                                style:
                                    _textStyle.copyWith(color: Colors.white)),
                          ),
                        );
                      }),
                      Text(error),
                      SizedBox(
                        height: 90,
                      ),
                      Divider(color: Colors.black),
                      InkWell(
                        onTap: () {
                          widget.toogleView();
                        },
                        child: RichText(
                          text: new TextSpan(
                            // Note: Styles for TextSpans must be explicitly defined.
                            // Child text spans will inherit styles from parent
                            style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              new TextSpan(text: 'Already have an account? '),
                              new TextSpan(
                                  text: 'Sign In',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
