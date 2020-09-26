import 'package:flutter/material.dart';
import 'package:project_doctor/pages/updatepass2.dart';
import 'package:project_doctor/services/auth.dart';

import '../services/auth.dart';

class Updatepass1 extends StatefulWidget {
  @override
  _Updatepass1State createState() => _Updatepass1State();
}

class _Updatepass1State extends State<Updatepass1> {
  String _password;
  bool passwordvalid;
  String error = '';

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
                  hintText: 'enter your current password',
                ),
                onChanged: (val) {
                  _password = val;
                },
                validator: (val) =>
                    val.isEmpty ? 'enter a valid password' : null,
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                child: Text('change my password'),
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    AuthService().passwordisvalid(_password);
                    passwordvalid = await AuthService().validatepass(_password);
                    if (passwordvalid) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Updatepass2()));
                    } else {
                      error = 'invalid password';
                    }
                  }
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  error,
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
