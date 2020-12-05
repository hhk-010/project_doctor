import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/matching_algorithm/final_score.dart';
import 'package:project_doctor/pages/patient_pages/patient03_get_location.dart';
import 'package:project_doctor/pages/patient_pages/patient06_result_map.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/database.dart';
import 'package:provider/provider.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/sizing_information.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientResult extends StatefulWidget {
  @override
  _PatientResultState createState() => _PatientResultState();
}

class _PatientResultState extends State<PatientResult> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      double appBarTitle;
      double appBarHeight;
      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
        appBarTitle = 25;
        appBarHeight = 50;
      } else {
        appBarTitle = displayHeight(context) * 0.045;
        appBarHeight = 75;
      }

      return StreamProvider<QuerySnapshot>.value(
        value: DatabaseService().doctorDataProfileStream,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(appBarHeight),
            child: AppBar(
              backgroundColor: Colors.deepOrange,
              title: Text(
                AppLocalizations.of(context).translate("resulted"),
                //'Search Result',
                style: TextStyle(fontSize: appBarTitle, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              elevation: 0,
            ),
          ),
          body: ResultDoctorProfile(),
        ),
      );
    });
  }
}

class ResultDoctorProfile extends StatefulWidget {
  @override
  _ResultDoctorProfileState createState() => _ResultDoctorProfileState();
}

class _ResultDoctorProfileState extends State<ResultDoctorProfile> {
  String _name = '';
  String _speciality = '';
  String _number = '';
  // ignore: unused_field
  String _province = '';
  double _lat = 0.0;
  double _lng = 0.0;
  String _address = '';
  List _workDays01 = [];
  List _workDays02 = [];
  List _workDays03 = [];
  double distance = 0.0;
  double sum = 0.0;
  double result = 0.0;
  double realdistance = 0.0;
  String realdist = '';
  int dotindex = 0;
  String realnearby = '';
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
  // ignore: unused_field
  String _firstfromAmPm = '';
  String _firstTo = '';
  // ignore: unused_field
  String _firstToTime = '';
  String _firstToAmPm = '';
  String _secondfrom = '';
  String _secondfromTime = '';
  String _secondfromAmPm = '';
  String _secondTo = '';
  String _secondToTime = '';
  String _secondToAmPm = '';
  // ignore: unused_field
  String _mainTime = '';
  String _secondTime = '';
  String _firstTime = '';
  int _y = 0;
  int _z = 0;
  String x = '';

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  // String _doctorAddress = '';
  // _getAddressFromLatLng() async {
  //   List<Placemark> p = await geolocator.placemarkFromCoordinates(_lat, _lng);
  //   Placemark place = p[0];
  //   setState(() {
  //     _doctorAddress = "${place.locality}, ${place.country}";
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final doctorListProvider = Provider.of<QuerySnapshot>(context);
    if (doctorListProvider != null) {
      for (var docu in doctorListProvider.docs) {
        sum = ((docu.data()['lat'] - MyVariables.lat) * (docu.data()['lat'] - MyVariables.lat)) +
            ((docu.data()['lng'] - MyVariables.lng) * (docu.data()['lng'] - MyVariables.lng));
        result = sqrt(sum);
        if (result > distance && (FinalScore.speciality == docu.data()['speciality'] || FinalScore.speciality2 == docu.data()['speciality'])) {
          setState(() {
            distance = result;
          });
        }
      }
      for (var docu in doctorListProvider.docs) {
        sum = ((docu.data()['lat'] - MyVariables.lat) * (docu.data()['lat'] - MyVariables.lat)) +
            ((docu.data()['lng'] - MyVariables.lng) * (docu.data()['lng'] - MyVariables.lng));
        result = sqrt(sum);

        if (result <= distance && (FinalScore.speciality == docu.data()['speciality'] || FinalScore.speciality2 == docu.data()['speciality'])) {
          setState(() {
            distance = result;
            _name = docu.data()['name'];
            _speciality = docu.data()['speciality'];
            _number = docu.data()['phoneNumber'];
            _province = docu.data()['province'];
            _lat = docu.data()['lat'];
            _lng = docu.data()['lng'];
            _address = docu.data()['address'];
            _workDays01 = docu.data()['workDays01'];
            _workDays02 = docu.data()['workDays02'];
            _workDays03 = docu.data()['workDays03'];
            realdistance = distance * 100;
            realdist = realdistance.toString();
            dotindex = realdist.indexOf('.') + 3;
            realnearby = realdist.substring(0, dotindex);
            _y = _workDays01.length - 1;
            //for (String x in _workDays01)
            while (_y > 0) {
              x = _workDays01[_z];
              if (x.length < 11) {
                _mainDaysTranslation = AppLocalizations.of(context).translate(x);
                if (_mainDays == '') {
                  _mainDays = _mainDaysTranslation;
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
            if (_workDays02.isEmpty && _workDays02.length == 2) {
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
                  _mainfromAmPm +
                  ' ' +
                  AppLocalizations.of(context).translate('to') +
                  _mainToTime +
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
          });
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
        buttonHeight = displayHeight(context) * 0.04;
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
                  child: Column(
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
                        child: Text(
                          _name,
                          style: _textStyle.copyWith(fontSize: title, fontFamily: 'noto_arabic'),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text(
                          // _doctorAddress,
                          AppLocalizations.of(context).translate(_province),
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
                        AppLocalizations.of(context).translate(_speciality),
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
                      GestureDetector(
                        onTap: () => setState(() {
                          _makePhoneCall('tel:$_number');
                        }),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_forward, color: Colors.indigo,),
                            SizedBox(width: 10,),
                             Icon(Icons.phone, color: Colors.deepOrange,),
                            SizedBox(width: 10,),
                            Text(
                              _number,
                              style: _textStyle,
                            ),
                          ],
                        ),
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
                      Text(
                        _finalMainDays,
                        style: _textStyle,
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
                      Text(
                        AppLocalizations.of(context).translate("distances"),
                        //'Distance to the Doctor is about ',
                        style: TextStyle(fontSize: footer, color: Colors.indigo, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        realnearby + AppLocalizations.of(context).translate("km"), //' Km away',
                        style: _textStyle,
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
                child: RaisedButton.icon(
                  color: Colors.deepOrange,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PatientResultMap(
                              lat: _lat,
                              lng: _lng,
                            )));
                  },
                  label: Text(
                    AppLocalizations.of(context).translate("doctor_locat"),
                    //'View Doctor Location',
                    style: TextStyle(color: Colors.white, fontSize: subTitle, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
