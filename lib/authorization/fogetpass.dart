import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgetpass extends StatefulWidget {
  @override
  _ForgetpassState createState() => _ForgetpassState();
}

class _ForgetpassState extends State<Forgetpass> {
  String email;

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Reset my password'),
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
                  decoration:
                      InputDecoration(hintText: 'enter your email address'),
                  onChanged: (val) {
                    email = val;
                  },
                  validator: (val) =>
                      val.isEmpty ? 'enter a valid email address' : null,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Text(
                    'by clicking an email will be sent to you',
                    style: TextStyle(color: Colors.pinkAccent),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  child: Text('send email'),
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
