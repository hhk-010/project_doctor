import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/matching_algorithm/final_score.dart';
import 'package:project_doctor/pages/last_searched/read_write_path.dart';
import 'package:project_doctor/pages/patient_pages/patient03_get_location.dart';
import 'package:project_doctor/pages/patient_pages/patient06_result_map.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/database.dart';
import 'package:project_doctor/services/read_write_path.dart';
import 'package:provider/provider.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/sizing_information.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:project_doctor/authorization/loading.dart';

class PatientResult extends StatefulWidget {
  final Storage storage = Storage();
  @override
  _PatientResultState createState() => _PatientResultState();
}

class _PatientResultState extends State<PatientResult> {
  /* String favorite01 = '';
  String favorite02 = '';
  String favorite03 = '';
  String favorite04 = '';
  String favorite05 = '';
  String favorite06 = '';
  String favorite07 = '';
  String favorite08 = '';
  String favorite09 = '';
  String favorite10 = '';
  List favoriteIDs = [];*/

  String _error = '';
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    var lang = Localizations.localeOf(context).languageCode;

    final _snackBar = new SnackBar(
      content: Text(
        _error,
        style: TextStyle(
            fontSize: 15,
            fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
      ),
      backgroundColor: Colors.deepOrange,
    );
    _scaffoldkey.currentState.showSnackBar(_snackBar);
  }

  String favored01 = '';
  String favored02 = '';
  String favored03 = '';
  String favored04 = '';
  String favored05 = '';
  String favored06 = '';
  String favored07 = '';
  String favored08 = '';
  String favored09 = '';
  String favored10 = '';

  Future<File> _writeFavorite01(String value) {
    setState(() => favored01 = value);
    return widget.storage.writeFavorite01(favored01);
  }

  Future<File> _writeFavorite02(String value) {
    setState(() => favored02 = value);
    return widget.storage.writeFavorite02(favored02);
  }

  Future<File> _writeFavorite03(String value) {
    setState(() => favored03 = value);
    return widget.storage.writeFavorite03(favored03);
  }

  Future<File> _writeFavorite04(String value) {
    setState(() => favored04 = value);
    return widget.storage.writeFavorite04(favored04);
  }

  Future<File> _writeFavorite05(String value) {
    setState(() => favored05 = value);
    return widget.storage.writeFavorite05(favored05);
  }

  Future<File> _writeFavorite06(String value) {
    setState(() => favored06 = value);
    return widget.storage.writeFavorite06(favored06);
  }

  Future<File> _writeFavorite07(String value) {
    setState(() => favored07 = value);
    return widget.storage.writeFavorite07(favored07);
  }

  Future<File> _writeFavorite08(String value) {
    setState(() => favored08 = value);
    return widget.storage.writeFavorite08(favored08);
  }

  Future<File> _writeFavorite09(String value) {
    setState(() => favored09 = value);
    return widget.storage.writeFavorite09(favored09);
  }

  Future<File> _writeFavorite10(String value) {
    setState(() => favored10 = value);
    return widget.storage.writeFavorite10(favored10);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      double appBarTitle;
      double appBarHeight;
      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
        appBarTitle = 25;
        appBarHeight = 50;
      } else {
        appBarTitle = displayHeight(context) * 0.03;
        appBarHeight = 80;
      }

      return StreamProvider<QuerySnapshot>.value(
        initialData: null,
        value: DatabaseService().usersDataStream,
        child: Scaffold(
          key: _scaffoldkey,
          backgroundColor: Colors.grey[200],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(appBarHeight),
            child: AppBar(
              backgroundColor: Colors.deepOrange,
              title: Text(
                AppLocalizations.of(context).translate("resulted"),
                //'Search Result',
                style: TextStyle(
                    fontSize: appBarTitle, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () async {
                    await widget.storage.readFavorite01().then(
                        (value) => setState(() => Favorite.favorite01 = value));
                    await widget.storage.readFavorite02().then(
                        (value) => setState(() => Favorite.favorite02 = value));
                    await widget.storage.readFavorite03().then(
                        (value) => setState(() => Favorite.favorite03 = value));
                    await widget.storage.readFavorite04().then(
                        (value) => setState(() => Favorite.favorite04 = value));
                    await widget.storage.readFavorite05().then(
                        (value) => setState(() => Favorite.favorite05 = value));
                    await widget.storage.readFavorite06().then(
                        (value) => setState(() => Favorite.favorite06 = value));
                    await widget.storage.readFavorite07().then(
                        (value) => setState(() => Favorite.favorite07 = value));
                    await widget.storage.readFavorite08().then(
                        (value) => setState(() => Favorite.favorite08 = value));
                    await widget.storage.readFavorite09().then(
                        (value) => setState(() => Favorite.favorite09 = value));
                    await widget.storage.readFavorite10().then(
                        (value) => setState(() => Favorite.favorite10 = value));
                    setState(() => Favorite.favoriteIdlist = [
                          Favorite.favorite01,
                          Favorite.favorite02,
                          Favorite.favorite03,
                          Favorite.favorite04,
                          Favorite.favorite05,
                          Favorite.favorite06,
                          Favorite.favorite07,
                          Favorite.favorite08,
                          Favorite.favorite09,
                          Favorite.favorite10
                        ]);

                    if (Favorite.favoriteIdlist
                        .contains(_ResultDoctorProfileState.iD)) {
                      _error = AppLocalizations.of(context)
                          .translate('added previously');
                      _showSnackBar();
                    } else {
                      await _writeFavorite01(_ResultDoctorProfileState.iD);
                      await _writeFavorite02(Favorite.favorite01);
                      await _writeFavorite03(Favorite.favorite02);
                      await _writeFavorite04(Favorite.favorite03);
                      await _writeFavorite05(Favorite.favorite04);
                      await _writeFavorite06(Favorite.favorite05);
                      await _writeFavorite07(Favorite.favorite06);
                      await _writeFavorite08(Favorite.favorite07);
                      await _writeFavorite09(Favorite.favorite08);
                      await _writeFavorite10(Favorite.favorite09);
                      _error = AppLocalizations.of(context)
                          .translate('added successfully');
                      _showSnackBar();
                    }
                  },
                  icon: Icon(Icons.star),
                )
              ],
            ),
          ),
          body: ResultDoctorProfile(),
        ),
      );
    });
  }
}

