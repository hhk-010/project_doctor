import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_doctor/authorization/loading.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/ui/sizing_information.dart';
import '../../services/auth.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/device_screen_type.dart';

class UpdatePassword extends StatefulWidget {
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  String _oldPassword;
  String _newPassword;
  bool passwordvalid;
  String error = '';
  bool _passwordVisible;
  final _formkey = GlobalKey<FormState>();

  //--------------checking internet connection
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

  //-----------------this function will return a snackbar instead of the old one
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
  bool isloading = false;
  @override
  void initState() {
    _passwordVisible = false;
    checkInternet();
    super.initState();
  }

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
        containerWidth = displayWidth(context) * 0.75;
        containerHeight = displayHeight(context) * 0.7;
        title = displayWidth(context) * 0.05;
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
            centerTitle: true,
            title: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                AppLocalizations.of(context).translate('update_password'),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: appBarTitle,
                ),
              ),
            ),
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
                  ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(
                        height: imageHeight,
                        child: Image(
                          image: AssetImage(
                            'assets/images/update_password.png',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        decoration: textInputdecoration.copyWith(
                          hintText: AppLocalizations.of(context).translate('current_password'),
                          labelText: AppLocalizations.of(context).translate('old_password'),
                        ),
                        onChanged: (val) {
                          _oldPassword = val;
                        },
                        validator: (val) => val.length < 8 ? AppLocalizations.of(context).translate('valid_password') : null,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        obscureText: !_passwordVisible,
                        onChanged: (val) {
                          setState(() => _newPassword = val);
                        },
                        decoration: textInputdecoration.copyWith(
                          hintText: AppLocalizations.of(context).translate('new_password_hint'),
                          labelText: AppLocalizations.of(context).translate('new_password'),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.deepOrange,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (val) => val.length < 8 ? AppLocalizations.of(context).translate('password_validator') : null,
                      ),
                    ],
                  ),
                  Container(
                    height: buttonHeight,
                    width: !isloading ? buttonWidth : buttonHeight,
                    child: LoadingButtonIcon(
                      isloading: isloading,
                      loadercolor: Colors.white,
                      backgroundcolor: Colors.deepOrange,
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      onpressed: () async {
                        checkInternet();
                        if (_isInternet) {
                          if (_formkey.currentState.validate()) {
                            setState(() => isloading = true);
                            AuthService().passwordisvalid(_oldPassword);
                            passwordvalid = await AuthService().validatepass(_oldPassword);
                            if (passwordvalid) {
                              AuthService().updatepass(_newPassword);
                              setState(() => isloading = false);
                              int count = 0;
                              Navigator.popUntil(context, (route) {
                                return count++ == 2;
                              });
                            } else {
                              setState(() {
                                isloading = false;
                                error = AppLocalizations.of(context).translate('invalid_password');
                              });
                              //--------snackbar problem
                              _showSnackBar();
                            }
                          }
                        } else {
                          setState(() {
                            error = AppLocalizations.of(context).translate('snack_connectivity');
                          });
                          _showSnackBar();
                        }
                      },
                      label: Text(
                        AppLocalizations.of(context).translate('update'),
                        style: TextStyle(color: Colors.white, fontSize: title, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
