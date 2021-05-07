import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/views/auth/loading.dart';
import 'package:project_doctor/constants/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String email;
  String error = '';

  final _formkey = GlobalKey<FormState>();
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

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    var lang = Localizations.localeOf(context).languageCode;

    final _snackbar = new SnackBar(
      content: Text(
        error,
        style: TextStyle(fontSize: 15, fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
      ),
      backgroundColor: Colors.deepOrange,
    );
    ScaffoldMessenger.of(context).showSnackBar(_snackbar);
  }

  //-------------------the end ----------------------
  @override
  void initState() {
    checkInternet();
    super.initState();
  }

//===================isloading=====================
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            LocaleKeys.view_doctor_passWord_reset.tr(),
            //'Password Reset',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
      ),
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: 120,
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
                          decoration: CStyle.getInputDecoration(context).copyWith(
                            hintText: LocaleKeys.view_doctor_enter_your_email.tr(),
                            //'Enter Your Current Email',
                            labelText: LocaleKeys.view_doctor_email.tr(),
                          ),
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (val) {
                            email = val;
                          },
                          validator: (val) => val.isEmpty ? LocaleKeys.view_doctor_enter_your_email.tr() : null,
                        ),
                        SizedBox(
                          height: 150,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: isloading ? 50 : 150,
                    child: LoadingButton(
                      isloading: isloading,
                      loadercolor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      backgroundcolor: Colors.deepOrange,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          LocaleKeys.view_doctor_password_reset_email.tr(),
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      onpressed: () async {
                        checkInternet();
                        if (_isInternet) {
                          if (_formkey.currentState.validate()) {
                            setState(() => isloading = true);
                            await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                            setState(() => isloading = false);
                            await Navigator.of(context).push(MaterialPageRoute(builder: (context) => PasswordResetContinue(email: email)));
                          }
                        } else {
                          setState(() {
                            error = LocaleKeys.view_snack_error_snack_connectivity.tr();
                          });
                          _showSnackBar();
                        }
                      },
                    ),
                  ),
                ],
              )),
        ),
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            LocaleKeys.view_doctor_passWord_reset.tr(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
      ),
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          child: Column(children: [
            SizedBox(
              height: 120,
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
              LocaleKeys.view_email_verification_email_sent.tr(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Divider(
              color: Colors.grey,
              thickness: 2,
              indent: 60,
              endIndent: 60,
            ),
            Spacer(
              flex: 1,
            ),
            Container(
              decoration: CStyle.box,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$email',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Divider(
              color: Colors.grey,
              thickness: 2,
              indent: 40,
              endIndent: 40,
            ),
            SizedBox(
              width: 20,
              child: Text(
                LocaleKeys.view_doctor_check_reset_email.tr(),
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(
              flex: 3,
            ),
            Container(
              height: 50,
              width: 150,
              child: TextButton.icon(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    backgroundColor: Colors.deepOrange,
                  ),
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  label: Text(LocaleKeys.view_email_verification_continue.tr(),
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    int count = 0;
                    Navigator.popUntil(context, (route) => count++ == 2);
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
