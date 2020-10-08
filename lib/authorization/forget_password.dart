import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String email;

  final _formkey = GlobalKey<FormState>();
  TextStyle _textStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Password Reset',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 75.0, horizontal: 50.0),
        child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  decoration: textInputdecoration.copyWith(
                    hintText: 'Enter Your Current Email',
                    labelText: 'Email',
                  ),
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (val) {
                    email = val;
                  },
                  validator: (val) =>
                      val.isEmpty ? 'Enter a valid email address' : null,
                ),
                Spacer(),
                RaisedButton.icon(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  color: Colors.deepOrange,
                  label: Text(
                    'Send Email To Reset Password',
                    style:
                        _textStyle.copyWith(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: email);
                    }
                  },
                ),
              ],
            )),
      ),
    );
  }
}
