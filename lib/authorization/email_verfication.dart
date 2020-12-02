import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/pages/doctor_pages/doctor03_map.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/services/database.dart';
import 'package:project_doctor/services/readerwriter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class for getting the data from map to firebase through verfication.
class EmailVerification extends StatefulWidget {
  final Storage dataReadStorage = Storage();
  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool loading = false;
  String _email = '';
  String _name = '';
  String _speciality = '';
  String _phoneNumber = '';
  String _province = '';
  String _address = '';
  double _lat = 0.0;
  double _lng = 0.0;
  List _workDays01 = [];
  List _workDays02 = [];
  List _workDays03 = [];

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

// snackbar function
  String error = '';
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    var lang = Localizations.localeOf(context).languageCode;
    final _snackBar = new SnackBar(
      content: Text(
        error,
        style: TextStyle(
            fontSize: 15,
            fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
      ),
      backgroundColor: Colors.deepOrange,
    );
    _scaffoldkey.currentState.showSnackBar(_snackBar);
  }

  final AuthService _auth = AuthService();
  Timer _timer;
  /*_readDoctorInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (FirebaseAuth.instance.currentUser.email == prefs.getString('email')) {
      setState(() {
        _email = prefs.getString('email') ?? '';
        _name = prefs.getString('name') ?? '';
        _speciality = prefs.getString('speciality') ?? '';
        _phoneNumber = prefs.getString('phoneNumber') ?? '';
        _province = prefs.getString('province') ?? '';
        _address = prefs.getString('address') ?? '';
        _lat = prefs.getDouble('lat') ?? 0.0;
        _lng = prefs.getDouble('lng') ?? 0.0;
        _workDays01 = prefs.getStringList('workDays01') ?? [];
        _workDays02 = prefs.getStringList('workDays02') ?? [];
        _workDays03 = prefs.getStringList('workDays03') ?? [];
      });
    }
  }*/

  @override
  void initState() {
    super.initState();
    checkInternet();
    Future(() async {
      _timer = Timer.periodic(Duration(seconds: 10), (timer) async {
        FirebaseAuth.instance.currentUser..reload();
      });
    });
    //_readDoctorInfo();
    _email = FirebaseAuth.instance.currentUser.email;

    //-------reading data---------

    widget.dataReadStorage.readName().then((String value) {
      setState(() {
        _name = value;
      });
    });

    widget.dataReadStorage.readSpeciality().then((String value) {
      setState(() {
        _speciality = value;
      });
    });

    widget.dataReadStorage.readNumber().then((String value) {
      setState(() {
        _phoneNumber = value;
      });
    });

    widget.dataReadStorage.readProvince().then((String value) {
      setState(() {
        _province = value;
      });
    });

    widget.dataReadStorage.readAddress().then((String value) {
      setState(() {
        _address = value;
      });
    });
//====================lat to list==========================
    widget.dataReadStorage.readLat().then((double value) {
      setState(() {
        _lat = value;
      });
    });

    widget.dataReadStorage.readLng().then((double value) {
      setState(() {
        _lng = value;
      });
    });

    widget.dataReadStorage.workDays01reader().then((List value) {
      setState(() {
        _workDays01 = value;
      });
    });

    widget.dataReadStorage.readWorkDays02().then((List value) {
      setState(() {
        _workDays02 = value;
      });
    });

    widget.dataReadStorage.readWorkDays03().then((List value) {
      setState(() {
        _workDays03 = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          AppLocalizations.of(context).translate("email_v_title"),
          //'Email Confirmation',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              //========changed beacause it is not defined on my device
              Icons.account_box,
            ),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Container(
        height: double.maxFinite,
        padding: EdgeInsets.fromLTRB(50, 75, 50, 25),
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: Image(
                image: AssetImage('assets/images/email.png'),
              ),
            ),
            Spacer(
              flex: 3,
            ),
            Text(
              AppLocalizations.of(context).translate('email_sent'),
              //'We Sent an Email to: ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Spacer(
              flex: 1,
            ),
            Text(
              _email,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Spacer(
              flex: 2,
            ),
            Text(
              AppLocalizations.of(context).translate("confirm"),
              //'Check your email and click on the confirmation link then',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
            Spacer(
              flex: 3,
            ),
            Container(
              height: 40,
              width: 200,
              child: RaisedButton.icon(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                color: Colors.deepOrange,
                label: Text(
                    AppLocalizations.of(context)
                        .translate("continue"), //'Continue',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                onPressed: () async {
                  checkInternet();
                  if (_isInternet) {
                    if (FirebaseAuth.instance.currentUser.emailVerified) {
                      /*if (DataFromMaptoVerify.email != '' &&
                          DataFromMaptoVerify.name != '' &&
                          DataFromMaptoVerify.speciality != '' &&
                          DataFromMaptoVerify.address != '' &&
                          DataFromMaptoVerify.workDays01 != [] &&
                          DataFromMaptoVerify.lattt != 0.0 &&
                          DataFromMaptoVerify.lnggg != 0.0) {
                        setState(() {
                          _name = DataFromMaptoVerify.name;
                          _speciality = DataFromMaptoVerify.speciality;
                          _phoneNumber = DataFromMaptoVerify.phoneNumber;
                          _province = DataFromMaptoVerify.province;
                          _address = DataFromMaptoVerify.address;
                          _workDays01 = DataFromMaptoVerify.workDays01;
                          _workDays02 = DataFromMaptoVerify.workDays02;
                          _workDays03 = DataFromMaptoVerify.workDays03;
                          _lat = DataFromMaptoVerify.lattt;
                          _lng = DataFromMaptoVerify.lnggg;
                        });
                      }*/
                      await DatabaseService(
                              uid: FirebaseAuth.instance.currentUser.uid)
                          .updateUserData(
                              _name,
                              _speciality,
                              _phoneNumber,
                              _province,
                              _lat,
                              _lng,
                              _address,
                              _workDays01,
                              _workDays02,
                              _workDays03);
                      /*SharedPreferences rprefs =
                          await SharedPreferences.getInstance();
                      setState(() {
                        rprefs.remove('name');
                        rprefs.remove('speciality');
                        rprefs.remove('phoneNumber');
                        rprefs.remove('province');
                        rprefs.remove('address');
                        rprefs.remove('lat');
                        rprefs.remove('lng');
                        rprefs.remove('workDays01');
                        rprefs.remove('workDays02');
                        rprefs.remove('workDays03');
                      });*/
                      await Navigator.pushNamed(context, '/intermediate');
                    } else {
                      setState(() {
                        error = AppLocalizations.of(context)
                            .translate('snack_verification');
                      });
                      _showSnackBar();
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
            Spacer(
              flex: 2,
            ),
            InkWell(
              onTap: () async {
                await AuthService().resendemail();
              },
              child: RichText(
                textAlign: TextAlign.center,
                text: new TextSpan(
                  style: new TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica',
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    //----text has been changed because if the client clicked resend
                    // for two time with less than one to twe minutes in between
                    // firebase will consider it as unusual activity -----
                    new TextSpan(
                        text: AppLocalizations.of(context)
                            .translate("didnot receive")),
                    //" Didn't receive email ? Please wait for few minutes then "),
                    new TextSpan(
                        text: AppLocalizations.of(context).translate("resend"),
                        //text: 'Resent Email',
                        style: new TextStyle(color: Colors.deepOrange)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
