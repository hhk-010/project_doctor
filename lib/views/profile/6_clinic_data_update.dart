import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/services/connectivity.dart';
import 'package:project_doctor/views/profile/7_map_data_update.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'dart:ui' as ui;

class ClinicDay {
  static String day1;
  static String day2;
}

class UpdateClinicView extends StatefulWidget {
  @override
  _UpdateClinicViewState createState() => _UpdateClinicViewState();
}

/////////////////////////////////////////////////////////////////////////////////////
List<DropdownMenuItem<String>> exception1 = [];
List<DropdownMenuItem<String>> exception2 = [];
// const String apiKey = 'ApiKey';
String currentWorkDays = '';
String mainWorkingHours = '';
String mainFromTimeString = '';
String mainToTimeString = '';
String secondaryWorkingHours = '';
String secondaryFromTimeString = '';
String secondaryToTimeString = '';
String ternaryWorkingHours = '';
String ternaryFromTimeString = '';
String ternaryToTimeString = '';
bool _visibile01 = false;
bool _daySwitch01 = false;
bool _visibile02 = false;
bool _daySwitch02 = false;

List<bool> workDays = List.filled(7, false);
List boolToStringDays(BuildContext context, List workDays) {
  return [
    workDays[0] ? "sunday" : null,
    workDays[1] ? "monday" : null,
    workDays[2] ? "tuesday" : null,
    workDays[3] ? "wednesday" : null,
    workDays[4] ? "thursday" : null,
    workDays[5] ? "friday" : null,
    workDays[6] ? "saturday" : null,
  ];
}

class _UpdateClinicViewState extends State<UpdateClinicView> {
  final RoundedLoadingButtonController _controller = RoundedLoadingButtonController();

  List workDays01 = [];
  List<String> workDays02 = [];
  List<String> workDays03 = [];
  TimeOfDay _mainFromTime;
  TimeOfDay _mainToTime;
  TimeOfDay _secondaryFromTime;
  TimeOfDay _secondaryToTime;
  TimeOfDay _ternaryFromTime;
  TimeOfDay _ternaryToTime;
  String weekday01;
  String weekday02;
  String mainFromTimeNo;
  String mainToTimeNo;
  String ampm;
  String toampm;
  String mainFromend;
  String mainToend;
  bool makeMePass = false;
  List e1 = [];
  List e2 = [];
  String secondFromNo = '';
  String secondFromEnd = '';
  String secondFromAmPm = '';
  String secondToNo = '';
  String secondToEnd = '';
  String secondToAmPm = '';
  String thirdFromNo = '';
  String thirdFromEnd = '';
  String thirdFromAmPm = '';
  String thirdToNo = '';
  String thirdToEnd = '';
  String thirdToAmPm = '';
  List t1 = [];
  List t2 = [];
  bool mainfrom = false;
  bool mainto = false;
  bool secfrom = false;
  bool secto = false;
  bool thirdfrom = false;
  bool thirdto = false;
  String latlng = '';
  int _x = 6;

//===========geo encode address=======
  getCoordinatesFromAddress(String address) async {
    try {
      final query = address;
      var addresses = await Geocoder.local.findAddressesFromQuery(query);
      var first = addresses.first;
      print("${first.featureName} : ${first.coordinates}");
      latlng = "${first.coordinates}";
      return latlng;
    } catch (e) {
      print(e);
      return '{0.0,0.0}';
    }
  }

//===========province translation=====
  Map provinces = {
    'Baghdad': 'بغداد',
    'Erbil': 'اربيل',
    'Al Anbar': 'الانبار',
    'Basra': 'البصره',
    'Al Qadisiyyah': 'القادسية',
    'Muthanna': 'المثنى',
    'Najaf': 'النجف',
    'Babil': 'بابل',
    'Duhok': 'دهوك',
    'Diyala': 'ديالى',
    'Dhi Qar': 'ذي قار',
    'Sulaymaniyah': 'السليمانية',
    'Saladin': 'صلاح الدين',
    'Karbala': 'كربلاء',
    'Kirkuk': 'كركوك',
    'Maysan': 'ميسان',
    'Nineveh': 'نينوى',
    'Wasit': 'واسط'
  };

