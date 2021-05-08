import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/views/auth/loading_delete.dart';

class DeleteUser extends StatefulWidget {
  final oldPassword;
  DeleteUser({this.oldPassword});
  @override
  _DeleteUserState createState() => _DeleteUserState(oldPassword: oldPassword);
}

class _DeleteUserState extends State<DeleteUser> {
  final String oldPassword;
  _DeleteUserState({this.oldPassword});
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
            LocaleKeys.view_doctor_delete_user.tr(), //'Password Reset',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
      ),
      body: Center(
        child: Container(
          height: 200,
          width: 200,
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
                          decoration: CStyle.getInputDecoration(context).copyWith(
                            hintText: LocaleKeys.view_doctor_enter_your_email.tr(), //'Enter Your Current Email',
                            labelText: LocaleKeys.view_doctor_email.tr(), //'Email',
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
                    width: isloading ? 50 : 20,
                    child: LoadingButton(
                      isloading: isloading,
                      loadercolor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      backgroundcolor: Colors.deepOrange,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          LocaleKeys.view_doctor_delete.tr(),
                          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      onpressed: () async {
                        checkInternet();
                        if (_isInternet) {
                          if (_formkey.currentState.validate()) {
                            setState(() => isloading = true);
                            dynamic authResult = await AuthService().deleteUser(email, oldPassword);
                            if (authResult != null) {
                              setState(() => isloading = false);
                              int count = 0;
                              Navigator.popUntil(context, (route) {
                                return count++ == 2;
                              });
                            } else {
                              setState(() {
                                isloading = false;
                                error = LocaleKeys.view_snack_error_can_not_delete.tr();
                              });
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
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
