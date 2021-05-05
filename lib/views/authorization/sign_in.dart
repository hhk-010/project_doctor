import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_doctor/custom_widges/c_base.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/services/theme.dart';
import 'package:project_doctor/constants/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/authorization/custom_widgets.dart';
import 'package:project_doctor/views/authorization/forget_password.dart';
import 'dart:io';

import 'package:project_doctor/views/authorization/loading.dart';


class SignModel {
  bool loading;
  String email;
  String password;
  String error;
  bool passwordVisible;
  bool isInternet = true;
}

class SignInView extends StatefulWidget {
// refactor
  final Function questionsToogleView;
  SignInView({this.questionsToogleView});

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  // objects used for sign in
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';
  bool _passwordVisible = false;

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

// snackbar functions
  _showSnackBar() {
    var lang = Localizations.localeOf(context).languageCode;

    final _snackbar = new SnackBar(
      content: Text(
        SnackText.errorMsg,
        style: TextStyle(fontSize: 15, fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
      ),
      backgroundColor: Colors.deepOrange,
    );
    ScaffoldMessenger.of(context).showSnackBar(_snackbar);
  }

  @override
  void initState() {
    _passwordVisible = false;
    checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isAppbar: true,
      title: LocaleKeys.doctor_view_sign_in.tr(),
      child: Form(
        key: _formKey,
        child: Stack(children: [
          Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              backgroundColor: Colors.deepOrangeAccent,
              radius: 50,
              backgroundImage: AssetImage('assets/images/sign_in.png'),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormField(
                    validator: (val) => val.isEmpty ? LocaleKeys.doctor_view_enter_your_email.tr() : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.emailAddress,
                    decoration: textInputdecoration.copyWith(
                      hintText: LocaleKeys.doctor_view_enter_your_email.tr(),
                      labelText: LocaleKeys.doctor_view_email.tr(),
                    ),
                  ),
                  TextFormField(
                    validator: (val) => val.length < 8 ? LocaleKeys.doctor_view_password_validator.tr() : null,
                    obscureText: !_passwordVisible,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    decoration: textInputdecoration.copyWith(
                      hintText: LocaleKeys.doctor_view_enter_your_password.tr(),
                      labelText: LocaleKeys.doctor_view_password.tr(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.deepOrange,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: loading ? 40.0 : 100,
                  width: loading ? 40.0 : 100,
                  child: LoadingButton(
                    isloading: loading,
                    loadercolor: Colors.white,
                    onpressed: () async {
                      checkInternet();
                      if (_isInternet) {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic authResult = await _auth.signInWithEmailAndPassword(email, password);
                          if (authResult != null) {
                            setState(() => loading = false);
                          } else {
                            setState(() {
                              setState(() => loading = false);
                              SnackText.errorMsg = LocaleKeys.snack_error_snack_sign_in.tr();
                            });
                            _showSnackBar();
                          }
                        }
                      } else {
                        setState(() {
                          SnackText.errorMsg = LocaleKeys.snack_error_snack_connectivity.tr();
                        });
                        _showSnackBar();
                      }
                    },
                    backgroundcolor: Colors.deepOrange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    child: Text(
                      LocaleKeys.doctor_view_sign_in.tr(),
                      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold), //_textStyle.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                TextButton.icon(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgetPassword()));
                  },
                  label: Text(
                    LocaleKeys.doctor_view_forget_password.tr(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                InkWell(
                  onTap: () {
                    widget.questionsToogleView();
                  },
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: LocaleKeys.doctor_view_does_not_have_account.tr(),
                        ),
                        TextSpan(text: LocaleKeys.doctor_view_register.tr(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
