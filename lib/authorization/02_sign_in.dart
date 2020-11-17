import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/authorization/forget_password.dart';
import 'package:project_doctor/authorization/loading.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/constants/theme.dart';
import 'dart:io';

//------this class is for the snackbar text
class SnackText {
  static String error = '';
}

class SignIn extends StatefulWidget {
  final Function toogleView;
  SignIn({this.toogleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';
  bool _passwordVisible = false;
  TextStyle _textStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);

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
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    var lang = Localizations.localeOf(context).languageCode;

    final _snackbar = new SnackBar(
      content: Text(
        SnackText.error,
        style: TextStyle(
            fontSize: 15,
            fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
      ),
      backgroundColor: Colors.deepOrange,
    );
    _scaffoldkey.currentState.showSnackBar(_snackbar);
  }

  @override
  void initState() {
    _passwordVisible = false;
    checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;

    return loading
        ? Loading()
        : Scaffold(
            key: _scaffoldkey,
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: Colors.deepOrange,
              title: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  AppLocalizations.of(context).translate('sign_in'),
                  style: _textStyle.copyWith(fontSize: 25.0),
                ),
              ),
              centerTitle: true,
              elevation: 0.0,
            ),
            body: Container(
              height: double.maxFinite,
              padding: EdgeInsets.fromLTRB(50, 75, 50, 25),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.deepOrangeAccent,
                      radius: 80,
                      backgroundImage: AssetImage('assets/images/sign_in.png'),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty
                          ? AppLocalizations.of(context)
                              .translate('enter_your_email')
                          : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
                      decoration: textInputdecoration.copyWith(
                        hintText: AppLocalizations.of(context)
                            .translate('enter_your_email'),
                        labelText:
                            AppLocalizations.of(context).translate('email'),
                      ),
                    ),
                    Spacer(),
                    TextFormField(
                      validator: (val) => val.length < 8
                          ? AppLocalizations.of(context)
                              .translate('password_validator')
                          : null,
                      obscureText: !_passwordVisible,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      decoration: textInputdecoration.copyWith(
                        hintText: AppLocalizations.of(context)
                            .translate('enter_your_password'),
                        labelText:
                            AppLocalizations.of(context).translate('password'),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
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
                    Spacer(
                      flex: 5,
                    ),
                    Container(
                      height: 40.0,
                      width: 200.0,
                      child: RaisedButton(
                        onPressed: () async {
                          //conection will be checked after pressing not only in the begining
                          // so the error message will be changed
                          checkInternet();
                          if (_isInternet) {
                            if (_formKey.currentState.validate()) {
                              try {
                                final result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                //if the credentials are in valid or internet connection is interrupted
                                //after entering this page and pressing sign in the loading is activated
                                // so it was better by this following if condition
                                if (result != null) {
                                  setState(() => loading = true);
                                } else {
                                  setState(() {
                                    SnackText.error =
                                        AppLocalizations.of(context)
                                            .translate('snack_sign_in');
                                  });
                                  _showSnackBar();
                                }
                              } on FirebaseAuthException catch (e) {
                                setState(() {
                                  loading = false;
                                });
                              }
                            }
                          } else {
                            setState(() {
                              SnackText.error = AppLocalizations.of(context)
                                  .translate('snack_connectivity');
                            });
                            _showSnackBar();
                          }
                        },
                        color: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        child: Text(
                          AppLocalizations.of(context).translate('sign_in'),
                          style: _textStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    FlatButton.icon(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ForgetPassword()));
                      },
                      label: Text(
                        AppLocalizations.of(context)
                            .translate('forget_password'),
                        style: _textStyle.copyWith(
                            color: Colors.black, fontSize: 16),
                      ),
                    ),
                    Spacer(),
                    Text(
                      error,
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                    Divider(color: Colors.black),
                    InkWell(
                      onTap: () {
                        widget.toogleView();
                      },
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontFamily:
                                  lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
                          children: <TextSpan>[
                            TextSpan(
                                text: AppLocalizations.of(context)
                                    .translate('does_not_have_account')),
                            TextSpan(
                                text: AppLocalizations.of(context)
                                    .translate('register'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