  @override
  void initState() {
    super.initState();
    UpdateProfileData.clinicAddress = '';
    _mainFromTime = TimeOfDay.now();
    _secondaryFromTime = TimeOfDay.now();
    _mainToTime = TimeOfDay(hour: 12, minute: 0);
    _secondaryToTime = TimeOfDay(hour: 12, minute: 0);
    _ternaryFromTime = TimeOfDay.now();
    _ternaryToTime = TimeOfDay(hour: 12, minute: 0);
    mainFromTimeString = '';
    mainToTimeString = '';
    secondaryFromTimeString = '';
    secondaryToTimeString = '';
    ternaryFromTimeString = '';
    ternaryToTimeString = '';
    workDays01 = [];
    currentWorkDays = '';
    while (_x >= 0) {
      workDays[_x] = false;
      _x -= 1;
    }
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    ///////////////////////////////////////////////////////////////////////////////////////////////////

    final weekDaysList = {
      0: [workDays[0], LocaleKeys.view_time_day_sunday.tr(), "sunday"],
      1: [workDays[1], LocaleKeys.view_time_day_monday.tr(), "monday"],
      2: [workDays[2], LocaleKeys.view_time_day_tuesday.tr(), "tuesday"],
      3: [workDays[3], LocaleKeys.view_time_day_wednesday.tr(), "wednesday"],
      4: [workDays[4], LocaleKeys.view_time_day_thursday.tr(), "thursday"],
      5: [workDays[5], LocaleKeys.view_time_day_friday.tr(), "friday"],
      6: [workDays[6], LocaleKeys.view_time_day_saturday.tr(), "saturday"],
    };
    void makeException1() {
      exception1 = [];
      for (int key in weekDaysList.keys) {
        if (!weekDaysList[key][0] && weekDaysList[key][2] != ClinicDay.day2) {
          exception1.add(DropdownMenuItem<String>(child: Text(weekDaysList[key][1]), value: weekDaysList[key][2]));
        }
      }
    }

    void makeException2() {
      exception2 = [];
      for (int key in weekDaysList.keys) {
        if (!weekDaysList[key][0] && weekDaysList[key][2] != ClinicDay.day1) {
          exception2.add(DropdownMenuItem<String>(child: Text(weekDaysList[key][1]), value: weekDaysList[key][2]));
        }
      }
    }

//////////////////////////////////////////////////////////////////////////////////////

    _pickMainFromTime() async {
      TimeOfDay mainfromTime = await showTimePicker(
          context: context,
          initialTime: _mainFromTime,
          builder: (BuildContext context, Widget child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            );
          });
      if (mainfromTime != null)
        setState(() {
          _mainFromTime = mainfromTime;
          mainFromTimeString = _mainFromTime.format(context);
          mainFromTimeNo = mainFromTimeString.substring(0, mainFromTimeString.indexOf(' '));
          mainFromend = mainFromTimeString.substring(mainFromTimeString.indexOf(' ') + 1, mainFromTimeString.length);
          if (mainFromend.contains('ص') || mainFromend.contains('AM')) {
            ampm = "AM";
          } else {
            ampm = "PM";
          }
          mainFromTimeString = mainFromTimeNo + " " + ampm;
          if (mainToTimeString != '') {
            mainWorkingHours = 'from ' + mainFromTimeString + ' to ' + mainToTimeString;
            makeMePass = true;
          }
          mainfrom = true;
        });
    }

