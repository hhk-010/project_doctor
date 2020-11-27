import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_doctor/pages/doctor_pages/doctor05_update_form.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/services/database.dart';
import 'package:provider/provider.dart';

class DoctorProfile extends StatefulWidget {
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().doctorDataProfileStream,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepOrange,
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              AppLocalizations.of(context).translate('profile'),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                //i changed it because it is not defined on my device
                Icons.account_box_rounded,
              ),
              onPressed: () async {
                await _auth.signOut();
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: DoctorList(),
      ),
    );
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
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  String _doctorAddress = '';
  _getAddressFromLatLng() async {
    List<Placemark> p = await geolocator.placemarkFromCoordinates(lat, lng);
    Placemark place = p[0];
    setState(() {
      _doctorAddress = "${place.locality}, ${place.country}";
    });
  }

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
    TextStyle _textStyle = TextStyle(
        fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold);
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
              _mainfromAmPm = AppLocalizations.of(context).translate(
                  _mainfrom.substring(
                      _mainfrom.indexOf(' ') + 1, _mainfrom.indexOf('M') + 1));
              _mainToTime = _mainTo.substring(0, _mainTo.indexOf(' '));
              _mainToAmPm = AppLocalizations.of(context).translate(
                  _mainTo.substring(_mainTo.indexOf(' ') + 1, _mainTo.length));
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
            _firstfrom = _workDays02[1].substring(
                _workDays02[1].indexOf('m') + 2,
                _workDays02[1].indexOf('t') - 1);
            _firstTo = _workDays02[1].substring(
                _workDays02[1].indexOf('t') + 3, _workDays02[1].length);
            _firstfromTime = _firstfrom.substring(0, _firstfrom.indexOf(' '));
            _firstfromAmPm = AppLocalizations.of(context).translate(_firstfrom
                .substring(_firstfrom.indexOf(' ') + 1, _firstfrom.length));
            _firstToTime = _firstTo.substring(0, _firstTo.indexOf(' '));
            _firstToAmPm = AppLocalizations.of(context).translate(
                _firstTo.substring(_firstTo.indexOf(' ') + 1, _firstTo.length));
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
            _secondEDay =
                AppLocalizations.of(context).translate(_workDays03[0]);
            _secondfrom = _workDays03[1].substring(
                _workDays03[1].indexOf('m') + 2,
                _workDays03[1].indexOf('t') - 1);
            _secondTo = _workDays03[1].substring(
                _workDays03[1].indexOf('t') + 3, _workDays03[1].length);
            _secondfromTime =
                _secondfrom.substring(0, _secondfrom.indexOf(' '));
            _secondfromAmPm = AppLocalizations.of(context).translate(_secondfrom
                .substring(_firstfrom.indexOf(' ') + 1, _firstfrom.length));
            _secondToTime = _secondTo.substring(0, _secondTo.indexOf(' '));
            _secondToAmPm = AppLocalizations.of(context).translate(_secondTo
                .substring(_secondTo.indexOf(' ') + 1, _secondTo.length));
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
        }
      }
      _getAddressFromLatLng();
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(30, 25, 30, 0),
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
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/doctor.png'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      name,
                      style: _textStyle.copyWith(
                          fontSize: 25, fontFamily: 'noto_arabic'),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      _doctorAddress,
                      //AppLocalizations.of(context).translate(province),
                      style: _textStyle.copyWith(fontSize: 14),
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
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold),
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
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold),
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
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold),
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
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold),
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
                                AppLocalizations.of(context)
                                    .translate('another_clinic_work'),
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  _firstEDay +
                                      " " +
                                      _firstTime +
                                      '\n' +
                                      _secondEDay +
                                      " " +
                                      _secondTime,
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
            height: 50,
          ),
          Container(
            height: 40,
            width: double.maxFinite,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              child: Text(
                AppLocalizations.of(context).translate('update_info'),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              color: Colors.deepOrange,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Updateinfo()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
