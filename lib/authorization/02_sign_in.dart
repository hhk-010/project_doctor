import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_doctor/authorization/forget_password.dart';
import 'package:project_doctor/authorization/loading.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/constants/theme.dart';
import 'dart:io';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/sizing_information.dart';

//------this class is for the snackbar text
class SnackText {
  static String errorMsg = '';
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
        SnackText.errorMsg,
        style: TextStyle(
            fontSize: 15,
            fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
      ),
      backgroundColor: Colors.deepOrange,
    );
    _scaffoldkey.currentState.showSnackBar(_snackbar);
  }

//=======================================
  @override
  void initState() {
    _passwordVisible = false;
    checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        double appBarTitle;
        double appBarHeight;
        double containerHeight;
        double containerWidth;
        double buttonHeight;
        double buttonWidth;
        double title;
        double subTitle;
        double footer;
        double avatar;
        double textFieldWidth;
        double spacerSmall;
        double spacerLarge;
        double spacerMedium;

        if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
          appBarTitle = 25;
          appBarHeight = 50;
          containerHeight = displayHeight(context) * 0.8;
          containerWidth = displayWidth(context) * 0.85;
          title = displayWidth(context) * 0.045;
          subTitle = displayWidth(context) * 0.035;
          footer = displayWidth(context) * 0.035;
          buttonHeight = displayHeight(context) * 0.05;
          buttonWidth = displayWidth(context) * 0.7;
          avatar = 70;
          textFieldWidth = displayWidth(context) * 0.7;
          spacerSmall = displayHeight(context) * 0.03;
          spacerMedium = displayHeight(context) * 0.09;
          spacerLarge = displayHeight(context) * 0.1;
        } else {
          appBarTitle = displayHeight(context) * 0.045;
          appBarHeight = 75;
          containerHeight = displayHeight(context) * 0.7;
          containerWidth = displayWidth(context) * 0.5;
          footer = displayWidth(context) * 0.025;
          title = displayWidth(context) * 0.035;
          subTitle = displayWidth(context) * 0.025;
          buttonHeight = displayHeight(context) * 0.04;
          buttonWidth = displayWidth(context) * 0.4;
          avatar = 100;
          textFieldWidth = displayWidth(context) * 0.4;
          spacerSmall = displayHeight(context) * 0.03;
          spacerMedium = displayHeight(context) * 0.05;
          spacerLarge = displayHeight(context) * 0.1;
        }
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
                      style: TextStyle(
                          //changed cause it is showing error on my device
                          fontSize: 20), //_textStyle.copyWith(fontSize: 25.0),
                    ),
                  ),
                  centerTitle: true,
                  elevation: 0.0,
                ),
                body: Padding(
                  padding: EdgeInsets.fromLTRB(50, 75, 50, 25),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.deepOrangeAccent,
                          radius: 80,
                          backgroundImage:
                              AssetImage('assets/images/sign_in.png'),
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
                            labelText: AppLocalizations.of(context)
                                .translate('password'),
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
                          height: loading ? 40.0 : buttonHeight,
                          width: loading ? 40.0 : buttonWidth,
                          child: LoadingButton(
                            isloading: loading,
                            loadercolor: Colors.white,
                            onpressed: () async {
                              //conection will be checked after pressing not only in the begining
                              // so the error message will be changed
                              checkInternet();
                              if (_isInternet) {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  dynamic authResult =
                                      await _auth.signInWithEmailAndPassword(
                                          email, password);
                                  //if the credentials are in valid or internet connection is interrupted
                                  //after entering this page and pressing sign in the loading is activated
                                  // so it was better by this following if condition
                                  if (authResult != null) {
                                    setState(() => loading = false);
                                  } else {
                                    setState(() {
                                      setState(() => loading = false);
                                      SnackText.errorMsg =
                                          AppLocalizations.of(context)
                                              .translate('snack_sign_in');
                                    });
                                    _showSnackBar();
                                  }
                                }
                              } else {
                                setState(() {
                                  SnackText.errorMsg =
                                      AppLocalizations.of(context)
                                          .translate('snack_connectivity');
                                });
                                _showSnackBar();
                              }
                            },
                            backgroundcolor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0)),
                            child: Text(
                              AppLocalizations.of(context).translate('sign_in'),
                              style: TextStyle(
                                  fontSize:
                                      20), //_textStyle.copyWith(color: Colors.white),
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
                            style: TextStyle(
                                fontSize:
                                    20), //_textStyle.copyWith(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        Spacer(),
                        Text(
                          error,
                          style: TextStyle(color: Colors.deepOrange),
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        InkWell(
                          onTap: () {
                            widget.toogleView();
                          },
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontFamily: lang == 'ar'
                                      ? 'noto_arabic'
                                      : 'Helvetica'),
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
      },
    );
  }
}