    _pickMainToTime() async {
      TimeOfDay maintoTime = await showTimePicker(
          context: context,
          initialTime: _mainToTime,
          builder: (BuildContext context, Widget child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            );
          });
      if (maintoTime != null)
        setState(() {
          _mainToTime = maintoTime;
          mainToTimeString = _mainToTime.format(context);
          mainToTimeNo = mainToTimeString.substring(0, mainToTimeString.indexOf(' '));
          mainToend = mainToTimeString.substring(mainToTimeString.indexOf(' '), mainToTimeString.length);
          if (mainToend.contains('ص') || mainToend.contains('AM')) {
            toampm = "AM";
          } else if (mainToend.contains('م') || mainToend.contains('PM')) {
            toampm = "PM";
          }
          mainToTimeString = mainToTimeNo + " " + toampm;
          if (mainFromTimeString != '') {
            mainWorkingHours = "from " + mainFromTimeString + " to " + mainToTimeString;
            makeMePass = true;
          }
          mainto = true;
        });
      print(mainWorkingHours);
    }

    _pickSecondaryFromTime() async {
      TimeOfDay secondaryFromTime = await showTimePicker(
          context: context,
          initialTime: _secondaryFromTime,
          builder: (BuildContext context, Widget child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            );
          });
      if (secondaryFromTime != null)
        setState(() {
          _secondaryFromTime = secondaryFromTime;
          secondaryFromTimeString = _secondaryFromTime.format(context);
          secondFromNo = secondaryFromTimeString.substring(0, secondaryFromTimeString.indexOf(' '));
          secondFromEnd = secondaryFromTimeString.substring(secondaryFromTimeString.indexOf(' '), secondaryFromTimeString.length);
          if (secondFromEnd.contains('ص') || secondFromEnd.contains('AM')) {
            secondFromAmPm = 'AM';
          } else {
            secondFromAmPm = 'PM';
          }
          secondaryFromTimeString = secondFromNo + ' ' + secondFromAmPm;
          secfrom = true;
          if (secondaryToTimeString != '') {
            secondaryWorkingHours = 'from ' + secondaryFromTimeString + ' to ' + secondaryToTimeString;

            if (t1.isEmpty) {
              t1.add(secondaryWorkingHours);
            } else {
              t1 = [];
              t1.add(secondaryWorkingHours);
            }
          }
        });
    }

    _pickSecondaryToTime() async {
      TimeOfDay secondaryToTime = await showTimePicker(
          context: context,
          initialTime: _secondaryToTime,
          builder: (BuildContext context, Widget child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            );
          });
      if (secondaryToTime != null)
        setState(() {
          _secondaryToTime = secondaryToTime;
          secondaryToTimeString = _secondaryToTime.format(context);
          secondToNo = secondaryToTimeString.substring(0, secondaryToTimeString.indexOf(' '));
          secondToEnd = secondaryToTimeString.substring(secondaryToTimeString.indexOf(' '), secondaryToTimeString.length);
          if (secondToEnd.contains('ص') || secondToEnd.contains('AM')) {
            secondToAmPm = 'AM';
          } else {
            secondToAmPm = 'PM';
          }
          secondaryToTimeString = secondToNo + ' ' + secondToAmPm;
          if (secondaryFromTimeString != '') {
            secondaryWorkingHours = 'from ' + secondaryFromTimeString + ' to ' + secondaryToTimeString;

            if (t1.isEmpty) {
              t1.add(secondaryWorkingHours);
            } else {
              t1 = [];
              t1.add(secondaryWorkingHours);
            }
          }
          secto = true;
        });
      print(secondaryWorkingHours);
    }

    _pickTernaryFromTime() async {
      TimeOfDay ternaryFromTime = await showTimePicker(
          context: context,
          initialTime: _ternaryFromTime,
          builder: (BuildContext context, Widget child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            );
          });
      if (ternaryFromTime != null)
        setState(() {
          _ternaryFromTime = ternaryFromTime;
          ternaryFromTimeString = _ternaryFromTime.format(context);
          thirdFromNo = ternaryFromTimeString.substring(0, ternaryFromTimeString.indexOf(' '));
          thirdFromEnd = ternaryFromTimeString.substring(ternaryFromTimeString.indexOf(' '), ternaryFromTimeString.length);
          if (thirdFromEnd.contains('ص') || thirdFromEnd.contains('AM')) {
            thirdFromAmPm = 'AM';
          } else {
            thirdFromAmPm = 'PM';
          }
          ternaryFromTimeString = thirdFromNo + ' ' + thirdFromAmPm;
          thirdfrom = true;
          if (ternaryToTimeString != '') {
            ternaryWorkingHours = 'from ' + ternaryFromTimeString + ' to ' + ternaryToTimeString;
            if (t2.isEmpty) {
              t2.add(ternaryWorkingHours);
            } else {
              t2 = [];
              t2.add(ternaryWorkingHours);
            }
          }
        });
    }

    _pickTernaryToTime() async {
      TimeOfDay ternaryToTime = await showTimePicker(
          context: context,
          initialTime: _ternaryToTime,
          builder: (BuildContext context, Widget child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            );
          });
      if (ternaryToTime != null)
        setState(() {
          _ternaryToTime = ternaryToTime;
          ternaryToTimeString = _ternaryToTime.format(context);
          thirdToNo = ternaryToTimeString.substring(0, ternaryToTimeString.indexOf(' '));
          thirdToEnd = ternaryToTimeString.substring(ternaryToTimeString.indexOf(' '), ternaryToTimeString.length);
          if (thirdToEnd.contains('ص') || thirdToEnd.contains('AM')) {
            thirdToAmPm = 'AM';
          } else {
            thirdToAmPm = 'PM';
          }
          ternaryToTimeString = thirdToNo + ' ' + thirdToAmPm;
          if (ternaryFromTimeString != '') {
            ternaryWorkingHours = 'from ' + ternaryFromTimeString + ' to ' + ternaryToTimeString;
            if (t2.isEmpty) {
              t2.add(ternaryWorkingHours);
            } else {
              t2 = [];
              t2.add(ternaryWorkingHours);
            }
          }
          thirdto = true;
        });
      print(ternaryWorkingHours);
    }

    return BaseScaffold(
      isAppbar: true,
             action: getAppActions(context),


      title: LocaleKeys.view_doctor_update_info.tr(),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: CStyle.box,
                      height: 400,
                      width: 350,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                              child: Text(
                                LocaleKeys.view_doctor_detailed_address.tr(),
                                style: CStyle.getTitleBlack(context),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: Directionality(
                                textDirection: ui.TextDirection.rtl,
                                child: TextField(
                                  onChanged: (val) {
                                    setState(() => UpdateProfileData.clinicAddress = val);
                                  },
                                  decoration: CStyle.getInputDecoration(context).copyWith(
                                    hintText: 'مثال: الحارثيه شارع الكندي',
                                    hintStyle: CStyle.getSubtitle(context).copyWith(fontFamily: 'noto_arabic', color: Colors.deepOrange),
                                    labelText: 'عنوان العياده',
                                    labelStyle: CStyle.getSubtitle(context).copyWith(fontFamily: 'noto_arabic', color: Colors.grey[750]),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                LocaleKeys.view_doctor_work_days.tr(),
                                style: CStyle.getTitleBlack(context),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: WeekdaySelector(
                                onChanged: (int day) {
                                  setState(() {
                                    final index = day % 7;
                                    if (ClinicDay.day1 != weekDaysList[index][2] && ClinicDay.day2 != weekDaysList[index][2]) {
                                      workDays[index] = !workDays[index];
                                      workDays01 = boolToStringDays(context, workDays);
                                      workDays01.removeWhere((value) => value == null);
                                      currentWorkDays = workDays01.join(', ');
                                      weekDaysList[index][0] = //workDays[index];
                                          !weekDaysList[index][0];
                                      makeException1();
                                      makeException2();
                                    } else {
                                      getFlushbar(context, LocaleKeys.error_dayselected.tr(), _controller);
                                    }
                                  });
                                },
                                values: workDays,
                                firstDayOfWeek: DateTime.sunday,
                                shortWeekdays: [
                                  LocaleKeys.view_time_day_sun.tr(),
                                  LocaleKeys.view_time_day_mon.tr(),
                                  LocaleKeys.view_time_day_tue.tr(),
                                  LocaleKeys.view_time_day_wed.tr(),
                                  LocaleKeys.view_time_day_thu.tr(),
                                  LocaleKeys.view_time_day_fri.tr(),
                                  LocaleKeys.view_time_day_sat.tr(),
                                ],
                                weekdays: [
                                  LocaleKeys.view_time_day_sunday.tr(),
                                  LocaleKeys.view_time_day_monday.tr(),
                                  LocaleKeys.view_time_day_tuesday.tr(),
                                  LocaleKeys.view_time_day_wednesday.tr(),
                                  LocaleKeys.view_time_day_thursday.tr(),
                                  LocaleKeys.view_time_day_friday.tr(),
                                  LocaleKeys.view_time_day_saturday.tr(),
                                ],
                                textDirection: getLocale(context) ? ui.TextDirection.ltr : ui.TextDirection.rtl,
                                selectedFillColor: Colors.deepOrange,
                                selectedTextStyle: CStyle.getSubtitle(context),
                                textStyle: CStyle.getSubtitle(context).copyWith(color: getColor(context, Colors.black, Colors.white)),
                                selectedElevation: 0,
                                elevation: 5,
                                selectedShape: CircleBorder(
                                  side: BorderSide(color: Colors.black, width: 1),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    child: RichText(
                                      text: TextSpan(
                                          text: LocaleKeys.view_time_day_from.tr(),
                                          style: CStyle.getTitle(context).copyWith(
                                            color: getColor(context, Colors.black, Colors.white),
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '${_mainFromTime.format(context)}',
                                              style: CStyle.getTitle(context).copyWith(
                                                color: mainfrom ? Colors.deepOrange : getColor(context, Colors.black, Colors.white),
                                              ),
                                            ),
                                          ]),
                                    ),
                                    onTap: _pickMainFromTime,
                                  ),
                                  Icon(Icons.arrow_forward),
                                  InkWell(
                                    child: RichText(
                                      text: TextSpan(
                                          text: LocaleKeys.view_time_day_to.tr(),
                                          style: CStyle.getTitle(context).copyWith(
                                            color: getColor(context, Colors.black, Colors.white),
                                          ),
                                          children: [
                                            TextSpan(
                                                text: '${_mainToTime.format(context)}',
                                                style: CStyle.getTitle(context).copyWith(
                                                  color: mainto ? Colors.deepOrange : getColor(context, Colors.black, Colors.white),
                                                )),
                                          ]),
                                    ),
                                    onTap: _pickMainToTime,
                                  ),
                                ],
                              ),
                            ),
                            SwitchListTile(
                                activeColor: Colors.deepOrange,
                                dense: true,
                                title: Text(LocaleKeys.view_doctor_expcetion_days.tr(), style: CStyle.getSubtitle(context)),
                                value: _daySwitch01,
                                onChanged: (bool s) {
                                  setState(() {
                                    _daySwitch01 = s;
                                    _visibile01 = !_visibile01;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Visibility(
                      visible: _visibile01,
                      child: Container(
                        height: 250,
                        width: 350,
                        decoration: CStyle.box,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(
                                child: Text(
                                  LocaleKeys.view_doctor_expcetion_days.tr(),
                                  style: CStyle.getTitleBlack(context),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: DropdownButton(
                                  hint: Text(
                                    LocaleKeys.view_doctor_select_days.tr(),
                                  ),
                                  isExpanded: true,
                                  items: exception1,
                                  onChanged: (value) {
                                    setState(() {
                                      weekday01 = value;
                                      if (e1 == []) {
                                        e1.add(weekday01);
                                      } else {
                                        e1 = [];
                                        e1.add(weekday01);
                                      }
                                      ClinicDay.day1 = weekday01;
                                    });
                                    makeException2();
                                  },
                                  value: weekday01,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      child: RichText(
                                        text: TextSpan(
                                            text: LocaleKeys.view_time_day_from.tr(),
                                            style: CStyle.getTitle(context).copyWith(
                                              color: getColor(context, Colors.black, Colors.white),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '${_secondaryFromTime.format(context)}',
                                                style: CStyle.getTitle(context).copyWith(
                                                  color: secfrom ? Colors.deepOrange : getColor(context, Colors.black, Colors.white),
                                                ),
                                              ),
                                            ]),
                                      ),
                                      onTap: _pickSecondaryFromTime,
                                    ),
                                    Icon(Icons.arrow_forward),
                                    InkWell(
                                      child: RichText(
                                        text: TextSpan(
                                            text: LocaleKeys.view_time_day_to.tr(),
                                            style: CStyle.getTitle(context).copyWith(
                                              color: getColor(context, Colors.black, Colors.white),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '${_secondaryToTime.format(context)}',
                                                style: CStyle.getTitle(context).copyWith(
                                                  color: secto ? Colors.deepOrange : getColor(context, Colors.black, Colors.white),
                                                ),
                                              ),
                                            ]),
                                      ),
                                      onTap: _pickSecondaryToTime,
                                    ),
                                  ],
                                ),
                              ),
                              SwitchListTile(
                                  activeColor: Colors.deepOrange,
                                  dense: true,
                                  title: Text(
                                    LocaleKeys.view_doctor_expcetion_days.tr(),
                                    style: CStyle.getSubtitle(context),
                                  ),
                                  value: _daySwitch02,
                                  onChanged: (bool s) {
                                    setState(() {
                                      _daySwitch02 = s;
                                      _visibile02 = !_visibile02;
                                    });
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Visibility(
                      visible: _visibile02,
                      child: Container(
                        height: 200,
                        width: 350,
                        decoration: CStyle.box,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(
                                child: Text(
                                  LocaleKeys.view_doctor_expcetion_days.tr(),
                                  style: CStyle.getTitleBlack(context),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: DropdownButton(
                                  hint: Text(
                                    LocaleKeys.view_doctor_select_days.tr(),
                                  ),
                                  isExpanded: true,
                                  items: exception2,
                                  onChanged: (value) {
                                    setState(() {
                                      weekday02 = value;
                                      if (e2.isEmpty) {
                                        e2.add(weekday02);
                                      } else {
                                        e2 = [];
                                        e2.add(weekday02);
                                      }
                                      ClinicDay.day2 = weekday02;
                                    });
                                    makeException1();
                                  },
                                  value: weekday02,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      child: RichText(
                                        text: TextSpan(
                                            text: LocaleKeys.view_time_day_from.tr(),
                                            style: CStyle.getTitle(context).copyWith(
                                              color: getColor(context, Colors.black, Colors.white),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '${_ternaryFromTime.format(context)}',
                                                style: CStyle.getTitle(context).copyWith(
                                                  color: thirdfrom ? Colors.deepOrange : getColor(context, Colors.black, Colors.white),
                                                ),
                                              ),
                                            ]),
                                      ),
                                      onTap: _pickTernaryFromTime,
                                    ),
                                    Icon(Icons.arrow_forward),
                                    InkWell(
                                      child: RichText(
                                        text: TextSpan(
                                            text: LocaleKeys.view_time_day_to.tr(),
                                            style: CStyle.getTitle(context).copyWith(
                                              color: getColor(context, Colors.black, Colors.white),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '${_ternaryToTime.format(context)}',
                                                style: CStyle.getTitle(context).copyWith(
                                                  color: thirdto ? Colors.deepOrange : getColor(context, Colors.black, Colors.white),
                                                ),
                                              ),
                                            ]),
                                      ),
                                      onTap: _pickTernaryToTime,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: CustomLoadingButton(
                          controller: _controller,
                          title: LocaleKeys.view_buttons_google_map.tr(),
                          onPressed: () async {
                            if (await isInternet()) {
                              if (UpdateProfileData.clinicAddress.isNotEmpty) {
                                if (e1.isNotEmpty && t1.isNotEmpty) {
                                  if (workDays02.isEmpty) {
                                    workDays02.add(e1[0]);
                                    workDays02.add(t1[0]);
                                  } else {
                                    workDays02 = [];
                                    workDays02.add(e1[0]);
                                    workDays02.add(t1[0]);
                                  }
                                }
                                if (e2.isNotEmpty && t2.isNotEmpty) {
                                  if (workDays03.isEmpty) {
                                    workDays03.add(e2[0]);
                                    workDays03.add(t2[0]);
                                  } else {
                                    workDays03 = [];
                                    workDays03.add(e2[0]);
                                    workDays03.add(t2[0]);
                                  }
                                }
                                if (UpdateProfileData.clinicAddress != '' &&
                                    currentWorkDays != '' &&
                                    mainFromTimeString != '' &&
                                    mainToTimeString != '' &&
                                    makeMePass &&
                                    mainfrom &&
                                    mainto &&
                                    ((e1.isNotEmpty && t1.isNotEmpty) || (e1.isEmpty && t1.isEmpty)) &&
                                    ((e2.isNotEmpty && t2.isNotEmpty) || (e2.isEmpty && t2.isEmpty))) {
                                  latlng = await getCoordinatesFromAddress(provinces[UpdateProfileData.province] + ' ' + UpdateProfileData.clinicAddress);

                                  setState(() {
                                    if (workDays01[workDays01.length - 1].length < 11) {
                                      workDays01.add(mainWorkingHours);
                                    } else {
                                      workDays01.remove(workDays01[workDays01.length - 1]);
                                      workDays01.add(mainWorkingHours);
                                    }

                                    makeMePass = false;
                                  });
                                  mainfrom = false;
                                  mainto = false;
                                  setState(() {
                                    DataFromProfiletoUpdate.name = UpdateProfileData.name;
                                    DataFromProfiletoUpdate.speciality = UpdateProfileData.speciality;
                                    DataFromProfiletoUpdate.phoneNumber = UpdateProfileData.phoneNumber;
                                    DataFromProfiletoUpdate.province = UpdateProfileData.province;
                                    DataFromProfiletoUpdate.address = UpdateProfileData.clinicAddress;
                                    DataFromProfiletoUpdate.workDays01 = List<String>.from(workDays01);
                                    DataFromProfiletoUpdate.workDays02 = List<String>.from(workDays02);
                                    DataFromProfiletoUpdate.workDays03 = List<String>.from(workDays03);
                                  });
                                  print(latlng);
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => UpdateaMapViewStream(
                                        latlng: latlng,
                                      ),
                                    ),
                                  );
                                } else if (currentWorkDays == '') {
                                  getFlushbar(context, LocaleKeys.error_selectmaindays.tr(), _controller);
                                } else if (mainFromTimeString == '' || mainToTimeString == '' || !mainfrom || !mainto) {
                                  getFlushbar(context, LocaleKeys.error_Select_time.tr(), _controller);
                                } else if (!((e1.isNotEmpty && t1.isNotEmpty) || (e1.isEmpty && t1.isEmpty))) {
                                  if (e1.isEmpty) {
                                    getFlushbar(context, LocaleKeys.error_choose_1st_exception_day.tr(), _controller);
                                  } else {
                                    getFlushbar(context, LocaleKeys.error_choose_1st_exception_time.tr(), _controller);
                                  }
                                } else if (!((e2.isNotEmpty && t2.isNotEmpty) || (e2.isEmpty && t2.isEmpty))) {
                                  if (e2.isEmpty) {
                                    getFlushbar(context, LocaleKeys.error_choose_2nd_exception_day.tr(), _controller);
                                  } else {
                                    getFlushbar(context, LocaleKeys.error_choose_2nd_exception_time.tr(), _controller);
                                  }
                                }
                              } else {
                                getFlushbar(context, LocaleKeys.error_sign_info.tr(), _controller);
                              }
                            } else {
                              getFlushbar(context, LocaleKeys.error_snack_connectivity.tr(), _controller);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
