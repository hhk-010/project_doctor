import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/authorization/loading.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/sizing_information.dart';

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
    _scaffoldkey.currentState.showSnackBar(_snackbar);
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
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      double appBarTitle;
      double appBarHeight;
      double containerWidth;
      double containerHeight;
      double buttonHeight;
      double buttonWidth;
      double title;
      double imageHeight;

      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
        appBarTitle = 25;
        appBarHeight = 50;
        containerWidth = displayWidth(context) * 0.85;
        containerHeight = displayHeight(context) * 0.75;
        title = displayWidth(context) * 0.045;
        buttonHeight = displayHeight(context) * 0.05;
        buttonWidth = displayWidth(context) * 0.7;
        imageHeight = 150;
      } else {
        appBarTitle = displayHeight(context) * 0.045;
        appBarHeight = 75;
        containerWidth = displayWidth(context) * 0.5;
        containerHeight = displayHeight(context) * 0.6;
        title = displayWidth(context) * 0.035;
        buttonHeight = displayHeight(context) * 0.04;
        buttonWidth = displayWidth(context) * 0.4;
        imageHeight = 200;
      }
      return Scaffold(
        key: _scaffoldkey,
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: AppBar(
            backgroundColor: Colors.deepOrange,
            title: Text(
              AppLocalizations.of(context).translate("passWord_reset"), //'Password Reset',
              style: TextStyle(fontSize: appBarTitle, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
        ),
        body: Center(
          child: Container(
            height: containerHeight,
            width: containerWidth,
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
                            height: imageHeight,
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
                              hintText: AppLocalizations.of(context).translate('enter_your_email'), //'Enter Your Current Email',
                              labelText: AppLocalizations.of(context).translate('email'), //'Email',
                            ),
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (val) {
                              email = val;
                            },
                            validator: (val) => val.isEmpty ? AppLocalizations.of(context).translate('enter_your_email') : null,
                          ),
                          SizedBox(
                            height: 150,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: buttonHeight,
                      width: isloading ? buttonHeight : buttonWidth,
                      child: LoadingButton(
                        isloading: isloading,
                        loadercolor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        backgroundcolor: Colors.deepOrange,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            AppLocalizations.of(context).translate('password_reset_email'),
                            style: TextStyle(color: Colors.white, fontSize: title, fontWeight: FontWeight.bold),
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
                              error = AppLocalizations.of(context).translate('snack_connectivity');
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
    });
  }
}

class PasswordResetContinue extends StatelessWidget {
  final String email;
  PasswordResetContinue({this.email});
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      double appBarTitle;
      double appBarHeight;
      double containerWidth;
      double containerHeight;
      double buttonHeight;
      double buttonWidth;
      double title;
      double subTitle;
      double imageHeight;
      double textWidth;

      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
        appBarTitle = 25;
        appBarHeight = 50;
        containerWidth = displayWidth(context) * 0.85;
        containerHeight = displayHeight(context) * 0.75;
        title = displayWidth(context) * 0.045;
        subTitle = displayWidth(context) * 0.04;
        buttonHeight = displayHeight(context) * 0.05;
        buttonWidth = displayWidth(context) * 0.5;
        imageHeight = 150;
        textWidth = displayWidth(context) * 0.7;
      } else {
        appBarTitle = displayHeight(context) * 0.045;
        appBarHeight = 75;
        containerWidth = displayWidth(context) * 0.5;
        containerHeight = displayHeight(context) * 0.6;
        title = displayWidth(context) * 0.035;
        subTitle = displayWidth(context) * 0.028;
        buttonHeight = displayHeight(context) * 0.04;
        buttonWidth = displayWidth(context) * 0.4;
        imageHeight = 200;
        textWidth = displayWidth(context) * 0.7;
      }
      return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: AppBar(
            backgroundColor: Colors.deepOrange,
            title: Text(
              AppLocalizations.of(context).translate('passWord_reset'),
              style: TextStyle(fontSize: appBarTitle, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
        ),
        body: Center(
          child: Container(
            height: containerHeight,
            width: containerWidth,
            child: Column(children: [
              SizedBox(
                height: imageHeight,
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
                style: TextStyle(fontSize: title, fontWeight: FontWeight.bold),
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
                decoration: boxDecoration,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$email',
                    style: TextStyle(fontSize: subTitle, fontWeight: FontWeight.bold),
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
                width: textWidth,
                child: Text(
                  AppLocalizations.of(context).translate("check_reset_email"),
                  style: TextStyle(fontSize: subTitle, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(
                flex: 3,
              ),
              Container(
                height: buttonHeight,
                width: buttonWidth,
                child: RaisedButton.icon(
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    color: Colors.deepOrange,
                    label: Text(AppLocalizations.of(context).translate('continue'),
                        style: TextStyle(color: Colors.white, fontSize: title, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/intermediate');
                    }),
              ),
            ]),
          ),
        ),
      );
    });
  }
}
