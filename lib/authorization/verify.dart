import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/authorization/wrapper.dart';
import 'package:project_doctor/services/auth.dart';

class Verify extends StatefulWidget {
  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  @override
  void initState() {
    super.initState();
    Future(() async {
      Timer.periodic(Duration(seconds: 5), (timer) async {
        FirebaseAuth.instance.currentUser..reload();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('verify your email address'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text('After verifying your email , click below'),
            ),
            RaisedButton(
              onPressed: () {
                if (FirebaseAuth.instance.currentUser.emailVerified) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Intermediate()));
                }
              },
              child: Text('Next'),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text('To resend email for verification , click below'),
            ),
            RaisedButton(
              onPressed: () async {
                await AuthService().resendemail();
              },
              child: Text('Resend'),
            )
          ],
        ),
      ),
    );
  }
}
