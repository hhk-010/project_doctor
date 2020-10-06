import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/pages/doctor_profile.dart';
import 'package:project_doctor/services/auth.dart';
import '../services/auth.dart';

class UpdatePassword01 extends StatefulWidget {
  @override
  _UpdatePassword01State createState() => _UpdatePassword01State();
}

class _UpdatePassword01State extends State<UpdatePassword01> {
  String _oldPassword;
  String _newPassword;
  bool passwordvalid;
  String error = '';

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Updating Password',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                decoration: textInputdecoration.copyWith(
                    hintText: 'Enter your Current Password',
                    labelText: 'Enter your Current Password'),
                onChanged: (val) {
                  _oldPassword = val;
                },
                validator: (val) =>
                    val.isEmpty ? 'Enter a Valid Password' : null,
              ),
              TextFormField(
                decoration: textInputdecoration.copyWith(
                    hintText: 'Enter The New Password',
                    labelText: 'Enter The New Password'),
                onChanged: (val) {
                  _newPassword = val;
                },
                validator: (val) => val.length < 8
                    ? 'password should contain more than 8 characters'
                    : null,
              ),
              ButtonTheme(
                minWidth: double.infinity,
                child: RaisedButton.icon(
                  color: Colors.deepOrange,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {
                      AuthService().passwordisvalid(_oldPassword);
                      passwordvalid =
                          await AuthService().validatepass(_oldPassword);
                      AuthService().updatepass(_newPassword);
                      if (passwordvalid) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DoctorProfile()));
                      } else {
                        error = 'Invalid Password';
                      }
                    }
                  },
                  label: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: Text(
                    error,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
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
