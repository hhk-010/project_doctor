import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/pages/last_searched/location.dart';
import 'package:project_doctor/pages/last_searched/read_write_path.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/sizing_information.dart';
import 'package:url_launcher/url_launcher.dart';

class LastSearchedDoctor extends StatefulWidget {
  final LastSearchedStorage readFromStorage = LastSearchedStorage();

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
  //===========bool to see wether there is a search or not==
  bool searched = false;
  @override
  void initState() {
    super.initState();
    widget.readFromStorage.readName().then((String value) {
      setState(() {
        _name = value;
      });
    });

    widget.readFromStorage.readSpeciality().then((String value) {
      setState(() {
        _speciality = value;
        if (!(_name == '' && _speciality == '')) {
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
            mainfromAmPm = AppLocalizations.of(context).translate(
                mainfrom.substring(
                    mainfrom.indexOf(' ') + 1, mainfrom.indexOf('M') + 1));
            mainToTime = mainTo.substring(0, mainTo.indexOf(' '));
            mainToAmPm = AppLocalizations.of(context).translate(
                mainTo.substring(mainTo.indexOf(' ') + 1, mainTo.length));
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
          _firstfrom = _workDays02[1].substring(
              _workDays02[1].indexOf('m') + 2, _workDays02[1].indexOf('t') - 1);
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
      });
    });

    widget.readFromStorage.readWorkDays03().then((List value) {
      setState(() {
        _workDays03 = value;
        if (_workDays03.isNotEmpty && _workDays03.length == 2) {
          _secondEDay = AppLocalizations.of(context).translate(_workDays03[0]);
          _secondfrom = _workDays03[1].substring(
              _workDays03[1].indexOf('m') + 2, _workDays03[1].indexOf('t') - 1);
          _secondTo = _workDays03[1].substring(
              _workDays03[1].indexOf('t') + 3, _workDays03[1].length);
          _secondfromTime = _secondfrom.substring(0, _secondfrom.indexOf(' '));
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
        appBarTitle = displayHeight(context) * 0.045;
        appBarHeight = 75;
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
        title = displayWidth(context) * 0.045;
        subTitle = displayWidth(context) * 0.03;
        buttonHeight = displayHeight(context) * 0.04;
        buttonWidth = displayWidth(context) * 0.4;
        footer = displayWidth(context) * 0.02;
        avatarSize = 70;
        containerInset = 50;
      }
      TextStyle _textStyle = TextStyle(
          fontSize: subTitle, color: Colors.black, fontWeight: FontWeight.bold);

      return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: AppBar(
            backgroundColor: Colors.deepOrange,
            title: Text(
              AppLocalizations.of(context).translate("resulted"),
              //'Search Result',
              style:
                  TextStyle(fontSize: appBarTitle, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            elevation: 0,
          ),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    child: !searched
                        ? Column(
                            children: [
                              Text(
                                AppLocalizations.of(context)
                                    .translate('search_warning'),
                                style: TextStyle(
                                    fontSize: title, color: Colors.deepOrange),
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('search_error'),
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
                                  backgroundImage:
                                      AssetImage('assets/images/doctor.png'),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                  _name,
                                  style: _textStyle.copyWith(
                                      fontSize: title,
                                      fontFamily: 'noto_arabic'),
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
                                      Icons.arrow_forward,
                                      color: Colors.indigo,
                                    ),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate(
                                                    'another_clinic_work'),
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
                        child: RaisedButton.icon(
                          color: Colors.deepOrange,
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          onPressed: () async {
                            print(_workDays01);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LastSearchedLocation(
                                      lat: _lat,
                                      lng: _lng,
                                    )));
                          },
                          label: Text(
                            AppLocalizations.of(context)
                                .translate("doctor_locat"),
                            //'View Doctor Location',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: subTitle,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : Text('   '),
              ],
            ),
          ),
        ),
      );
    });
  }
}
