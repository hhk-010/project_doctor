import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/pages/doctor_pages/doctor05_update_form.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/services/database.dart';
import 'package:provider/provider.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/sizing_information.dart';

class DoctorProfile extends StatefulWidget {
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  final AuthService _auth = AuthService();

  bool _isInternet = true;
  String _error = '';
  //================================================
  checkInternet() async {
    try {
      final response = await InternetAddress.lookup('google.com');
      if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
        _isInternet = true; // internet
        setState(() {});
      }
    } on SocketException catch (_) {
      // no internet
      setState(() {
        _isInternet = false;
      });
    }
  }

  //================================================
  _showSnackBar() {
    var lang = Localizations.localeOf(context).languageCode;
    final _snackBar = new SnackBar(
      content: Text(
        _error,
        style: TextStyle(fontSize: 15, fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
      ),
      backgroundColor: Colors.deepOrange,
    );
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }

//=================================================
  @override
  void initState() {
    super.initState();
    checkInternet();
    Empty.isEmpty = false;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      double appBarTitle;
      double appBarHeight;
      double appBarIcon;

      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
        appBarTitle = 25;
        appBarHeight = 50;
        appBarIcon = 25;
      } else {
        appBarTitle = displayHeight(context) * 0.03;
        appBarHeight = 80;
        appBarIcon = 30;
      }
      return StreamProvider<QuerySnapshot>.value(
        initialData: null,
        value: DatabaseService().usersDataStream,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(appBarHeight),
            child: AppBar(
              centerTitle: true,
              backgroundColor: Colors.deepOrange,
              title: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  AppLocalizations.of(context).translate('profile'),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: appBarTitle),
                ),
              ),
              elevation: 0,
              actions: [
                IconButton(
                  icon: Icon(Icons.person_remove),
                  tooltip: AppLocalizations.of(context).translate('delete_user'),
                  iconSize: appBarIcon,
                  onPressed: () {
                    Navigator.pushNamed(context, '/pre_delete');
                  },
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                IconButton(
                  icon: Icon(
                    //i changed it because it is not defined on my device
                    Icons.logout,
                  ),
                  tooltip: AppLocalizations.of(context).translate('log_out'),
                  iconSize: appBarIcon,
                  onPressed: () async {
                    if (_isInternet) {
                      await _auth.signOut();
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        _error = AppLocalizations.of(context).translate('snack_connectivity');
                      });
                      _showSnackBar();
                    }
                  },
                ),
              ],
            ),
          ),
          body: DoctorList(),
        ),
      );
    });
  }
}

class DoctorList extends StatefulWidget {
  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  String name = '';
  String speciality = '';
  String number = '';
  String province = '';
  double lat = 0.0;
  double lng = 0.0;
  String _address = '';
  List<String> _workDays01 = [];
  List<String> _workDays02 = [];
  List<String> _workDays03 = [];
  String _mainDaysTranslation = '';
  String _mainDays = '';
  String _finalMainDays = '';
  String _firstEDay = '';
  String _secondEDay = '';
  String _mainfrom = '';
  String _mainfromTime = '';
  String _mainfromAmPm = '';
  String _mainTo = '';
  String _mainToTime = '';
  String _mainToAmPm = '';
  String _firstfrom = '';
  String _firstfromTime = '';
  String _firstfromAmPm = '';
  String _firstTo = '';
  String _firstToTime = '';
  String _firstToAmPm = '';
  String _secondfrom = '';
  String _secondfromTime = '';
  String _secondfromAmPm = '';
  String _secondTo = '';
  String _secondToTime = '';
  String _secondToAmPm = '';
  String _mainTime = '';
  String _secondTime = '';
  String _firstTime = '';
  String x = '';
  int _z = 0;
  int _y = 0;

//get the user address from lat and lng
  // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  //String _doctorAddress = '';
  //_getAddressFromLatLng() async {
  //   List<Placemark> p = await geolocator.placemarkFromCoordinates(lat, lng);
  //   Placemark place = p[0];
  //   setState(() {
  //     _doctorAddress = "${place.locality}, ${place.country}";
  //  });
  // }

