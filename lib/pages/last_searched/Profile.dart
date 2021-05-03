import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/pages/last_searched/location.dart';
import 'package:project_doctor/pages/last_searched/read_write_path.dart';
import 'package:project_doctor/pages/patient_pages/patient_sidebar.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/read_write_path.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/sizing_information.dart';
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
            x = AppLocalizations.of(context).translate(x);
            translatedDays.add(x);
            finalMainDays = translatedDays.toString();
          } else {
            mainfrom = x.substring(x.indexOf('m') + 2, x.indexOf('t') - 1);
            mainTo = x.substring(x.indexOf('t') + 3, x.length);
            mainfromTime = mainfrom.substring(0, mainfrom.indexOf(' '));
            mainfromAmPm = AppLocalizations.of(context).translate(mainfrom.substring(mainfrom.indexOf(' ') + 1, mainfrom.indexOf('M') + 1));
            mainToTime = mainTo.substring(0, mainTo.indexOf(' '));
            mainToAmPm = AppLocalizations.of(context).translate(mainTo.substring(mainTo.indexOf(' ') + 1, mainTo.length));
            mainTime = AppLocalizations.of(context).translate('from') +
                mainfromTime +
                ' ' +
                mainfromAmPm +
                ' ' +
                AppLocalizations.of(context).translate('to') +
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
      });
    });

    widget.readFromStorage.readWorkDays03().then((List value) {
      setState(() {
        _workDays03 = value;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      double appBarTitle;
      double appBarHeight;
      double containerWidth;
      double buttonHeight;
      double buttonWidth;
      double title;
      double subTitle;
      double footer;
      double avatarSize;
      double containerInset;

      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
        appBarTitle = 25;
        appBarHeight = 50;
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
        appBarHeight = 80;
        appBarTitle = displayHeight(context) * 0.03;
        title = displayWidth(context) * 0.045;
        subTitle = displayWidth(context) * 0.03;
        buttonHeight = displayHeight(context) * 0.045;
        buttonWidth = displayWidth(context) * 0.4;
        footer = displayWidth(context) * 0.02;
        avatarSize = 70;
        containerInset = 50;
      }
      TextStyle _textStyle = TextStyle(fontSize: subTitle, color: Colors.black, fontWeight: FontWeight.bold);
      return Scaffold(
        key: _scaffoldkey,
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
                      _error = AppLocalizations.of(context).translate('added previously');
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
                      _error = AppLocalizations.of(context).translate('added successfully');
                      _showSnackBar();
                    }
                  },
                  icon: Icon(Icons.star))
            ],
          ),
        ),
        drawer: Container(
          width: getDeviceType(context, 180, 290, 520, 600),
          child: PatientSidebar(),
        ),
        body: Center(
          child: Container(
            width: containerWidth,
            padding: EdgeInsets.only(top: containerInset),
            child: ListView(
              children: [
                Container(
                  decoration: boxDecoration,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    child: !searched
                        ? Column(
                            children: [
                              Text(
                                AppLocalizations.of(context).translate('search_warning'),
                                style: TextStyle(fontSize: title, color: Colors.deepOrange),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                AppLocalizations.of(context).translate('search_error'),
                                style: TextStyle(fontSize: subTitle),
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
                                    _name,
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
                searched
                    ? Container(
                        height: buttonHeight,
                        width: buttonWidth,
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
                            AppLocalizations.of(context).translate("doctor_locat"),
                            //'View Doctor Location',
                            style: TextStyle(color: Colors.white, fontSize: subTitle, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
