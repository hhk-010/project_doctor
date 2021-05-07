import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/constants/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/profile/doctor06_update_map.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'dart:ui' as ui;

class ClinicDay {
  static String day1;
  static String day2;
}

class UpdateInfo2 extends StatefulWidget {
  final String name;
  final String speciality;
  final String phoneNumber;
  final String province;
  UpdateInfo2({this.name, this.speciality, this.phoneNumber, this.province});
  @override
  _UpdateInfo2State createState() => _UpdateInfo2State(name: name, speciality: speciality, phoneNumber: phoneNumber, province: province);
}

List<DropdownMenuItem<String>> exceptions1 = [];
List<DropdownMenuItem<String>> exceptions2 = [];
List<bool> worksDays = List.filled(7, false);
List boolToStringDays(BuildContext context, List worksDays) {
  return [
    worksDays[0] ? 'sunday' : null,
    worksDays[1] ? 'monday' : null,
    worksDays[2] ? 'tuesday' : null,
    worksDays[3] ? 'wednesday' : null,
    worksDays[4] ? 'thursday' : null,
    worksDays[5] ? 'friday' : null,
    worksDays[6] ? 'saturday' : null,
  ];
}

// TextDirection getTextDirection(Locale locale) {
//   const rtlLanguages = ['ar'];
//   // return rtlLanguages.contains(locale.languageCode) ? ui.TextDirection.rtl : TextDirection.ltr;
// }

class _UpdateInfo2State extends State<UpdateInfo2> {
  final String name;
  final String speciality;
  final String phoneNumber;
  final String province;
  TimeOfDay _mainFromTime;
  TimeOfDay _mainToTime;
  TimeOfDay _secondaryFromTime;
  TimeOfDay _secondaryToTime;
  TimeOfDay _ternaryFromTime;
  TimeOfDay _ternaryToTime;
  String weekday01;
  String weekday02;
  _UpdateInfo2State({this.name, this.speciality, this.phoneNumber, this.province});

  String address = '';
  String currentVacationDays = '';
  List workDays01 = [];
  List workDays0 = [];
  List workDays03 = [];
  String mainWorkingHours = '';
  String mainFromTimeString = '';
  String mainToTimeString = '';
  String primainFromTimeString = '';
  String primainToTimeString = '';
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
  String mainFromNo = '';
  String mainToNo = '';
  String fromAmPm = '';
  String toAmPm = '';
  String fromEnd = '';
  String toEnd = '';
  bool makeMePass = false;
  List e1 = [];
  List e2 = [];
  String secondFromNo = '';
  String secondToNo = '';
  String secondFromAmPm = '';
  String secondToAmPm = '';
  String secondFromEnd = '';
  String secondToEnd = '';
  String thirdFromNo = '';
  String thirdToNo = '';
  String thirdFromAmPm = '';
  String thirdToAmPm = '';
  String thirdFromEnd = '';
  String thirdToEnd = '';
  List t1 = [];
  List t2 = [];
  bool mainfrom = false;
  bool mainto = false;
  bool secfrom = false;
  bool secto = false;
  bool thirdfrom = false;
  bool thirdto = false;
  String _error = '';
  //==============snackbar for empty latlng============
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    var lang = Localizations.localeOf(context).languageCode;

