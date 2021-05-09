import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/read_write_path.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/search/search_history/location.dart';
import 'package:project_doctor/views/search/search_history/read_write_path.dart';

import 'package:url_launcher/url_launcher.dart';

class LastSearchedDoctor extends StatefulWidget {
  final LastSearchedStorage readFromStorage = LastSearchedStorage();
  final Storage storage = Storage();

  @override
  _LastSearchedDoctorState createState() => _LastSearchedDoctorState();
}

class _LastSearchedDoctorState extends State<LastSearchedDoctor> {
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

// variables for converting workdays
  String mainDaysTranslation = '';
  String mainDays = '';
  String finalMainDays = '';
  String _firstEDay = '';
  String _secondEDay = '';
  String mainfrom = '';
  String mainfromTime = '';
  String mainfromAmPm = '';
  String mainTo = '';
  String mainToTime = '';
  String mainToAmPm = '';
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
  String mainTime = '';
  String _secondTime = '';
  String _firstTime = '';

  String x = '';

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  List translatedDays = [];
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

  String _error = '';
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
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

  //===========bool to see wether there is a search or not==
  bool searched = false;
  @override
  void initState() {
    super.initState();
    SelectedPage.complaintSelected = false;
    SelectedPage.favoriteSelected = false;
    SelectedPage.lastSearchSelected = true;
    SelectedPage.newSearchSelected = false;
    widget.readFromStorage.readName().then((String value) {
      setState(() {
        _name = value;
      });
    });

    widget.readFromStorage.readSpeciality().then((String value) {
      setState(() {
        _speciality = value;
        if (!(_name == '' || _speciality == '')) {
          searched = true;
        }
      });
    });

    widget.readFromStorage.readNumber().then((String value) {
      setState(() {
        _phone = value;
      });
    });

    widget.readFromStorage.readProvince().then((String value) {
      setState(() {
        _province = value;
      });
    });

    widget.readFromStorage.readAddress().then((String value) {
      setState(() {
        _address = value;
      });
    });
    widget.readFromStorage.readLat().then((double value) {
      setState(() {
        _lat = value;
      });
    });

    widget.readFromStorage.readLng().then((double value) {
      setState(() {
        _lng = value;
      });
    });

    widget.readFromStorage.workDays01reader().then((List value) {
      setState(() {
        _workDays01 = value;
        for (String x in _workDays01) {
          if (x.length < 11) {
            x = (x).tr();
            translatedDays.add(x);
            finalMainDays = translatedDays.toString();
          } else {
            mainfrom = x.substring(x.indexOf('m') + 2, x.indexOf('t') - 1);
            mainTo = x.substring(x.indexOf('t') + 3, x.length);
            mainfromTime = mainfrom.substring(0, mainfrom.indexOf(' '));
            mainfromAmPm = (mainfrom.substring(mainfrom.indexOf(' ') + 1, mainfrom.indexOf('M') + 1)).tr();
            mainToTime = mainTo.substring(0, mainTo.indexOf(' '));
            mainToAmPm = (mainTo.substring(mainTo.indexOf(' ') + 1, mainTo.length)).tr();
            mainTime = LocaleKeys.view_time_day_from.tr() +
                mainfromTime +
                ' ' +
                mainfromAmPm +
                ' ' +
                LocaleKeys.view_time_day_to.tr() +
                mainToTime +
                ' ' +
                mainToAmPm;
          }
        }
      });
    });

    widget.readFromStorage.readWorkDays02().then((List value) {
      setState(() {
        _workDays02 = value;
        if (_workDays02.isNotEmpty && _workDays02.length == 2) {
          _firstEDay = (_workDays02[0]).tr();
          _firstfrom = _workDays02[1].substring(_workDays02[1].indexOf('m') + 2, _workDays02[1].indexOf('t') - 1);
          _firstTo = _workDays02[1].substring(_workDays02[1].indexOf('t') + 3, _workDays02[1].length);
          _firstfromTime = _firstfrom.substring(0, _firstfrom.indexOf(' '));
          _firstfromAmPm = (_firstfrom.substring(_firstfrom.indexOf(' ') + 1, _firstfrom.length)).tr();
          _firstToTime = _firstTo.substring(0, _firstTo.indexOf(' '));
          _firstToAmPm = (_firstTo.substring(_firstTo.indexOf(' ') + 1, _firstTo.length)).tr();
          _firstTime = LocaleKeys.view_time_day_from.tr() +
              _firstfromTime +
              ' ' +
              _firstfromAmPm +
              ' ' +
              LocaleKeys.view_time_day_to.tr() +
              _firstToTime +
              ' ' +
              _firstToAmPm;
        }
      });
    });

    widget.readFromStorage.readWorkDays03().then((List value) {
      setState(() {
        _workDays03 = value;
        if (_workDays03.isNotEmpty && _workDays03.length == 2) {
          _secondEDay = (_workDays03[0]).tr();
          _secondfrom = _workDays03[1].substring(_workDays03[1].indexOf('m') + 2, _workDays03[1].indexOf('t') - 1);
          _secondTo = _workDays03[1].substring(_workDays03[1].indexOf('t') + 3, _workDays03[1].length);
          _secondfromTime = _secondfrom.substring(0, _secondfrom.indexOf(' '));
          _secondfromAmPm = (_secondfrom.substring(_firstfrom.indexOf(' ') + 1, _firstfrom.length)).tr();
          _secondToTime = _secondTo.substring(0, _secondTo.indexOf(' '));
          _secondToAmPm = (_secondTo.substring(_secondTo.indexOf(' ') + 1, _secondTo.length)).tr();
          _secondTime = LocaleKeys.view_time_day_from.tr() +
              _secondfromTime +
              ' ' +
              _secondfromAmPm +
              ' ' +
              LocaleKeys.view_time_day_to.tr() +
              _secondToTime +
              ' ' +
              _secondToAmPm;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold);
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            LocaleKeys.view_patient_result_resulted.tr(),

            //'Search Result',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () async {
                  await widget.storage.readFavorite01().then((value) => setState(() => Favorite.favorite01 = value));
                  await widget.storage.readFavorite02().then((value) => setState(() => Favorite.favorite02 = value));
                  await widget.storage.readFavorite03().then((value) => setState(() => Favorite.favorite03 = value));
                  await widget.storage.readFavorite04().then((value) => setState(() => Favorite.favorite04 = value));
                  await widget.storage.readFavorite05().then((value) => setState(() => Favorite.favorite05 = value));
                  await widget.storage.readFavorite06().then((value) => setState(() => Favorite.favorite06 = value));
                  await widget.storage.readFavorite07().then((value) => setState(() => Favorite.favorite07 = value));
                  await widget.storage.readFavorite08().then((value) => setState(() => Favorite.favorite08 = value));
                  await widget.storage.readFavorite09().then((value) => setState(() => Favorite.favorite09 = value));
                  await widget.storage.readFavorite10().then((value) => setState(() => Favorite.favorite10 = value));
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
                  if (Favorite.favoriteIdlist.contains(SearchResultData.id.toString())) {
                    _error = LocaleKeys.view_patient_added_previously.tr();

                    _showSnackBar();
                  } else {
                    await _writeFavorite01(SearchResultData.id.toString());
                    await _writeFavorite02(Favorite.favorite01);
                    await _writeFavorite03(Favorite.favorite02);
                    await _writeFavorite04(Favorite.favorite03);
                    await _writeFavorite05(Favorite.favorite04);
                    await _writeFavorite06(Favorite.favorite05);
                    await _writeFavorite07(Favorite.favorite06);
                    await _writeFavorite08(Favorite.favorite07);
                    await _writeFavorite09(Favorite.favorite08);
                    await _writeFavorite10(Favorite.favorite09);
                    _error = LocaleKeys.view_patient_added_successfully.tr();

                    _showSnackBar();
                  }
                },
                icon: Icon(Icons.star))
          ],
        ),
      ),
      body: Center(
        child: Container(
          width: 100,
          padding: EdgeInsets.only(top: 50),
          child: ListView(
            children: [
              Container(
                decoration: CStyle.box,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: !searched
                      ? Column(
                          children: [
                            Text(
                              LocaleKeys.view_patient_search_warning.tr(),
                              style: TextStyle(fontSize: 16, color: Colors.deepOrange),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              LocaleKeys.view_patient_search_error.tr(),
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        )
                      : Column(
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
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  _name,
                                  style: _textStyle.copyWith(fontSize: 16, fontFamily: 'noto_arabic'),
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
                                LocaleKeys.view_doctor_province.tr(),

                                style: _textStyle.copyWith(fontSize: 12),
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
                              LocaleKeys.view_doctor_speciality.tr(),
                              style: TextStyle(fontSize: 12, color: Colors.indigo, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              LocaleKeys.view_doctor_speciality.tr(),
                              style: _textStyle,
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            Text(
                              LocaleKeys.view_doctor_phoneNumber.tr(),
                              style: TextStyle(fontSize: 12, color: Colors.indigo, fontWeight: FontWeight.bold),
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
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.phone,
                                    color: Colors.deepOrange,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      _phone,
                                      style: _textStyle,
                                    ),
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
                              LocaleKeys.view_doctor_clinic_address.tr(),
                              style: TextStyle(fontSize: 12, color: Colors.indigo, fontWeight: FontWeight.bold),
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
                              LocaleKeys.view_doctor_clinic_work.tr(),
                              style: TextStyle(fontSize: 12, color: Colors.indigo, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              finalMainDays + '\n' + mainTime,
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
                                          LocaleKeys.view_doctor_another_clinic_work.tr(),
                                          style: TextStyle(fontSize: 12, color: Colors.indigo, fontWeight: FontWeight.bold),
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
              searched
                  ? Container(
                      height: 50,
                      width: 150,
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                          backgroundColor: Colors.deepOrange,
                        ),
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          print(_workDays01);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LastSearchedLocation(
                                    lat: _lat,
                                    lng: _lng,
                                  )));
                        },
                        label: Text(
                          LocaleKeys.view_patient_result_doctor_locat.tr(),
                          //'View Doctor Location',
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