  @override
  void initState() {
    super.initState();
    setState(() {
      _mainDays = '';
      _y = 0;
      _workDays01 = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    var uid = FirebaseAuth.instance.currentUser.uid;
    final doctorListProvider = Provider.of<QuerySnapshot>(context);
    if (doctorListProvider != null) {
      for (var doc in doctorListProvider.docs) {
        if (doc.id == uid) {
          setState(() {
            name = doc.data()['name'];
            speciality = doc.data()['speciality'];
            number = doc.data()['phoneNumber'];
            province = doc.data()['province'];
            DatabaseService.preDeleteProvince = doc.data()['province'];
            lat = doc.data()['lat'];
            lng = doc.data()['lng'];
            _address = doc.data()['address'];
            _workDays01 = List<String>.from(doc.data()['workDays01']);
            _workDays02 = List<String>.from(doc.data()['workDays02']);
            _workDays03 = List<String>.from(doc.data()['workDays03']);
          });
          _y = _workDays01.length - 1;
          while (_y >= 0) {
            //for (String x in _workDays01)
            x = _workDays01[_z];
            if (x.length < 11) {
              _mainDaysTranslation = AppLocalizations.of(context).translate(x);
              if (_mainDays == '') {
                _mainDays = _mainDaysTranslation;
                print(_mainDays);
              } else {
                _mainDays = _mainDays + ', ' + _mainDaysTranslation;
                _finalMainDays = _mainDays;
              }
            } else {
              _mainfrom = x.substring(x.indexOf('m') + 2, x.indexOf('t') - 1);
              _mainTo = x.substring(x.indexOf('t') + 3, x.length);
              _mainfromTime = _mainfrom.substring(0, _mainfrom.indexOf(' '));
              _mainfromAmPm = AppLocalizations.of(context).translate(_mainfrom.substring(_mainfrom.indexOf(' ') + 1, _mainfrom.indexOf('M') + 1));
              _mainToTime = _mainTo.substring(0, _mainTo.indexOf(' '));
              _mainToAmPm = AppLocalizations.of(context).translate(_mainTo.substring(_mainTo.indexOf(' ') + 1, _mainTo.length));
              _mainTime = AppLocalizations.of(context).translate('from') +
                  _mainfromTime +
                  ' ' +
                  _mainfromAmPm +
                  ' ' +
                  AppLocalizations.of(context).translate('to') +
                  _mainToTime +
                  ' ' +
                  _mainToAmPm;
            }
            _y -= 1;
            _z += 1;
          }
          _y = 0;
          _z = 0;
          _workDays01 = [];
          _mainDays = '';
          if (_workDays02.isNotEmpty && _workDays02.length == 2) {
            _firstEDay = AppLocalizations.of(context).translate(_workDays02[0]);
            _firstfrom = _workDays02[1].substring(_workDays02[1].indexOf('m') + 2, _workDays02[1].indexOf('t') - 1);
            _firstTo = _workDays02[1].substring(_workDays02[1].indexOf('t') + 3, _workDays02[1].length);
            _firstfromTime = _firstfrom.substring(0, _firstfrom.indexOf(' '));
            _firstfromAmPm = AppLocalizations.of(context).translate(_firstfrom.substring(_firstfrom.indexOf(' ') + 1, _firstfrom.length));
            _firstToTime = _firstTo.substring(0, _firstTo.indexOf(' '));
            _firstToAmPm = AppLocalizations.of(context).translate(_firstTo.substring(_firstTo.indexOf(' ') + 1, _firstTo.length));
            _firstTime = AppLocalizations.of(context).translate('from') +
                _firstfromTime +
                ' ' +
                _firstfromAmPm +
                ' ' +
                AppLocalizations.of(context).translate('to') +
                _firstToTime +
                ' ' +
                _firstToAmPm;
          }
          if (_workDays03.isNotEmpty && _workDays03.length == 2) {
            _secondEDay = AppLocalizations.of(context).translate(_workDays03[0]);
            _secondfrom = _workDays03[1].substring(_workDays03[1].indexOf('m') + 2, _workDays03[1].indexOf('t') - 1);
            _secondTo = _workDays03[1].substring(_workDays03[1].indexOf('t') + 3, _workDays03[1].length);
            _secondfromTime = _secondfrom.substring(0, _secondfrom.indexOf(' '));
            _secondfromAmPm = AppLocalizations.of(context).translate(_secondfrom.substring(_firstfrom.indexOf(' ') + 1, _firstfrom.length));
            _secondToTime = _secondTo.substring(0, _secondTo.indexOf(' '));
            _secondToAmPm = AppLocalizations.of(context).translate(_secondTo.substring(_secondTo.indexOf(' ') + 1, _secondTo.length));
            _secondTime = AppLocalizations.of(context).translate('from') +
                _secondfromTime +
                ' ' +
                _secondfromAmPm +
                ' ' +
                AppLocalizations.of(context).translate('to') +
                _secondToTime +
                ' ' +
                _secondToAmPm;
          }
          if ((doc.data()['name'] == '' || doc.data()['name'] == null) &&
              (doc.data()['speciality'] == '' || doc.data()['speciality'] == null) &&
              (doc.data()['phoneNumber'] == '' || doc.data()['phoneNumber'] == null) &&
              (doc.data()['address'] == '' || doc.data()['address'] == null)) {
            setState(() {
              Empty.isEmpty = true;
            });
          }
        }
      }
      // _getAddressFromLatLng();
    }

    return ResponsiveBuilder(builder: (context, sizingInformation) {
      double containerWidth;
      double buttonHeight;
      double buttonWidth;
      double title;
      double subTitle;
      double footer;
      double avatarSize;
      double containerInset;

      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
        containerWidth = displayWidth(context) * 0.85;
        title = displayWidth(context) * 0.05;
        subTitle = displayWidth(context) * 0.04;
        buttonHeight = displayHeight(context) * 0.05;
        buttonWidth = displayWidth(context) * 0.7;
        footer = displayWidth(context) * 0.025;
        avatarSize = 50;
        containerInset = 25;
      } else {
        containerWidth = displayWidth(context) * 0.6;
        title = displayWidth(context) * 0.045;
        subTitle = displayWidth(context) * 0.03;
        buttonHeight = displayHeight(context) * 0.045;
        buttonWidth = displayWidth(context) * 0.4;
        footer = displayWidth(context) * 0.02;
        avatarSize = 70;
        containerInset = 50;
      }
      TextStyle _textStyle = TextStyle(fontSize: subTitle, color: Colors.black, fontWeight: FontWeight.bold);

      return Center(
        child: Container(
          width: containerWidth,
          padding: EdgeInsets.only(top: containerInset),
          child: ListView(
            children: [
              Container(
                decoration: boxDecoration,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Empty.isEmpty
                      ? Column(
                          children: [
                            Text(
                              AppLocalizations.of(context).translate('prof_error'),
                              style: TextStyle(fontSize: title, color: Colors.deepOrange),
                            ),
                            Text(
                              AppLocalizations.of(context).translate('data_error'),
                              style: TextStyle(fontSize: subTitle),
                            ),
                            //Text(AppLocalizations.of(context).translate('re_sign'),style: TextStyle(fontSize: subTitle),),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: CircleAvatar(
                                backgroundColor: Colors.deepOrange,
                                radius: avatarSize,
                                backgroundImage: AssetImage('assets/images/doctor.png'),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  name,
                                  style: _textStyle.copyWith(fontSize: title, fontFamily: 'noto_arabic'),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text(
                                // _doctorAddress,
                                AppLocalizations.of(context).translate(province),
                                style: _textStyle.copyWith(fontSize: footer),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              color: Colors.grey[600],
                              thickness: 3,
                              indent: 25,
                              endIndent: 25,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              AppLocalizations.of(context).translate('speciality'),
                              style: TextStyle(fontSize: footer, color: Colors.indigo, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              AppLocalizations.of(context).translate(speciality),
                              style: _textStyle,
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            Text(
                              AppLocalizations.of(context).translate('phoneNumber'),
                              style: TextStyle(fontSize: footer, color: Colors.indigo, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              number,
                              style: _textStyle,
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            Text(
                              AppLocalizations.of(context).translate('clinic_address'),
                              style: TextStyle(fontSize: footer, color: Colors.indigo, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              _address,
                              style: _textStyle.copyWith(fontFamily: 'noto_arabic'),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            Text(
                              AppLocalizations.of(context).translate('clinic_work'),
                              style: TextStyle(fontSize: footer, color: Colors.indigo, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                _finalMainDays + '\n' + _mainTime,
                                style: _textStyle,
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            _workDays02.isEmpty
                                ? SizedBox(
                                    height: 5,
                                  )
                                : Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context).translate('another_clinic_work'),
                                          style: TextStyle(fontSize: footer, color: Colors.indigo, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Text(
                                            _firstEDay + " " + _firstTime + '\n' + _secondEDay + " " + _secondTime,
                                            style: _textStyle,
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.grey,
                                          thickness: 1,
                                          indent: 0,
                                          endIndent: 0,
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: buttonHeight,
                width: buttonWidth,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    backgroundColor: Colors.deepOrange,
                  ),
                  child: Text(
                    AppLocalizations.of(context).translate('update_info'),
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: subTitle),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Updateinfo(
                              profileName: name,
                              profileSpeciality: speciality,
                            )));
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class Empty {
  static bool isEmpty = false;
}
