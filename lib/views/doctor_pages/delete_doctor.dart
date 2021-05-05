import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_doctor/services/theme.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/views/authorization/loading.dart';

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
        style: TextStyle(
            fontSize: 15,
            fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
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
    return
       Scaffold(
        key: _scaffoldkey,
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.deepOrange,
            title: Text(
              AppLocalizations.of(context)
                  .translate("delete_user"), //'Password Reset',
              style:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                            decoration: textInputdecoration.copyWith(
                              hintText: AppLocalizations.of(context).translate(
                                  'enter_your_email'), //'Enter Your Current Email',
                              labelText: AppLocalizations.of(context)
                                  .translate('email'), //'Email',
                            ),
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (val) {
                              email = val;
                            },
                            validator: (val) => val.isEmpty
                                ? AppLocalizations.of(context)
                                    .translate('enter_your_email')
                                : null,
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        backgroundcolor: Colors.deepOrange,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            AppLocalizations.of(context).translate('delete'),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onpressed: () async {
                          checkInternet();
                          if (_isInternet) {
                            if (_formkey.currentState.validate()) {
                              setState(() => isloading = true);
                              dynamic authResult = await AuthService()
                                  .deleteUser(email, oldPassword);
                              if (authResult != null) {
                                setState(() => isloading = false);
                                int count = 0;
                                Navigator.popUntil(context, (route) {
                                  return count++ == 2;
                                });
                              } else {
                                setState(() {
                                  isloading = false;
                                  error = AppLocalizations.of(context)
                                      .translate('can_not_delete');
                                });
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
                      ),
                    ),
                  ],
                )),
          ),
        ),
      );
     
  
  }
}
