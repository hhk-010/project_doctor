import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/app_localizations.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String email;
  String error = '';

  final _formkey = GlobalKey<FormState>();
  TextStyle _textStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  //function for internet connection
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

  //-----------------there was a problem in the old snackbar
  //-----------------this function will return a snackbar instead of the old one
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    var lang = Localizations.localeOf(context).languageCode;

    final _snackbar = new SnackBar(
      content: Text(
        error,
        style: TextStyle(
            fontSize: 15,
            fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
      ),
      backgroundColor: Colors.deepOrange,
    );
    _scaffoldkey.currentState.showSnackBar(_snackbar);
  }

  //-------------------the end ----------------------
  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          AppLocalizations.of(context)
              .translate("passWord_reset"), //'Password Reset',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.maxFinite,
        padding: EdgeInsets.fromLTRB(50, 75, 50, 25),
        child: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  child: Image(
                    image: AssetImage(
                      'assets/images/reset_password.png',
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  decoration: textInputdecoration.copyWith(
                    hintText: AppLocalizations.of(context).translate(
                        'enter_your_email'), //'Enter Your Current Email',
                    labelText: AppLocalizations.of(context)
                        .translate('email'), //'Email',
                  ),
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (val) {
                    email = val;
                  },
                  validator: (val) => val.isEmpty
                      ? AppLocalizations.of(context)
                          .translate('enter_your_email')
                      : null,
                ),
                Spacer(),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  color: Colors.deepOrange,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      AppLocalizations.of(context)
                          .translate('password_reset_email'),
                      style: _textStyle.copyWith(
                          color: Colors.white, fontSize: 20),
                    ),
                  ),
                  onPressed: () async {
                    checkInternet();
                    if (_isInternet) {
                      if (_formkey.currentState.validate()) {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: email);
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                PasswordResetContinue(email: email)));
                      }
                    } else {
                      setState(() {
                        error = AppLocalizations.of(context)
                            .translate('snack_connectivity');
                      });
                      _showSnackBar();
                    }
                  },
                ),
              ],
            )),
      ),
    );
  }
}

class PasswordResetContinue extends StatelessWidget {
  final String email;
  PasswordResetContinue({this.email});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          AppLocalizations.of(context).translate('passWord_reset'),
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 75.0, horizontal: 50.0),
        child: Column(children: [
          SizedBox(
            height: 150,
            child: Image(
              image: AssetImage(
                'assets/images/password.png',
              ),
            ),
          ),
          Spacer(
            flex: 3,
          ),
          Text(
            AppLocalizations.of(context).translate('email_sent'),
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
            AppLocalizations.of(context).translate("check_reset_email"),
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
              label: Text(AppLocalizations.of(context).translate('continue'),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pushNamed(context, '/intermediate');
              }),
        ]),
      ),
    );
  }
}
