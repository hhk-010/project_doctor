import 'package:flutter/material.dart';
import 'package:project_doctor/services/auth.dart';

import '../services/auth.dart';

class Updatepass2 extends StatefulWidget {
  @override
  _Updatepass2State createState() => _Updatepass2State();
}

class _Updatepass2State extends State<Updatepass2> {
  String _password;

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Update your passord'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'enter your new password',
                ),
                onChanged: (val) {
                  _password = val;
                },
                validator: (val) => val.length < 8
                    ? 'password should contain more than 8 characters'
                    : null,
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                child: Text('update my password'),
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    AuthService().updatepass(_password);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
