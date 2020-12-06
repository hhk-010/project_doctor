import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'dart:io';
import '../pages/doctor_pages/doctor01_form.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/sizing_information.dart';

class Register extends StatefulWidget {
  final Function registerToggleView;
  final Function mcq;
  Register({this.registerToggleView, this.mcq});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool _passwordVisible = false;

  // check internet connection
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

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    checkInternet();
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      double appBarTitle;
      double appBarHeight;
      double containerHeight;
      double containerWidth;
      double buttonHeight;
      double buttonWidth;
      double title;
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
        buttonHeight = displayHeight(context) * 0.04;
        buttonWidth = displayWidth(context) * 0.4;
        avatar = 100;
        textFieldWidth = displayWidth(context) * 0.4;
        spacerSmall = displayHeight(context) * 0.03;
        spacerMedium = displayHeight(context) * 0.05;
        spacerLarge = displayHeight(context) * 0.1;
      }
      var lang = Localizations.localeOf(context).languageCode;
      return Scaffold(
        key: _scaffoldkey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: AppBar(
            backgroundColor: Colors.deepOrange,
            title: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(AppLocalizations.of(context).translate('register'),
                    style: TextStyle(
                        fontSize: appBarTitle, fontWeight: FontWeight.bold))),
            centerTitle: true,
            elevation: 0.0,
          ),
        ),
        body: Center(
          child: Container(
            height: containerHeight,
            width: containerWidth,
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: CircleAvatar(
                              backgroundColor: Colors.deepOrangeAccent,
                              radius: avatar,
                              backgroundImage:
                                  AssetImage('assets/images/register.png'),
                            ),
                          ),
                          SizedBox(
                            height: spacerMedium,
                          ),
                          SizedBox(
                            width: textFieldWidth,
                            child: TextFormField(
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
                                labelText: AppLocalizations.of(context)
                                    .translate('email'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: spacerSmall,
                          ),
                          SizedBox(
                            width: textFieldWidth,
                            child: TextFormField(
                              validator: (val) => val.length < 8
                                  ? AppLocalizations.of(context)
                                      .translate('password_validator')
                                  : null,
                              //? 'Enter a password 8 or long'
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
                          ),
                          SizedBox(
                            height: spacerLarge,
                          ),
                          Container(
                            height: buttonHeight,
                            width: buttonWidth,
                            child: RaisedButton(
                              onPressed: _isInternet
                                  ? () async {
                                      print(ModalRoute.of(context));
                                      if (_formKey.currentState.validate()) {
                                        if (email != '' && password != '') {
                                          if (ModalRoute.of(context) != null) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DoctorForm(
                                                  email: email,
                                                  password: password,
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                        //added because if the user return to this page
                                        // without registeration loading will run without showing register
                                        // page

                                      }
                                    }
                                  : () {
                                      SnackBar errorSnackBar = SnackBar(
                                        content: Text(
                                          AppLocalizations.of(context)
                                              .translate('snack_connectivity'),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: lang == 'ar'
                                                  ? 'noto_arabic'
                                                  : 'Helvetica'),
                                        ),
                                        backgroundColor: Colors.deepOrange,
                                      );
                                      Scaffold.of(context)
                                          .showSnackBar(errorSnackBar);
                                    },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0)),
                              color: Colors.deepOrange,
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate('register'),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: title)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        InkWell(
                          onTap: () {
                            //widget.registerToggleView();
                            // widget.mcq();
                          },
                          child: RichText(
                            text: new TextSpan(
                              style: new TextStyle(
                                  fontSize: footer,
                                  color: Colors.black,
                                  fontFamily: lang == 'ar'
                                      ? 'noto_arabic'
                                      : 'Helvetica'),
                              children: <TextSpan>[
                                TextSpan(
                                  text: AppLocalizations.of(context)
                                      .translate('does_have_account'),
                                ),
                                TextSpan(
                                    text: AppLocalizations.of(context)
                                        .translate('sign_in'),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent)),
                              ],
                            ),
                          ),
                        ),
                      ],
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