class ResultDoctorProfile extends StatefulWidget {
  final LastSearchedStorage writeToStorage = LastSearchedStorage();

  @override
  _ResultDoctorProfileState createState() => _ResultDoctorProfileState();
}

class _ResultDoctorProfileState extends State<ResultDoctorProfile> {
  String _name = '';
  String _speciality = '';
  String _phone = '';
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
  //=======to write main workdays===
  List writtenWorkDays = [];
  // ignore: unused_field
  String _mainTime = '';
  String _secondTime = '';
  String _firstTime = '';
  int _y = 0;
  int _z = 0;
  String x = '';
  //==========
  bool isLoading = false;
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static String iD = '';

  // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  // String _doctorAddress = '';
  // _getAddressFromLatLng() async {
  //   List<Placemark> p = await geolocator.placemarkFromCoordinates(_lat, _lng);
  //   Placemark place = p[0];
  //   setState(() {
  //     _doctorAddress = "${place.locality}, ${place.country}";
  //   });
  // }

  String _nameR = '';
  String _specialityR = '';
  String _phoneNumberR = '';
  String _provinceR = '';
  String _addressR = '';
  String _latR = '';
  String _lngR = '';
  String _workDays01R = '';
  String _workDays02R = '';
  String _workDays03R = '';
  Future<File> _writeName(String value) {
    setState(() {
      _nameR = value;
    });
    return widget.writeToStorage.writeName(_nameR);
  }

  Future<File> _writeSpeciality(String value) {
    setState(() {
      _specialityR = value;
    });
    return widget.writeToStorage.writeSpeciality(_specialityR);
  }

  Future<File> _writeNumber(String value) {
    setState(() {
      _phoneNumberR = value;
    });
    return widget.writeToStorage.writeNumber(_phoneNumberR);
  }

  Future<File> _writeProvince(String value) {
    setState(() {
      _provinceR = value;
    });
    return widget.writeToStorage.writeProvince(_provinceR);
  }

  Future<File> _writeAddress(String value) {
    setState(() {
      _addressR = value;
    });
    return widget.writeToStorage.writeAddress(_addressR);
  }

  //===================lat to list=================
  Future<File> _writelat(String value) {
    setState(() {
      _latR = value;
    });
    return widget.writeToStorage.writeLat(_latR);
  }

  Future<File> _writelng(String value) {
    setState(() {
      _lngR = value;
    });
    return widget.writeToStorage.writeLng(_lngR);
  }

  Future<File> _writeWorkDays01(String value) {
    setState(() {
      _workDays01R = value;
    });
    return widget.writeToStorage.writeWork01(_workDays01R);
  }

  Future<File> _writeWorkDays02(String value) {
    setState(() {
      _workDays02R = value;
    });
    return widget.writeToStorage.writeWork02(_workDays02R);
  }

  Future<File> _writeWorkDays03(String value) {
    setState(() {
      _workDays03R = value;
    });
    return widget.writeToStorage.writeWork03(_workDays03R);
  }

