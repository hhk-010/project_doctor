import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_profile.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/read_write_path.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/search/search_history/history_location.dart';
import 'package:project_doctor/views/search/search_history/read_write_path.dart';

import 'package:url_launcher/url_launcher.dart';

class SearchHistoryProfile extends StatefulWidget {
  final LastSearchedStorage readFromStorage = LastSearchedStorage();
  final Storage storage = Storage();

  @override
  _SearchHistoryProfileState createState() => _SearchHistoryProfileState();
}

class _SearchHistoryProfileState extends State<SearchHistoryProfile> {
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
    return BaseScaffold(
      title: LocaleKeys.view_patient_result_resulted.tr(),
      isAppbar: true,
      action: IconButton(
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
              getFavortiteFlushbar(context, LocaleKeys.view_patient_added_previously.tr());
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
              getFavortiteFlushbar(context, LocaleKeys.view_patient_added_successfully.tr());
            }
          },
          icon: Icon(Icons.star)),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          !searched
              ? Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 100,
                    width: 350,
                    decoration: CStyle.box,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          LocaleKeys.view_patient_search_warning.tr(),
                          style: CStyle.getHeading(context),
                        ),
                        Text(
                          LocaleKeys.view_patient_search_error.tr(),
                          style: CStyle.getTitleBlack(context),
                        ),
                      ],
                    ),
                  ),
                )
              : Positioned(
                  top: 50,
                  child: Container(
                    height: 600,
                    width: 350,
                    decoration: CStyle.box,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.deepOrange,
                                  radius: 50,
                                  backgroundImage: AssetImage('assets/images/doctor.png'),
                                ),
                                Text(
                                  _name,
                                  style: CStyle.getTitleBlack(context),
                                ),
                                Text(
                                  (_province).tr(),
                                  style: CStyle.getFooter(context),
                                ),
                                Divider(
                                  color: Colors.grey[600],
                                  thickness: 3,
                                  indent: 25,
                                  endIndent: 25,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomProfileColumn(
                                title: LocaleKeys.view_doctor_speciality.tr(),
                                content: (_speciality).tr(),
                              ),
                              CustomProfileColumn(
                                title: LocaleKeys.view_doctor_phoneNumber.tr(),
                                content: _phone,
                              ),
                              CustomProfileColumn(
                                title: LocaleKeys.view_doctor_clinic_address.tr(),
                                content: _address,
                              ),
                              CustomProfileColumn2(
                                title: LocaleKeys.view_doctor_clinic_work.tr(),
                                content: finalMainDays + '\n' + mainTime,
                              ),
                              _workDays02.isEmpty
                                  ? SizedBox(
                                      height: 5,
                                    )
                                  : CustomProfileColumn2(
                                      title: LocaleKeys.view_doctor_another_clinic_work.tr(),
                                      content: _firstEDay + " " + _firstTime + '\n' + _secondEDay + " " + _secondTime,
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: BaseButton(
                title: 'view_patient_result.doctor_locat'.tr(),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchHistoryLocation(
                          lat: _lat,
                          lng: _lng,
                        ))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
