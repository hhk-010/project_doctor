import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'dart:io';
import '../pages/doctor_pages/doctor01_form.dart';

class Register extends StatefulWidget {
  final Function toogleView;
  final Function mcq;
  Register({this.toogleView, this.mcq});
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
  TextStyle _textStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      key: _scaffoldkey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: FittedBox(
            fit: BoxFit.fitWidth, child: Text(AppLocalizations.of(context).translate('register'), style: _textStyle.copyWith(fontSize: 25))),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        height: double.maxFinite,
        child: Padding(
          padding: EdgeInsets.fromLTRB(50, 75, 50, 25),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.deepOrangeAccent,
                  radius: 80,
                  backgroundImage: AssetImage('assets/images/register.png'),
                ),
                Spacer(
                  flex: 3,
                ),
                TextFormField(
                  validator: (val) => val.isEmpty ? AppLocalizations.of(context).translate('enter_your_email') : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.emailAddress,
                  decoration: textInputdecoration.copyWith(
                    hintText: AppLocalizations.of(context).translate('enter_your_email'),
                    labelText: AppLocalizations.of(context).translate('email'),
                  ),
                ),
                Spacer(),
                TextFormField(
                  validator: (val) => val.length < 8 ? AppLocalizations.of(context).translate('password_validator') : null,
                  //? 'Enter a password 8 or long'
                  obscureText: !_passwordVisible,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  decoration: textInputdecoration.copyWith(
                    hintText: AppLocalizations.of(context).translate('enter_your_password'),
                    labelText: AppLocalizations.of(context).translate('password'),
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
                Spacer(
                  flex: 5,
                ),
                Builder(builder: (context) {
                  return Container(
                    height: 40.0,
                    width: 200.0,
                    child: RaisedButton(
                      onPressed: _isInternet
                          ? () async {
                              print(ModalRoute.of(context));
                              if (_formKey.currentState.validate()) {
                                if (email != '' && password != '') {
                                  if (ModalRoute.of(context) != false) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => DoctorForm(
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
                                  AppLocalizations.of(context).translate('snack_connectivity'),
                                  style: TextStyle(fontSize: 15, fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
                                ),
                                backgroundColor: Colors.deepOrange,
                              );
                              Scaffold.of(context).showSnackBar(errorSnackBar);
                            },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      color: Colors.deepOrange,
                      child: Text(AppLocalizations.of(context).translate('register'), style: _textStyle.copyWith(color: Colors.white)),
                    ),
                  );
                }),
                Spacer(),
                Text(error),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                InkWell(
                  onTap: () {
                    //widget.toogleView();
                    widget.mcq();
                  },
                  child: RichText(
                    text: new TextSpan(
                      style: new TextStyle(fontSize: 14.0, color: Colors.black, fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
                      children: <TextSpan>[
                        TextSpan(
                          text: AppLocalizations.of(context).translate('does_have_account'),
                        ),
                        TextSpan(
                            text: AppLocalizations.of(context).translate('sign_in'),
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
                      ],
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
