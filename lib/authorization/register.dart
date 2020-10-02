import 'package:flutter/material.dart';
import 'package:project_doctor/authorization/loading.dart';
import 'package:project_doctor/services/theme_const.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

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

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: Colors.deepOrange,
              title: Text('Register'),
              centerTitle: true,
              elevation: 0.0,
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Enter an Email' : null,
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
                      validator: (val) =>
                          val.length < 6 ? 'Enter a password 6 or long' : null,
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
                      height: 60.0,
                    ),
                    Container(
                      height: 35.0,
                      width: 190.0,
                      child: RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DoctorForm(
                                      email: email,
                                      password: password,
                                    )));
                            /*if (result == null) {
                              setState(() {
                                error = 'Please supply a valid email';
                                loading = false;
                              });
                            }*/
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        color: Colors.deepOrange,
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(error),
                    Divider(color: Colors.black),
                    SizedBox(
                      height: 12.0,
                    ),
                    GoogleSignInButton(
                      onPressed: () => print('hello'),
                      splashColor: Colors.blue,
                      borderRadius: 20.0,
                      textStyle: TextStyle(fontSize: 15, color: Colors.black),
                      darkMode: false,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    AppleSignInButton(
                      onPressed: () => print('hello'),
                      splashColor: Colors.white,
                      borderRadius: 20.0,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
