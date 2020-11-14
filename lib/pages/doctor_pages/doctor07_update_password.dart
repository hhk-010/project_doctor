import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/auth.dart';
import '../../services/auth.dart';

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

  //------------the end --------------------
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
    _passwordVisible = false;
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
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            AppLocalizations.of(context).translate('update_password'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: Container(
        height: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 75.0, horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                decoration: textInputdecoration.copyWith(
                  hintText: AppLocalizations.of(context)
                      .translate('current_password'),
                  labelText:
                      AppLocalizations.of(context).translate('old_password'),
                ),
                onChanged: (val) {
                  _oldPassword = val;
                },
                validator: (val) => val.length < 8
                    ? AppLocalizations.of(context).translate('valid_password')
                    : null,
              ),
              Spacer(),
              TextFormField(
                obscureText: !_passwordVisible,
                onChanged: (val) {
                  setState(() => _newPassword = val);
                },
                decoration: textInputdecoration.copyWith(
                  hintText: AppLocalizations.of(context)
                      .translate('new_password_hint'),
                  labelText:
                      AppLocalizations.of(context).translate('new_password'),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.deepOrange,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                validator: (val) => val.length < 8
                    ? AppLocalizations.of(context)
                        .translate('password_validator')
                    : null,
              ),
              Spacer(
                flex: 5,
              ),
              ButtonTheme(
                minWidth: double.infinity,
                height: 45,
                child: RaisedButton.icon(
                  color: Colors.deepOrange,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  onPressed: () async {
                    checkInternet();
                    if (_isInternet) {
                      if (_formkey.currentState.validate()) {
                        AuthService().passwordisvalid(_oldPassword);
                        passwordvalid =
                            await AuthService().validatepass(_oldPassword);
                        if (passwordvalid) {
                          AuthService().updatepass(_newPassword);
                          //====when using push masterial page rout to the profle
                          // there will be routing errors
                          /*Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DoctorProfile()));*/
                          Navigator.pop(context);
                        } else {
                          setState(() {
                            error = AppLocalizations.of(context)
                                .translate('invalid_password');
                          });
                          //--------snackbar problem
                          _showSnackBar();
                        }
                      }
                    } else {
                      setState(() {
                        error = AppLocalizations.of(context)
                            .translate('snack_connectivity');
                      });
                      _showSnackBar();
                    }
                  },
                  label: Text(
                    AppLocalizations.of(context).translate('update'),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: Text(
                    '',
                    //error,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
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
