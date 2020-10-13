import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/authorization/forget_password.dart';
import 'package:project_doctor/authorization/loading.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/constants/theme.dart';
import 'dart:io';

class SignIn extends StatefulWidget {
  final Function toogleView;
  //final Function intermediate;
  SignIn({this.toogleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';
  bool _passwordVisible;
  TextStyle _textStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);

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
    _passwordVisible = false;
    checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: Colors.deepOrange,
              title: Text(
                'Sign In',
                style: _textStyle.copyWith(fontSize: 25.0),
              ),
              centerTitle: true,
              elevation: 0.0,
              /*actions: [
                FlatButton.icon(
                  onPressed: () {
                    //widget.intermediate();
                  },
                  icon: Icon(Icons.arrow_back),
                  label: Text('Back'),
                ),
              ],*/
            ),
            body: Container(
              height: double.maxFinite,
              padding: EdgeInsets.symmetric(vertical: 75.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
                      decoration: textInputdecoration.copyWith(
                        hintText: 'Enter Your Email',
                        labelText: 'Email',
                      ),
                    ),
                    Spacer(),
                    TextFormField(
                      validator: (val) => val.length < 8
                          ? 'password should be > 8 Character'
                          : null,
                      obscureText: !_passwordVisible,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      decoration: textInputdecoration.copyWith(
                        hintText: 'Enter Your Password',
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.deepOrange,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 10,
                    ),
                    Container(
                      height: 40.0,
                      width: 200.0,
                      child: RaisedButton(
                        onPressed: _isInternet
                            ? () async {
                                if (_formKey.currentState.validate()) {
                                  try {
                                    _auth.signInWithEmailAndPassword(
                                        email, password);
                                    setState(() => loading = true);
                                  } on FirebaseAuthException catch (e) {
                                    setState(() {
                                      loading = false;
                                    });
                                    Scaffold.of(context).showSnackBar(
                                        SnackBar(content: Text(e.message)));
                                  }
                                }
                              }
                            : () {
                                SnackBar errorSnackBar = SnackBar(
                                    content: Text('No internet Connection'));
                                Scaffold.of(context)
                                    .showSnackBar(errorSnackBar);
                              },
                        color: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        child: Text(
                          'Sign In',
                          style: _textStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    FlatButton.icon(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ForgetPassword()));
                      },
                      label: Text(
                        'Forget Your Password?',
                        style: _textStyle.copyWith(
                            color: Colors.black, fontSize: 16),
                      ),
                    ),
                    Spacer(),
                    Text(error),
                    Divider(color: Colors.black),
                    InkWell(
                      onTap: () {
                        widget.toogleView();
                      },
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: 'Does not have account? '),
                            TextSpan(
                                text: 'Register',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
