import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/services/auth.dart';

class EmailVerification extends StatefulWidget {
  final String email;
  EmailVerification({this.email});

  @override
  _EmailVerificationState createState() =>
      _EmailVerificationState(email: email);
}

class _EmailVerificationState extends State<EmailVerification> {
  String email;
  _EmailVerificationState({this.email});
  final AuthService _auth = AuthService();

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
        title: Text(
          'Email Confirmation',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      body: Container(
        height: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 75.0, horizontal: 50.0),
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: Image(
                image: AssetImage('assets/images/email.png'),
              ),
            ),
            Spacer(
              flex: 3,
            ),
            Text(
              'We Sent an Email to: ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Spacer(
              flex: 1,
            ),
            Text(
              '$email',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Spacer(
              flex: 2,
            ),
            Text(
              'Check your email and click on the confirmation link then',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
            Spacer(
              flex: 3,
            ),
            RaisedButton.icon(
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              color: Colors.deepOrange,
              label: Text('Continue',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              onPressed: () async {
                if (FirebaseAuth.instance.currentUser.emailVerified) {
                  Navigator.pushNamed(context, '/intermediate');
                }
              },
            ),
            Spacer(
              flex: 2,
            ),
            InkWell(
              onTap: () async {
                await AuthService().resendemail();
              },
              child: RichText(
                text: new TextSpan(
                  style: new TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    new TextSpan(text: " Didn't receive email ?"),
                    new TextSpan(
                        text: 'Resent Email',
                        style: new TextStyle(color: Colors.deepOrange)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