    final snackBar = new SnackBar(
      content: new Text(
        _error,
        style: TextStyle(fontSize: 15, fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
      ),

      //duration: new Duration(seconds: 3),
      backgroundColor: Colors.deepOrange,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String latlng = '';
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

//=================end================
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
//-------------------checking internet connection
  bool _isInternet = true;
  checkInternet() async {
    try {
      final response = await InternetAddress.lookup('google.com');
      if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
        _isInternet = true; // internet
        setState(() {});
      }
    } on SocketException catch (_) {
      _isInternet = false; // no internet
      setState(() {});
    }
  }

  //------------the end --------------------
//--x is workdays list counter-----
  int _x = 6;
  @override
  void initState() {
    super.initState();
    checkInternet();
    _mainFromTime = TimeOfDay.now();
    _secondaryFromTime = TimeOfDay.now();
    _mainToTime = TimeOfDay(hour: 12, minute: 0);
    _secondaryToTime = TimeOfDay(hour: 12, minute: 0);
    _ternaryFromTime = TimeOfDay.now();
    _ternaryToTime = TimeOfDay(hour: 12, minute: 0);
    currentVacationDays = '';
    workDays01 = [];
    mainFromTimeString = '';
    mainToTimeString = '';
    secondaryFromTimeString = '';
    secondaryToTimeString = '';
    ternaryFromTimeString = '';
    ternaryToTimeString = '';
    while (_x >= 0) {
      setState(() {
        worksDays[_x] = false;
      });
      _x -= 1;
    }
  }

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final otherweekDaysList = {
      0: [worksDays[0], LocaleKeys.view_time_day_sunday.tr(), "sunday"],
      1: [worksDays[1], LocaleKeys.view_time_day_monday.tr(), "monday"],
      2: [worksDays[2], LocaleKeys.view_time_day_tuesday.tr(), "tuesday"],
      3: [worksDays[3], LocaleKeys.view_time_day_wednesday.tr(), "wednesday"],
      4: [worksDays[4], LocaleKeys.view_time_day_thursday.tr(), "thursday"],
      5: [worksDays[5], LocaleKeys.view_time_day_friday.tr(), "friday"],
      6: [worksDays[6], LocaleKeys.view_time_day_saturday.tr(), "saturday"],
    };

    void makeExceptions1() {
      exceptions1 = [];
      for (int key in otherweekDaysList.keys) {
        if (!otherweekDaysList[key][0] && otherweekDaysList[key][2] != ClinicDay.day2) {
          exceptions1.add(DropdownMenuItem<String>(child: Text(otherweekDaysList[key][1]), value: otherweekDaysList[key][2]));
        }
      }
    }

    void makeExceptions2() {
      exceptions2 = [];
      for (int key in otherweekDaysList.keys) {
        if (!otherweekDaysList[key][0] && otherweekDaysList[key][2] != ClinicDay.day1) {
          exceptions2.add(DropdownMenuItem<String>(child: Text(otherweekDaysList[key][1]), value: otherweekDaysList[key][2]));
        }
      }
    }

    // final textDirection = getTextDirection(locale);

    return Scaffold(
        key: _scaffoldkey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.deepOrange,
            title: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                LocaleKeys.view_doctor_update_info.tr(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            centerTitle: true,
          ),
        ),
        body: Center(
          child: Container(
            width: 100,
            padding: EdgeInsets.fromLTRB(0, 50, 0, 15),
            child: Form(
              key: _formkey,
              child: Container(
                child: ListView(
                  children: [
                    // _searchField(context, bloc),
                    // _buildLocation(bloc),

                    Container(
                      decoration: CStyle.box,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                LocaleKeys.view_doctor_detailed_address.tr(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 2,
                              indent: 50,
                              endIndent: 50,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: Directionality(
                                textDirection: ui.TextDirection.rtl,
                                child: TextFormField(
                                  validator: (val) => val.isEmpty ? LocaleKeys.view_doctor_address_validator.tr() : null,
                                  onChanged: (val) {
                                    setState(() => address = val);
                                  },
                                  decoration: CStyle.getInputDecoration(context).copyWith(
                                    hintText: 'مثال: الحارثيه شارع الكندي',
                                    hintStyle: TextStyle(fontSize: 12, color: Colors.deepOrange, fontFamily: 'noto_arabic'),
                                    labelText: 'عنوان العياده',
                                    labelStyle: TextStyle(color: Colors.grey[750], fontFamily: 'noto_arabic'),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: Text(
                                LocaleKeys.view_doctor_work_days.tr(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 2,
                              indent: 45,
                              endIndent: 45,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: WeekdaySelector(
                                onChanged: (int day) {
                                  setState(() {
                                    final index = day % 7;
                                    if (ClinicDay.day1 != otherweekDaysList[index][2] && ClinicDay.day2 != otherweekDaysList[index][2]) {
                                      worksDays[index] = !worksDays[index];

                                      workDays01 = boolToStringDays(context, worksDays);
                                      workDays01.removeWhere((value) => value == null);
                                      currentVacationDays = workDays01.join(', ');
                                      otherweekDaysList[index][0] = !otherweekDaysList[index][0];
                                      makeExceptions1();
                                      makeExceptions2();
                                    } else {
                                      _error = LocaleKeys.view_snack_error_dayselected.tr();
                                      _showSnackBar();
                                    }
                                  });
                                  print(workDays01);
                                },
                                values: worksDays,
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
                                // textDirection: textDirection,
                                fillColor: Colors.white,
                                selectedFillColor: Colors.deepOrange,
                                selectedElevation: 0,
                                elevation: 5,
                                selectedShape: CircleBorder(
                                  side: BorderSide(color: Colors.black, width: 1),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    child: RichText(
                                      text: TextSpan(
                                          text: LocaleKeys.view_time_day_from.tr(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '${_mainFromTime.format(context)}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: mainfrom ? Colors.deepOrange : Colors.black,
                                              ),
                                            ),
                                          ]),
                                    ),
                                    onTap: _pickMainFromTime,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.arrow_forward),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    child: RichText(
                                      text: TextSpan(
                                          text: LocaleKeys.view_time_day_to.tr(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '${_mainToTime.format(context)}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                color: mainto ? Colors.deepOrange : Colors.black,
                                              ),
                                            ),
                                          ]),
                                    ),
                                    onTap: _pickMainToTime,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SwitchListTile(
                                activeColor: Colors.deepOrange,
                                dense: true,
                                title: Text(
                                  LocaleKeys.view_doctor_expcetion_days.tr(),
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                ),
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
                        decoration: CStyle.box,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  LocaleKeys.view_doctor_expcetion_days.tr(),
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 2,
                                indent: 40,
                                endIndent: 40,
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
                                  items: exceptions1,
                                  onChanged: (value) {
                                    setState(() {
                                      weekday01 = value;
                                      if (e1.isEmpty) {
                                        e1.add(weekday01);
                                      } else {
                                        e1.remove(e1[0]);
                                        e1.add(weekday01);
                                      }
                                      ClinicDay.day1 = weekday01;
                                    });
                                    makeExceptions2();
                                    print(ClinicDay.day1);
                                    print(weekday01);
                                    print(e1);
                                  },
                                  value: weekday01,
                                  dropdownColor: Colors.white,
                                  elevation: 5,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: RichText(
                                        text: TextSpan(
                                            text: LocaleKeys.view_time_day_from.tr(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '${_secondaryFromTime.format(context)}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: secfrom ? Colors.deepOrange : Colors.black,
                                                ),
                                              ),
                                            ]),
                                      ),
                                      onTap: _pickSecondaryFromTime,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.arrow_forward),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      child: RichText(
                                        text: TextSpan(
                                            text: LocaleKeys.view_time_day_to.tr(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '${_secondaryToTime.format(context)}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: secto ? Colors.deepOrange : Colors.black,
                                                ),
                                              ),
                                            ]),
                                      ),
                                      onTap: _pickSecondaryToTime,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SwitchListTile(
                                  activeColor: Colors.deepOrange,
                                  dense: true,
                                  title: Text(
                                    LocaleKeys.view_doctor_expcetion_days.tr(),
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
                        decoration: CStyle.box,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  LocaleKeys.view_doctor_expcetion_days.tr(),
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 2,
                                indent: 40,
                                endIndent: 40,
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
                                  items: exceptions2,
                                  onChanged: (value) {
                                    setState(() {
                                      weekday02 = value;
                                      if (e2.isEmpty) {
                                        e2.add(weekday02);
                                      } else {
                                        e2.remove(e2[0]);
                                        e2.add(weekday02);
                                      }
                                      ClinicDay.day2 = weekday02;
                                    });
                                    makeExceptions1();
                                    print(e2);
                                    print(weekday02);
                                  },
                                  value: weekday02,
                                  dropdownColor: Colors.white,
                                  elevation: 5,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: RichText(
                                        text: TextSpan(
                                            text: LocaleKeys.view_time_day_from.tr(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '${_ternaryFromTime.format(context)}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: thirdfrom ? Colors.deepOrange : Colors.black,
                                                ),
                                              ),
                                            ]),
                                      ),
                                      onTap: _pickTernaryFromTime,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.arrow_forward),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      child: RichText(
                                        text: TextSpan(
                                            text: LocaleKeys.view_time_day_to.tr(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '${_ternaryToTime.format(context)}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: thirdto ? Colors.deepOrange : Colors.black,
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
                    Container(
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
                          checkInternet();
                          if (_isInternet) {
                            if (_formkey.currentState.validate()) {
                              setState(() {
                                if (e1.isNotEmpty && t1.isNotEmpty) {
                                  if (workDays0.isEmpty) {
                                    workDays0.add(e1[0]);
                                    workDays0.add(t1[0]);
                                  } else {
                                    workDays0 = [];
                                    workDays0.add(e1[0]);
                                    workDays0.add(t1[0]);
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
                              });
                              if (address != '' &&
                                  currentVacationDays != '' &&
                                  mainFromTimeString != '' &&
                                  mainToTimeString != '' &&
                                  makeMePass &&
                                  mainfrom &&
                                  mainto &&
                                  ((e1.isNotEmpty && t1.isNotEmpty) || (e1.isEmpty && t1.isEmpty)) &&
                                  ((e2.isNotEmpty && t2.isNotEmpty) || (e2.isEmpty && t2.isEmpty))) {
                                latlng = await getCoordinatesFromAddress(provinces[province] + ' ' + address);
                                setState(() {
                                  if (workDays01[workDays01.length - 1].length < 11) {
                                    workDays01.add(mainWorkingHours);
                                  } else {
                                    workDays01.remove(workDays01[workDays01.length - 1]);
                                    workDays01.add(mainWorkingHours);
                                  }
                                  makeMePass = false;
                                });
                                setState(() {
                                  DataFromProfiletoUpdate.name = name;
                                  DataFromProfiletoUpdate.speciality = speciality;
                                  DataFromProfiletoUpdate.phoneNumber = phoneNumber;
                                  DataFromProfiletoUpdate.province = province;
                                  DataFromProfiletoUpdate.address = address;
                                  DataFromProfiletoUpdate.workDays01 = List<String>.from(workDays01);
                                  DataFromProfiletoUpdate.workDays02 = List<String>.from(workDays0);
                                  DataFromProfiletoUpdate.workDays03 = List<String>.from(workDays03);
                                });
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MainUpdateMap(
                                      latlng: latlng,
                                    ),
                                  ),
                                );
                                mainfrom = false;
                                mainto = false;
                              } else if (currentVacationDays == '') {
                                _error = LocaleKeys.view_snack_error_selectmaindays.tr();
                                _showSnackBar();
                              } else if (mainFromTimeString == '' || mainToTimeString == '' || !mainfrom || !mainto) {
                                _error = LocaleKeys.view_snack_error_Select_time.tr();
                                _showSnackBar();
                              } else if (!((e1.isNotEmpty && t1.isNotEmpty) || (e1.isEmpty && t1.isEmpty))) {
                                if (e1.isEmpty) {
                                  _error = LocaleKeys.view_snack_error_choose_1st_exception_day.tr();
                                  _showSnackBar();
                                } else {
                                  _error = LocaleKeys.view_snack_error_choose_1st_exception_time.tr();
                                  _showSnackBar();
                                }
                              } else if (!((e2.isNotEmpty && t2.isNotEmpty) || (e2.isEmpty && t2.isEmpty))) {
                                if (e2.isEmpty) {
                                  _error = LocaleKeys.view_snack_error_choose_2nd_exception_day.tr();
                                  _showSnackBar();
                                } else {
                                  _error = LocaleKeys.view_snack_error_choose_2nd_exception_time.tr();
                                  _showSnackBar();
                                }
                              }
                            }
                          } else {
                            _error = LocaleKeys.view_snack_error_snack_connectivity.tr();
                            _showSnackBar();
                          }
                        },
                        label: Text(
                          LocaleKeys.view_buttons_google_map.tr(),
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  _pickMainFromTime() async {
    TimeOfDay mainfromTime = await showTimePicker(
        context: context,
        initialTime: _mainFromTime,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData(
              primaryColor: Colors.deepOrange,
              accentColor: Colors.deepOrange,
              primarySwatch: Colors.deepOrange,
            ),
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            ),
          );
        });
    if (mainfromTime != null)
      setState(() {
        _mainFromTime = mainfromTime;
        mainFromTimeString = _mainFromTime.format(context);
        mainFromNo = mainFromTimeString.substring(0, mainFromTimeString.indexOf(' '));
        fromEnd = mainFromTimeString.substring(mainFromTimeString.indexOf(' '), mainFromTimeString.length);
        if (fromEnd.contains('ص') || fromEnd.contains('AM')) {
          fromAmPm = 'AM';
        } else if (fromEnd == ' م' || fromEnd.contains('PM')) {
          fromAmPm = 'PM';
        }
        mainFromTimeString = mainFromNo + ' ' + fromAmPm;
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
          return Theme(
            data: ThemeData(
              primaryColor: Colors.deepOrange,
              accentColor: Colors.deepOrange,
              primarySwatch: Colors.deepOrange,
            ),
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            ),
          );
        });
    if (maintoTime != null)
      setState(() {
        _mainToTime = maintoTime;
        mainToTimeString = _mainToTime.format(context);
        print(mainToTimeString);
        mainToNo = mainToTimeString.substring(0, mainToTimeString.indexOf(' '));
        toEnd = mainToTimeString.substring(mainToTimeString.indexOf(' ') + 1, mainToTimeString.length);
        if (toEnd.contains('ص') || toEnd.contains('AM')) {
          toAmPm = "AM";
        } else {
          toAmPm = 'PM';
        }
        mainToTimeString = mainToNo + ' ' + toAmPm;
        if (mainFromTimeString != '') {
          mainWorkingHours = 'from ' + mainFromTimeString + ' to ' + mainToTimeString;
          makeMePass = true;
        }
        mainto = true;
      });
  }

  _pickSecondaryFromTime() async {
    TimeOfDay secondaryFromTime = await showTimePicker(
        context: context,
        initialTime: _secondaryFromTime,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData(
              primaryColor: Colors.deepOrange,
              accentColor: Colors.deepOrange,
              primarySwatch: Colors.deepOrange,
            ),
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            ),
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
        if (secondaryToTimeString != '') {
          secondaryWorkingHours = 'from ' + secondaryFromTimeString + ' to ' + secondaryToTimeString;
          if (t1.length == 0) {
            t1.add(secondaryWorkingHours);
          } else if (t1.length >= 1) {
            t1 = [];
            t1.add(secondaryWorkingHours);
          }
        }
        secfrom = true;
      });
  }

  _pickSecondaryToTime() async {
    TimeOfDay secondaryToTime = await showTimePicker(
        context: context,
        initialTime: _secondaryToTime,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData(
              primaryColor: Colors.deepOrange,
              accentColor: Colors.deepOrange,
              primarySwatch: Colors.deepOrange,
            ),
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            ),
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
        } else if (secondToEnd.characters.contains('م') || secondToEnd.contains('PM')) {
          secondToAmPm = 'PM';
        }
        secondaryToTimeString = secondToNo + ' ' + secondToAmPm;
        if (secondaryFromTimeString != '') {
          secondaryWorkingHours = 'from ' + secondaryFromTimeString + ' to ' + secondaryToTimeString;
          if (t1.length == 0) {
            t1.add(secondaryWorkingHours);
          } else if (t1.length >= 1) {
            t1 = [];
            t1.add(secondaryWorkingHours);
          }
        }
        secto = true;
      });
  }

  _pickTernaryFromTime() async {
    TimeOfDay ternaryFromTime = await showTimePicker(
        context: context,
        initialTime: _ternaryFromTime,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData(
              primaryColor: Colors.deepOrange,
              accentColor: Colors.deepOrange,
              primarySwatch: Colors.deepOrange,
            ),
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            ),
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
        thirdfrom = true;
        ternaryFromTimeString = thirdFromNo + ' ' + thirdFromAmPm;
        if (ternaryToTimeString != '') {
          ternaryWorkingHours = 'from ' + ternaryFromTimeString + ' to ' + ternaryToTimeString;
          if (t2.length == 0) {
            t2.add(ternaryWorkingHours);
          } else if (t2.length >= 1) {
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
          return Theme(
            data: ThemeData(
              primaryColor: Colors.deepOrange,
              accentColor: Colors.deepOrange,
              primarySwatch: Colors.deepOrange,
            ),
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            ),
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
          if (t2.length == 0) {
            t2.add(ternaryWorkingHours);
          } else if (t2.length >= 1) {
            t2 = [];
            t2.add(ternaryWorkingHours);
          }
        }
        thirdto = true;
      });
  }
}