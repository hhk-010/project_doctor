import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class for getting the data from map to firebase through verfication.
class EmailVerification extends StatefulWidget {
  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool loading = false;
  String _email = 'AAA';
  String _name = '';
  String _speciality = '';
  String _phoneNumber = '';
  String _province = '';
  String _address = '';
  double _lat = 0.0;
  double _lng = 0.0;
  List<String> _workDays01 = [];
  List<String> _workDays02 = [];
  List<String> _workDays03 = [];

  final AuthService _auth = AuthService();
  Timer _timer;
  _readDoctorInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email') ?? null;
      _name = prefs.getString('name') ?? null;
      _speciality = prefs.getString('speciality') ?? null;
      _phoneNumber = prefs.getString('phoneNumber') ?? null;
      _province = prefs.getString('province') ?? null;
      _address = prefs.getString('address') ?? null;
      _lat = prefs.getDouble('lat') ?? null;
      _lng = prefs.getDouble('lng') ?? null;
      _workDays01 = prefs.getStringList('workDays01') ?? null;
      _workDays02 = prefs.getStringList('workDays02') ?? null;
      _workDays03 = prefs.getStringList('workDays03') ?? null;
    });
  }

  @override
  void initState() {
    super.initState();
    Future(() async {
      _timer = Timer.periodic(Duration(seconds: 10), (timer) async {
        FirebaseAuth.instance.currentUser..reload();
      });
    });
    _readDoctorInfo();
  }

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
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
        padding: EdgeInsets.fromLTRB(50, 75, 50, 25),
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
              _email,
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
              color: Colors.deepOrange,
              label: Text(AppLocalizations.of(context).translate("continue"), //'Continue',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              onPressed: () async {
                if (FirebaseAuth.instance.currentUser.emailVerified) {
                  await DatabaseService(uid: FirebaseAuth.instance.currentUser.uid)
                      .updateUserData(_name, _speciality, _phoneNumber, _province, _lat, _lng, _address, _workDays01, _workDays02, _workDays03);
                  await Navigator.pushNamed(context, '/intermediate');
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
                textAlign: TextAlign.center,
                text: new TextSpan(
                  style: new TextStyle(
                      fontSize: 14.0, color: Colors.black, fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica', fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    //----text has been changed because if the client clicked resend
                    // for two time with less than one to twe minutes in between
                    // firebase will consider it as unusual activity -----
                    new TextSpan(text: AppLocalizations.of(context).translate("didnot receive")),
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
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
