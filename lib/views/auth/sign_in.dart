import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/custom_widges/custom_home.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/services/theme.dart';
import 'package:project_doctor/constants/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/auth/forget_password.dart';
import 'dart:io';
import 'package:project_doctor/views/auth/loading.dart';

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
      title: LocaleKeys.view_doctor_sign_in.tr(),
      child: Form(
        key: _formKey,
        child: Stack(alignment: Alignment.topCenter, children: [
          Positioned(
            top: 50,
            child: CircleAvatar(
              backgroundColor: Colors.deepOrangeAccent,
              radius: 75,
              backgroundImage: AssetImage('assets/images/sign_in.png'),
            ),
          ),
          Positioned(
            top: 250,
            child: Container(
              height: 150,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    validator: (val) => val.isEmpty ? LocaleKeys.view_doctor_enter_your_email.tr() : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.emailAddress,
                    decoration: textInputdecoration.copyWith(
                      hintText: LocaleKeys.view_doctor_enter_your_email.tr(),
                      labelText: LocaleKeys.view_doctor_email.tr(),
                    ),
                  ),
                  TextFormField(
                    validator: (val) => val.length < 8 ? LocaleKeys.view_doctor_password_validator.tr() : null,
                    obscureText: !_passwordVisible,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    decoration: textInputdecoration.copyWith(
                      hintText: LocaleKeys.view_doctor_enter_your_password.tr(),
                      labelText: LocaleKeys.view_doctor_password.tr(),
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
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Container(
                width: 300,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: loading ? 40.0 : 40,
                      width: loading ? 40.0 : 150,
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
                                  SnackText.errorMsg = LocaleKeys.view_snack_error_snack_sign_in.tr();
                                });
                                _showSnackBar();
                              }
                            }
                          } else {
                            setState(() {
                              SnackText.errorMsg = LocaleKeys.view_snack_error_snack_connectivity.tr();
                            });
                            _showSnackBar();
                          }
                        },
                        backgroundcolor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        child: Text(
                          LocaleKeys.view_doctor_sign_in.tr(),
                          style: CStyle.getTitle(context),
                        ),
                      ),
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgetPassword()));
                      },
                      label: Text(
                        LocaleKeys.view_doctor_forget_password.tr(),
                        style: CStyle.getSubtitle(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CustomFooter(
            child: InkWell(
              onTap: () {
                widget.questionsToogleView();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.view_doctor_does_not_have_account.tr(),
                    style: CStyle.getFooter(context),
                  ),
                  Text('  '),
                  Text(
                    LocaleKeys.view_doctor_register.tr(),
                    style: CStyle.getFooter(context).copyWith(color: Colors.red[600], fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

//------this class is for the snackbar text
class SnackText {
  static String errorMsg = '';
}
