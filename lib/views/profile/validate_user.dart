import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/constants/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/views/auth/loading.dart';
import 'package:project_doctor/views/profile/delete_doctor.dart';
import '../../services/auth.dart';

class PreDeleteUser extends StatefulWidget {
  @override
  _PreDeleteUserState createState() => _PreDeleteUserState();
}

class _PreDeleteUserState extends State<PreDeleteUser> {
  String _oldPassword;
  //String _newPassword;
  bool passwordvalid;
  String error = '';
  // ignore: unused_field
  bool _passwordVisible = true;
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
    ScaffoldMessenger.of(context).showSnackBar(_snackbar);
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
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.deepOrange,
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              LocaleKeys.view_doctor_predelete_password.tr(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
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
                ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 100,
                      child: Image(
                        image: AssetImage(
                          'assets/images/delete.png',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      obscureText: !_passwordVisible,
                      decoration: CStyle.getInputDecoration(context).copyWith(
                        hintText: LocaleKeys.view_doctor_current_password.tr(),
                        labelText: LocaleKeys.view_doctor_current_password.tr(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.deepOrange,
                          ),
                          onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
                        ),
                      ),
                      onChanged: (val) {
                        _oldPassword = val;
                      },
                      validator: (val) => val.length < 8 ? LocaleKeys.view_doctor_valid_password.tr() : null,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    /*TextFormField(
                        obscureText: !_passwordVisible,
                        onChanged: (val) {
                          setState(() => _newPassword = val);
                        },
                        decoration: CStyle.getInputDecoration(context).copyWith(
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
                      ),*/
                  ],
                ),
                Container(
                  height: 50,
                  width: !isloading ? 150 : 50,
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
                            //AuthService().updatepass(_newPassword);
                            setState(() => isloading = false);
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeleteUser(oldPassword: _oldPassword)));
                            /*int count = 0;
                              Navigator.popUntil(context, (route) {
                                return count++ == 2;
                              });*/
                          } else {
                            setState(() {
                              isloading = false;
                              error = LocaleKeys.view_doctor_invalid_password.tr();
                            });
                            //--------snackbar problem
                            _showSnackBar();
                          }
                        }
                      } else {
                        setState(() {
                          error = LocaleKeys.view_snack_error_snack_connectivity.tr();
                        });
                        _showSnackBar();
                      }
                    },
                    label: Text(
                      LocaleKeys.view_doctor_delete.tr(),
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}