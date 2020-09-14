import 'package:flutter/material.dart';
import 'package:project_doctor/auth/loading.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/services/constants.dart';

class Register extends StatefulWidget {
  final Function toogleView;
  Register({this.toogleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
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
              title: Text('تسجيل الدخول'),
              centerTitle: true,
              elevation: 0.0,
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: TextFormField(
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
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: TextFormField(
                            validator: (val) => val.length < 6
                                ? 'Enter a password 6 or long'
                                : null,
                            obscureText: true,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: textInputdecoration.copyWith(
                                hintText: 'Password'),
                          ),
                        ),
                        SizedBox(
                          height: 60.0,
                        ),
                        RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password);
                              if (result == null) {
                                setState(() {
                                  error = 'Please supply a valid email';
                                  loading = false;
                                });
                              }
                            }
                          },
                          color: Colors.deepOrange,
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(error),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text('Or Sign Up with google'),
                        SizedBox(
                          height: 10.0,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.deepOrange,
                        ),
                      ],
                    ),
                  ),
                )),
          );
  }
}
