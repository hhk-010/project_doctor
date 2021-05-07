import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/constants/locale_keys.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/services/database.dart';
import 'package:project_doctor/services/read_write_path.dart';
import 'package:project_doctor/views/auth/loading.dart';
import 'package:easy_localization/easy_localization.dart';

// class for getting the data from map to firebase through verfication.
class EmailVerification extends StatefulWidget {
  final Storage dataReadStorage = Storage();
  static String province = '';
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
        style: TextStyle(fontSize: 15, fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
      ),
      backgroundColor: Colors.deepOrange,
    );
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }

  final AuthService _auth = AuthService();
  Timer _timer;
//================isLoading=========
  bool isLoading = false;
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
        EmailVerification.province = value;
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
    return Scaffold(
      key: _scaffoldkey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            LocaleKeys.view_email_verification_email_v_title.tr(),
            //'Email Confirmation',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.person_remove),
                onPressed: () {
                  Navigator.pushNamed(context, '/pre_delete');
                }),
            IconButton(
              icon: Icon(
                  //========changed beacause it is not defined on my device
                  Icons.logout),
              onPressed: () async {
                if (_isInternet) {
                  await _auth.signOut();
                  Navigator.pop(context);
                } else {
                  setState(() {
                    error = LocaleKeys.view_snack_error_snack_connectivity.tr();
                  });
                  _showSnackBar();
                }
              },
            )
          ],
        ),
      ),
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: Image(
                  image: AssetImage('assets/images/email.png'),
                ),
              ),
              Spacer(
                flex: 3,
              ),
              Text(
                LocaleKeys.view_email_verification_email_sent.tr(),
                //'We Sent an Email to: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                decoration: CStyle.box,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _email,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
                width: 20,
                child: Text(
                  LocaleKeys.view_email_verification_confirm,
                  //'Check your email and click on the confirmation link then',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(
                flex: 3,
              ),
              Container(
                height: 50,
                width: isLoading ? 50 : 150,
                child: LoadingButtonIcon(
                  isloading: isLoading,
                  loadercolor: Colors.white,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                  backgroundcolor: Colors.deepOrange,
                  label: Text(LocaleKeys.view_email_verification_continue.tr(), //'Continue',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  onpressed: () async {
                    checkInternet();
                    if (_isInternet) {
                      setState(() => isLoading = true);
                      if (FirebaseAuth.instance.currentUser.emailVerified) {
                        await DatabaseService(uid: FirebaseAuth.instance.currentUser.uid)
                            .updateUserData(_name, _speciality, _phoneNumber, _province, _lat, _lng, _address, _workDays01, _workDays02, _workDays03);
                        setState(() => isLoading = false);
                        await Navigator.pushNamed(context, '/intermediate');
                      } else {
                        setState(() {
                          isLoading = false;
                          error = LocaleKeys.view_snack_error_snack_verification.tr();
                        });
                        _showSnackBar();
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
                    style: new TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      //----text has been changed because if the client clicked resend
                      // for two time with less than one to twe minutes in between
                      // firebase will consider it as unusual activity -----
                      new TextSpan(
                        text: LocaleKeys.view_email_verification_didnot_receive.tr(),
                      ),
                      //" Didn't receive email ? Please wait for few minutes then "),
                      new TextSpan(
                          text: LocaleKeys.view_email_verification_resend.tr(),

                          //text: 'Resent Email',
                          style: new TextStyle(color: Colors.deepOrange)),
                    ],
                  ),
                ),
              ),
            ],
          ),
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