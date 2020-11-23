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
import 'package:geolocator/geolocator.dart';

class PatientResult extends StatefulWidget {
  @override
  _PatientResultState createState() => _PatientResultState();
}

class _PatientResultState extends State<PatientResult> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().doctorDataProfileStream,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            AppLocalizations.of(context).translate("resulted"),
            //'Search Result',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: ResultDoctorProfile(),
      ),
    );
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
  String _province = '';
  double _lat = 0.0;
  double _lng = 0.0;
  String _address = '';
  // ignore: unused_field
  List _vacation = [];
  List _workinghours = [];
  List _workinghours2 = [];
  double distance = 0.0;
  double sum = 0.0;
  double result = 0.0;
  double realdistance = 0.0;
  String realdist = '';
  int dotindex = 0;
  String realnearby = '';
  String _mainDaysTranslation = '';
  String _mainDays = '';
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

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  String _doctorAddress = '';
  _getAddressFromLatLng() async {
    List<Placemark> p = await geolocator.placemarkFromCoordinates(_lat, _lng);
    Placemark place = p[0];
    setState(() {
      _doctorAddress = "${place.locality}, ${place.country}";
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = TextStyle(
        fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold);
    final doctorListProvider = Provider.of<QuerySnapshot>(context);
    if (doctorListProvider != null) {
      for (var docu in doctorListProvider.docs) {
        sum = ((docu.data()['lat'] - MyVariables.lat) *
                (docu.data()['lat'] - MyVariables.lat)) +
            ((docu.data()['lng'] - MyVariables.long) *
                (docu.data()['lng'] - MyVariables.long));
        result = sqrt(sum);
        if (result > distance &&
            (FinalScore.speciality == docu.data()['speciality'] ||
                FinalScore.speciality2 == docu.data()['speciality'])) {
          setState(() {
            distance = result;
          });
        }
      }
      for (var docu in doctorListProvider.docs) {
        sum = ((docu.data()['lat'] - MyVariables.lat) *
                (docu.data()['lat'] - MyVariables.lat)) +
            ((docu.data()['lng'] - MyVariables.long) *
                (docu.data()['lng'] - MyVariables.long));
        result = sqrt(sum);

        if (result <= distance &&
            (FinalScore.speciality == docu.data()['speciality'] ||
                FinalScore.speciality2 == docu.data()['speciality'])) {
          //setState(() {
          distance = result;
          _name = docu.data()['name'];
          _speciality = docu.data()['speciality'];
          _number = docu.data()['phoneNumber'];
          _province = docu.data()['province'];
          _lat = docu.data()['lat'];
          _lng = docu.data()['lng'];
          _address = docu.data()['address'];
          //_vacation = docu.data()['workDays01'];
          //_workinghours = docu.data()['workDays02'];
          //_workinghours2 = docu.data()['workDays03'];
          realdistance = distance * 100;
          realdist = realdistance.toString();
          dotindex = realdist.indexOf('.') + 3;
          realnearby = realdist.substring(0, dotindex);

          for (String x in _vacation) {
            if (x.length < 11) {
              _mainDaysTranslation = AppLocalizations.of(context).translate(x);
              _mainDays = _mainDays + ',' + _mainDaysTranslation;
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
          }
          if (_workinghours.isNotEmpty) {
            _firstEDay =
                AppLocalizations.of(context).translate(_workinghours[0]);
            _firstfrom = _workinghours[1].substring(
                _workinghours[1].indexOf('m') + 2,
                _workinghours[1].indexOf('t') - 1);
            _firstTo = _workinghours[1].substring(
                _workinghours[1].indexOf('t') + 3, _workinghours[1].length);
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
          if (_workinghours2.isNotEmpty) {
            _secondEDay =
                AppLocalizations.of(context).translate(_workinghours2[0]);
            _secondfrom = _workinghours2[1].substring(
                _workinghours2[1].indexOf('m') + 2,
                _workinghours2[1].indexOf('t') - 1);
            _secondTo = _workinghours2[1].substring(
                _workinghours2[1].indexOf('t') + 3, _workinghours2[1].length);
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

          //_getAddressFromLatLng();
          //});
          print(_mainTime);
          print(_firstTime);
          print(_secondTime);
        }
      }
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
      child: Container(
        child: ListView(
          children: [
            Container(
              decoration: boxDecoration,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
                        _name,
                        style: _textStyle.copyWith(fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text(
                        _doctorAddress,
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
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _number,
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
                    Text(
                      _address,
                      style: _textStyle,
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .translate('time_availability'),
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      AppLocalizations.of(context).translate('open_time') +
                          _workinghours.toString(),
                      style: _textStyle,
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .translate('time_availability'),
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ''
                      //AppLocalizations.of(context).translate('vacation')
                      /*_vacation*/,
                      style: _textStyle,
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                    Text(
                      AppLocalizations.of(context).translate("distances"),
                      //'Distance to the Doctor is about ',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      realnearby +
                          AppLocalizations.of(context)
                              .translate("km"), //' Km away',
                      style: _textStyle,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            RaisedButton.icon(
              color: Colors.deepOrange,
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
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
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