  @override
  Widget build(BuildContext context) {
    final doctorListProvider = Provider.of<QuerySnapshot>(context);
    if (doctorListProvider != null) {
      for (var docu in doctorListProvider.docs) {
        sum = ((docu.data()['lat'] - MyVariables.lat) *
                (docu.data()['lat'] - MyVariables.lat)) +
            ((docu.data()['lng'] - MyVariables.lng) *
                (docu.data()['lng'] - MyVariables.lng));
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
            ((docu.data()['lng'] - MyVariables.lng) *
                (docu.data()['lng'] - MyVariables.lng));
        result = sqrt(sum);

        if (result <= distance &&
            (FinalScore.speciality == docu.data()['speciality'] ||
                FinalScore.speciality2 == docu.data()['speciality'])) {
          setState(() {
            distance = result;
            iD = docu.id.toString();
            _name = docu.data()['name'];
            _speciality = docu.data()['speciality'];
            _phone = docu.data()['phoneNumber'];
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
            while (_y >= 0) {
              x = _workDays01[_z];
              if (x.length < 11) {
                _mainDaysTranslation =
                    AppLocalizations.of(context).translate(x);
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
                _mainfromAmPm = AppLocalizations.of(context).translate(
                    _mainfrom.substring(_mainfrom.indexOf(' ') + 1,
                        _mainfrom.indexOf('M') + 1));
                _mainToTime = _mainTo.substring(0, _mainTo.indexOf(' '));
                _mainToAmPm = AppLocalizations.of(context).translate(_mainTo
                    .substring(_mainTo.indexOf(' ') + 1, _mainTo.length));
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
            writtenWorkDays = _workDays01;
            _workDays01 = [];
            _mainDays = '';
            if (_workDays02.isNotEmpty && _workDays02.length == 2) {
              _firstEDay =
                  AppLocalizations.of(context).translate(_workDays02[0]);
              _firstfrom = _workDays02[1].substring(
                  _workDays02[1].indexOf('m') + 2,
                  _workDays02[1].indexOf('t') - 1);
              _firstTo = _workDays02[1].substring(
                  _workDays02[1].indexOf('t') + 3, _workDays02[1].length);
              _firstfromTime = _firstfrom.substring(0, _firstfrom.indexOf(' '));
              _firstfromAmPm = AppLocalizations.of(context).translate(_firstfrom
                  .substring(_firstfrom.indexOf(' ') + 1, _firstfrom.length));
              _firstToTime = _firstTo.substring(0, _firstTo.indexOf(' '));
              _firstToAmPm = AppLocalizations.of(context).translate(_firstTo
                  .substring(_firstTo.indexOf(' ') + 1, _firstTo.length));
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
              _secondfromAmPm = AppLocalizations.of(context).translate(
                  _secondfrom.substring(
                      _firstfrom.indexOf(' ') + 1, _firstfrom.length));
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
          });
        }
        if ((_name == '' || _name == null) &&
            (_speciality == '' || _speciality == null)) {
          setState(() => isLoading = true);
        } else {
          setState(() => isLoading = false);
        }
      }
      // _getAddressFromLatLng();
      _writeName(_name);
      _writeSpeciality(_speciality);
      _writeNumber(_phone);
      _writeProvince(_province);
      _writeAddress(_address);
      _writelat(_lat.toString());
      _writelng(_lng.toString());
      _writeWorkDays01(json.encode(writtenWorkDays));
      _writeWorkDays02(json.encode(_workDays02));
      _writeWorkDays03(json.encode(_workDays03));
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
      TextStyle _textStyle = TextStyle(
          fontSize: subTitle, color: Colors.black, fontWeight: FontWeight.bold);
      return isLoading
          ? Loading()
          : Center(
              child: Container(
                width: containerWidth,
                padding: EdgeInsets.only(top: containerInset),
                child: ListView(
                  children: [
                    Container(
                      decoration: boxDecoration,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: CircleAvatar(
                                backgroundColor: Colors.deepOrange,
                                radius: avatarSize,
                                backgroundImage:
                                    AssetImage('assets/images/doctor.png'),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  _name,
                                  style: _textStyle.copyWith(
                                      fontSize: title,
                                      fontFamily: 'noto_arabic'),
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
                                AppLocalizations.of(context)
                                    .translate(_province),
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
                              AppLocalizations.of(context)
                                  .translate('speciality'),
                              style: TextStyle(
                                  fontSize: footer,
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .translate(_speciality),
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
                                  .translate('phoneNumber'),
                              style: TextStyle(
                                  fontSize: footer,
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            GestureDetector(
                              onTap: () => setState(() {
                                _makePhoneCall('tel:$_phone');
                              }),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.deepOrange,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    _phone,
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
                              AppLocalizations.of(context)
                                  .translate('clinic_address'),
                              style: TextStyle(
                                  fontSize: footer,
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              _address,
                              style: _textStyle.copyWith(
                                  fontFamily: 'noto_arabic'),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .translate('clinic_work'),
                              style: TextStyle(
                                  fontSize: footer,
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              _finalMainDays + '\n' + _mainTime,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate('another_clinic_work'),
                                          style: TextStyle(
                                              fontSize: footer,
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
                            Text(
                              AppLocalizations.of(context)
                                  .translate("distances"),
                              style: TextStyle(
                                  fontSize: footer,
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
                    Container(
                      height: buttonHeight,
                      width: buttonWidth,
                      child: RaisedButton.icon(
                        color: Colors.deepOrange,
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PatientResultMap(
                                lat: _lat,
                                lng: _lng,
                              ),
                            ),
                          );
                        },
                        label: Text(
                          AppLocalizations.of(context)
                              .translate("doctor_locat"),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: subTitle,
                              fontWeight: FontWeight.bold),
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
