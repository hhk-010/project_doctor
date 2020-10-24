import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/auth.dart';

//---------class for launching the registered email
class Newclient {
  static String email = '';
}

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
  Timer _timer;
  @override
  void initState() {
    super.initState();
    Future(() async {
      _timer = Timer.periodic(Duration(seconds: 10), (timer) async {
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
          AppLocalizations.of(context).translate("email_v_title"),
          //'Email Confirmation',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              //========changed beacause it is not defined on my device
              Icons.account_box,
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
              AppLocalizations.of(context).translate('email_sent'),
              //'We Sent an Email to: ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Spacer(
              flex: 1,
            ),
            Text(
              Newclient.email,
              //'$email',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Spacer(
              flex: 2,
            ),
            Text(
              AppLocalizations.of(context).translate("confirm"),
              //'Check your email and click on the confirmation link then',
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
              label: Text(
                  AppLocalizations.of(context)
                      .translate("continue"), //'Continue',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
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
                    //----text has been changed because if the client clicked resend
                    // for two time with less than one to twe minutes in between
                    // firebase will consider it as unusual activity -----
                    new TextSpan(
                        text: AppLocalizations.of(context)
                            .translate("didnot receive")),
                    //" Didn't receive email ? Please wait for few minutes then "),
                    new TextSpan(
                        text: AppLocalizations.of(context).translate("resend"),
                        //text: 'Resent Email',
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

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
