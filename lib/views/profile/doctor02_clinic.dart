import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/constants/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:ui' as ui;
import 'package:project_doctor/services/database.dart';
import 'package:provider/provider.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'dart:ui';
import 'doctor03_map.dart';

class ClinicDay {
  static String day1;
  static String day2;
}

class GrandClinicForm extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  final String speciality;
  final String phoneNumber;
  final String province;
  GrandClinicForm({this.email, this.password, this.name, this.phoneNumber, this.speciality, this.province});
  @override
  _GrandClinicFormState createState() =>
      _GrandClinicFormState(email: email, password: password, name: name, speciality: speciality, phoneNumber: phoneNumber, province: province);
}

class _GrandClinicFormState extends State<GrandClinicForm> {
  String email;
  String password;
  String name;
  String speciality;
  String phoneNumber;
  String province;
  _GrandClinicFormState({
    this.email,
    this.password,
    this.name,
    this.speciality,
    this.phoneNumber,
    this.province,
  });

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().usersDataStream,
      child: ClinicForm(
        email: email,
        password: password,
        name: name,
        speciality: speciality,
        phoneNumber: phoneNumber,
        province: province,
      ),
    );
  }
}

class ClinicForm extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  final String speciality;
  final String phoneNumber;
  final String province;

  ClinicForm({this.email, this.password, this.name, this.phoneNumber, this.speciality, this.province});

  @override
  _ClinicFormState createState() =>
      _ClinicFormState(email: email, password: password, name: name, speciality: speciality, phoneNumber: phoneNumber, province: province);
}

List<DropdownMenuItem<String>> exception1 = [];
List<DropdownMenuItem<String>> exception2 = [];
final _formKey = GlobalKey<FormState>();
// const String apiKey = 'ApiKey';
String currentaddress = '';
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

// print int as days for weekday selector widget
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

// TextDirection getTextDirection(Locale locale) {
//   const rtlLanguages = ['ar'];
//   return rtlLanguages.contains(locale.languageCode) ? TextDirection.rtl : TextDirection.ltr;
// }

class _ClinicFormState extends State<ClinicForm> {
  // final _places = GoogleMapsPlaces(apiKey: apiKey);
  String email;
  String password;
  String name;
  String speciality;
  String phoneNumber;
  String province;
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
  String _error;
  _ClinicFormState({
    this.email,
    this.password,
    this.name,
    this.speciality,
    this.phoneNumber,
    this.province,
  });
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
//===============end==================
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

  //---this variable is assigned to make workdays element false---
  int _x = 6;
  //=======bool value to inspect wether the doctor is registered===
  bool registered = false;
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
    registered = false;
  }

  @override
  Widget build(BuildContext context) {
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

    // final bloc = LocationProvider.of(context);
    // final locale = Localizations.localeOf(context);
    // final textDirection = getTextDirection(locale);
    //=====to see wether the current user is registered already===
    final doctorDocs = Provider.of<QuerySnapshot>(context);
    if (doctorDocs != null) {
      for (var x in doctorDocs.docs) {
        if (name == x.data()['name'] && speciality == x.data()['speciality'] && province == x.data()['province']) {
          setState(() {
            registered = true;
          });
        }
      }
    }

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
              LocaleKeys.view_doctor_doctor_form.tr(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
      ),
      body: Center(
        child: Container(
          width: 100,
          padding: EdgeInsets.fromLTRB(0, 50, 0, 15),
          child: Form(
            key: _formKey,
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
                                  setState(() => currentaddress = val);
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
                                    _error = LocaleKeys.view_snack_error_dayselected.tr();
                                    _showSnackBar();
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                LocaleKeys.view_doctor_location_setup.tr(),
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              Icon(
                                Icons.arrow_downward,
                                size: 20,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            width: 150,
                            child: ButtonTheme(
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
                                    if (_formKey.currentState.validate()) {
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
                                      if (currentaddress != '' &&
                                          currentWorkDays != '' &&
                                          mainFromTimeString != '' &&
                                          mainToTimeString != '' &&
                                          makeMePass &&
                                          mainfrom &&
                                          mainto &&
                                          ((e1.isNotEmpty && t1.isNotEmpty) || (e1.isEmpty && t1.isEmpty)) &&
                                          ((e2.isNotEmpty && t2.isNotEmpty) || (e2.isEmpty && t2.isEmpty))) {
                                        latlng = await getCoordinatesFromAddress(provinces[province] + ' ' + currentaddress);
                                        if (!registered) {
                                          setState(() {
                                            if (workDays01[workDays01.length - 1].length < 11) {
                                              workDays01.add(mainWorkingHours);
                                            } else {
                                              workDays01.remove(workDays01[workDays01.length - 1]);
                                              workDays01.add(mainWorkingHours);
                                            }

                                            makeMePass = false;
                                            print(workDays01);
                                          });
                                          mainfrom = false;
                                          mainto = false;
                                          setState(() {
                                            DataFromMaptoVerify.email = email;
                                            DataFromMaptoVerify.password = password;
                                            DataFromMaptoVerify.name = name;
                                            DataFromMaptoVerify.speciality = speciality;
                                            DataFromMaptoVerify.phoneNumber = phoneNumber;
                                            DataFromMaptoVerify.province = province;
                                            DataFromMaptoVerify.address = currentaddress;
                                            DataFromMaptoVerify.workDays01 = List<String>.from(workDays01);
                                            DataFromMaptoVerify.workDays02 = List<String>.from(workDays02);
                                            DataFromMaptoVerify.workDays03 = List<String>.from(workDays03);
                                          });
                                          print(latlng);
                                          await Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => DocMap(
                                                addresslatlng: latlng.toString(),
                                              ),
                                            ),
                                          );
                                        } else if (registered) {
                                          setState(() {
                                            _error = LocaleKeys.view_snack_error_already_registered.tr();
                                          });
                                          _showSnackBar();
                                        }
                                      } else if (currentWorkDays == '') {
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
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

  // Widget _searchField(BuildContext context, LocationBloc bloc) {
  //   return LocationProvider(
  //     child: StreamBuilder(
  //       stream: bloc.locationString,
  //       builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
  //         var _controller = TextEditingController();
  //         _controller.text = snapshot.data;
  //         return TextField(
  //           controller: _controller,
  //           decoration: InputDecoration(hintText: "Search"),
  //           onTap: () async {
  //             Prediction p = await PlacesAutocomplete.show(
  //               context: context,
  //               apiKey: apiKey,
  //               mode: Mode.overlay,
  //               language: "en",
  //             );

  //             PlacesDetailsResponse response =
  //                 await _places.getDetailsByPlaceId(p.placeId);
  //             var location = response.result.geometry.location;
  //             var latLng = LatLng(location.lat, location.lng);
  //             bloc.changeLocationString(response.result.formattedAddress);
  //             bloc.changeLocationLatLng(latLng);
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  // Widget _buildLocation(LocationBloc bloc) {
  //   return StreamBuilder(
  //     stream: bloc.locationLatLng,
  //     builder: (BuildContext context, AsyncSnapshot<LatLng> snapshot) {
  //       return Column(
  //         children: <Widget>[
  //           Row(
  //             children: <Widget>[
  //               Container(
  //                 width: 80,
  //                 child: Text('latitude: '),
  //               ),
  //               Text('${snapshot.hasData ? snapshot.data.latitude : ''}')
  //             ],
  //           ),
  //           Row(
  //             children: <Widget>[
  //               Container(
  //                 width: 80,
  //                 child: Text('longitude: '),
  //               ),
  //               Text('${snapshot.hasData ? snapshot.data.longitude : ''}')
  //             ],
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

}
