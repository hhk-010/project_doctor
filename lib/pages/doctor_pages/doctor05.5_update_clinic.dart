import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/pages/doctor_pages/doctor06_update_map.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:weekday_selector/weekday_selector.dart';

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
  _UpdateInfo2State createState() => _UpdateInfo2State(
      name: name,
      speciality: speciality,
      phoneNumber: phoneNumber,
      province: province);
}

List<DropdownMenuItem<String>> exceptions1 = List();
List<DropdownMenuItem<String>> exceptions2 = List();
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

TextDirection getTextDirection(Locale locale) {
  const rtlLanguages = ['ar'];
  return rtlLanguages.contains(locale.languageCode)
      ? TextDirection.rtl
      : TextDirection.ltr;
}

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
  _UpdateInfo2State(
      {this.name, this.speciality, this.phoneNumber, this.province});

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
        style: TextStyle(
            fontSize: 15,
            fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
      ),

      //duration: new Duration(seconds: 3),
      backgroundColor: Colors.deepOrange,
    );
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

//--x is workdays list counter-----
  int _x = 6;
  @override
  void initState() {
    super.initState();
    _mainFromTime = TimeOfDay.now();
    _secondaryFromTime = TimeOfDay.now();
    _mainToTime = TimeOfDay(hour: 12, minute: 0);
    _secondaryToTime = TimeOfDay(hour: 12, minute: 0);
    _ternaryFromTime = TimeOfDay.now();
    _ternaryToTime = TimeOfDay(hour: 12, minute: 0);
    currentVacationDays = '';
    workDays01 = [];
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
      0: [
        worksDays[0],
        AppLocalizations.of(context).translate('sunday'),
        "sunday"
      ],
      1: [
        worksDays[1],
        AppLocalizations.of(context).translate('monday'),
        "monday"
      ],
      2: [
        worksDays[2],
        AppLocalizations.of(context).translate('tuesday'),
        "tuesday"
      ],
      3: [
        worksDays[3],
        AppLocalizations.of(context).translate('wednesday'),
        "wednesday"
      ],
      4: [
        worksDays[4],
        AppLocalizations.of(context).translate('thursday'),
        "thursday"
      ],
      5: [
        worksDays[5],
        AppLocalizations.of(context).translate('friday'),
        "friday"
      ],
      6: [
        worksDays[6],
        AppLocalizations.of(context).translate('saturday'),
        "saturday"
      ],
    };

    void makeExceptions1() {
      exceptions1 = [];
      for (int key in otherweekDaysList.keys) {
        if (!otherweekDaysList[key][0] &&
            otherweekDaysList[key][2] != ClinicDay.day2) {
          exceptions1.add(DropdownMenuItem<String>(
              child: Text(otherweekDaysList[key][1]),
              value: otherweekDaysList[key][2]));
        }
      }
    }

    void makeExceptions2() {
      exceptions2 = [];
      for (int key in otherweekDaysList.keys) {
        if (!otherweekDaysList[key][0] &&
            otherweekDaysList[key][2] != ClinicDay.day1) {
          exceptions2.add(DropdownMenuItem<String>(
              child: Text(otherweekDaysList[key][1]),
              value: otherweekDaysList[key][2]));
        }
      }
    }

    final locale = Localizations.localeOf(context);
    final textDirection = getTextDirection(locale);
    return Scaffold(
        key: _scaffoldkey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              AppLocalizations.of(context).translate('update_info'),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 35),
          child: Form(
            key: _formkey,
            child: Container(
              child: ListView(
                children: [
                  // _searchField(context, bloc),
                  // _buildLocation(bloc),

                  Container(
                    decoration: boxDecoration,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              AppLocalizations.of(context).translate(
                                'detailed_address',
                              ),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 18,
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
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                validator: (val) => val.isEmpty
                                    ? AppLocalizations.of(context)
                                        .translate('address_validator')
                                    : null,
                                onChanged: (val) =>
                                    setState(() => address = val),
                                decoration: textInputdecoration.copyWith(
                                  hintText:
                                      'مثال: شارع المغرب مجاور صيدليه الشفاء',
                                  hintStyle: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.deepOrange,
                                      fontFamily: 'noto_arabic'),
                                  labelText: 'عنوان العياده',
                                  labelStyle: TextStyle(
                                      color: Colors.grey[750],
                                      fontFamily: 'noto_arabic'),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: Text(
                              AppLocalizations.of(context).translate(
                                'work_days',
                              ),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 2,
                            indent: 70,
                            endIndent: 70,
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
                                  if (ClinicDay.day1 !=
                                          otherweekDaysList[index][2] &&
                                      ClinicDay.day2 !=
                                          otherweekDaysList[index][2]) {
                                    worksDays[index] = !worksDays[index];

                                    workDays01 =
                                        boolToStringDays(context, worksDays);
                                    workDays01
                                        .removeWhere((value) => value == null);
                                    currentVacationDays = workDays01.join(', ');
                                    otherweekDaysList[index][0] =
                                        !otherweekDaysList[index][0];
                                    makeExceptions1();
                                    makeExceptions2();
                                  } else {
                                    _error = AppLocalizations.of(context)
                                        .translate("dayselected");
                                    _showSnackBar();
                                  }
                                });
                                print(workDays01);
                              },
                              values: worksDays,
                              firstDayOfWeek: DateTime.sunday,
                              shortWeekdays: [
                                AppLocalizations.of(context).translate('sun'),
                                AppLocalizations.of(context).translate('mon'),
                                AppLocalizations.of(context).translate('tue'),
                                AppLocalizations.of(context).translate('wed'),
                                AppLocalizations.of(context).translate('thu'),
                                AppLocalizations.of(context).translate('fri'),
                                AppLocalizations.of(context).translate('sat'),
                              ],
                              weekdays: [
                                AppLocalizations.of(context)
                                    .translate('sunday'),
                                AppLocalizations.of(context)
                                    .translate('monday'),
                                AppLocalizations.of(context)
                                    .translate('tuesday'),
                                AppLocalizations.of(context)
                                    .translate('wednesday'),
                                AppLocalizations.of(context)
                                    .translate('thursday'),
                                AppLocalizations.of(context)
                                    .translate('friday'),
                                AppLocalizations.of(context)
                                    .translate('saturday'),
                              ],
                              textDirection: textDirection,
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
                                        text: AppLocalizations.of(context)
                                            .translate('from'),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                '${_mainFromTime.format(context)}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: mainfrom
                                                  ? Colors.deepOrange
                                                  : Colors.black,
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
                                        text: AppLocalizations.of(context)
                                            .translate('to'),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                '${_mainToTime.format(context)}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: mainto
                                                  ? Colors.deepOrange
                                                  : Colors.black,
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
                                AppLocalizations.of(context)
                                    .translate('expcetion_days'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
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
                      decoration: boxDecoration,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 15),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('expcetion_days'),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
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
                                  AppLocalizations.of(context)
                                      .translate('select_days'),
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
                                          text: AppLocalizations.of(context)
                                              .translate('from'),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  '${_secondaryFromTime.format(context)}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: secfrom
                                                    ? Colors.deepOrange
                                                    : Colors.black,
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
                                          text: AppLocalizations.of(context)
                                              .translate('to'),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  '${_secondaryToTime.format(context)}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: secto
                                                    ? Colors.deepOrange
                                                    : Colors.black,
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
                                  AppLocalizations.of(context)
                                      .translate('expcetion_days'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
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
                      decoration: boxDecoration,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 15),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('expcetion_days'),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
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
                                  AppLocalizations.of(context)
                                      .translate('select_days'),
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
                                          text: AppLocalizations.of(context)
                                              .translate('from'),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  '${_ternaryFromTime.format(context)}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: thirdfrom
                                                    ? Colors.deepOrange
                                                    : Colors.black,
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
                                          text: AppLocalizations.of(context)
                                              .translate('to'),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  '${_ternaryToTime.format(context)}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: thirdto
                                                    ? Colors.deepOrange
                                                    : Colors.black,
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
                    height: 40,
                    width: double.maxFinite,
                    child: RaisedButton.icon(
                      color: Colors.deepOrange,
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                          print(mainWorkingHours);
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
                            } else if ((e1.isNotEmpty && t1.isEmpty) ||
                                (e1.isEmpty && t1.isNotEmpty)) {
                              //show snackbar
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
                            } else if ((e2.isNotEmpty && t2.isEmpty) ||
                                (e2.isEmpty && t2.isNotEmpty)) {
                              //show snackbar
                            }
                          });
                          //main from time='' snackbar
                          //main to time='' snackbar
                          //main days =[] snackbar
                          //reselct main days snackbar
                          if (address != '' &&
                              currentVacationDays != '' &&
                              mainFromTimeString != '' &&
                              mainToTimeString != '' &&
                              makeMePass == true &&
                              ((e1.isNotEmpty && t1.isNotEmpty) ||
                                  (e1.isEmpty && t1.isEmpty)) &&
                              ((e2.isNotEmpty && t2.isNotEmpty) ||
                                  (e2.isEmpty && t2.isEmpty))) {
                            setState(() {
                              if (workDays01[workDays01.length - 1].length <
                                  11) {
                                workDays01.add(mainWorkingHours);
                              } else {
                                workDays01
                                    .remove(workDays01[workDays01.length - 1]);
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
                              DataFromProfiletoUpdate.workDays01 =
                                  List<String>.from(workDays01);
                              DataFromProfiletoUpdate.workDays02 =
                                  List<String>.from(workDays0);
                              DataFromProfiletoUpdate.workDays03 =
                                  List<String>.from(workDays03);
                            });
                            print(workDays01);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MainUpdateMap(),
                              ),
                            );
                            mainfrom = false;
                            mainto = false;
                          } else if (currentVacationDays == '') {
                            _error = AppLocalizations.of(context)
                                .translate('selectmaindays');
                            _showSnackBar();
                          } else if (mainFromTimeString == '' ||
                              mainToTimeString == '' ||
                              !mainfrom ||
                              !mainto) {
                            _error = AppLocalizations.of(context)
                                .translate('Select time');
                            _showSnackBar();
                          } else if (!((e1.isNotEmpty && t1.isNotEmpty) ||
                              (e1.isEmpty && t1.isEmpty))) {
                            if (e1.isEmpty) {
                              _error = AppLocalizations.of(context)
                                  .translate('choose 1st exceprion day');
                              _showSnackBar();
                            } else {
                              _error = AppLocalizations.of(context)
                                  .translate('choose 1st exception time');
                              _showSnackBar();
                            }
                          } else if (!((e2.isNotEmpty && t2.isNotEmpty) ||
                              (e2.isEmpty && t2.isEmpty))) {
                            if (e2.isEmpty) {
                              _error = AppLocalizations.of(context)
                                  .translate('choose 2nd exception day');
                              _showSnackBar();
                            } else {
                              _error = AppLocalizations.of(context)
                                  .translate('choose 2nd exception time');
                              _showSnackBar();
                            }
                          }
                        }
                      },
                      label: Text(
                        AppLocalizations.of(context).translate('google_map'),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
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
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            ),
          );
        });
    if (mainfromTime != null)
      setState(() {
        _mainFromTime = mainfromTime;
        mainFromTimeString = _mainFromTime.format(context);
        mainFromNo =
            mainFromTimeString.substring(0, mainFromTimeString.indexOf(' '));
        fromEnd = mainFromTimeString.substring(
            mainFromTimeString.indexOf(' '), mainFromTimeString.length);
        if (fromEnd.contains('ص') || fromEnd.contains('AM')) {
          fromAmPm = 'AM';
        } else if (fromEnd == ' م' || fromEnd.contains('PM')) {
          fromAmPm = 'PM';
        }
        mainFromTimeString = mainFromNo + ' ' + fromAmPm;
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
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
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
        toEnd = mainToTimeString.substring(
            mainToTimeString.indexOf(' ') + 1, mainToTimeString.length);
        if (toEnd.contains('ص') || toEnd.contains('AM')) {
          toAmPm = "AM";
        } else {
          toAmPm = 'PM';
        }
        mainToTimeString = mainToNo + ' ' + toAmPm;
        mainWorkingHours =
            'from ' + mainFromTimeString + ' to ' + mainToTimeString;
        makeMePass = true;
        mainto = true;
        print(mainWorkingHours);
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
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            ),
          );
        });
    if (secondaryFromTime != null)
      setState(() {
        _secondaryFromTime = secondaryFromTime;
        secondaryFromTimeString = _secondaryFromTime.format(context);
        secondFromNo = secondaryFromTimeString.substring(
            0, secondaryFromTimeString.indexOf(' '));
        secondFromEnd = secondaryFromTimeString.substring(
            secondaryFromTimeString.indexOf(' '),
            secondaryFromTimeString.length);
        if (secondFromEnd.contains('ص') || secondFromEnd.contains('AM')) {
          secondFromAmPm = 'AM';
        } else {
          secondFromAmPm = 'PM';
        }
        secondaryFromTimeString = secondFromNo + ' ' + secondFromAmPm;
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
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            ),
          );
        });
    if (secondaryToTime != null)
      setState(() {
        _secondaryToTime = secondaryToTime;
        secondaryToTimeString = _secondaryToTime.format(context);
        secondToNo = secondaryToTimeString.substring(
            0, secondaryToTimeString.indexOf(' '));
        secondToEnd = secondaryToTimeString.substring(
            secondaryToTimeString.indexOf(' '), secondaryToTimeString.length);
        if (secondToEnd.contains('ص') || secondToEnd.contains('AM')) {
          secondToAmPm = 'AM';
        } else if (secondToEnd.characters.contains('م') ||
            secondToEnd.contains('PM')) {
          secondToAmPm = 'PM';
        }
        secondaryToTimeString = secondToNo + ' ' + secondToAmPm;
        secondaryWorkingHours =
            'from ' + secondaryFromTimeString + ' to ' + secondaryToTimeString;
        if (t1.length == 0) {
          t1.add(secondaryWorkingHours);
        } else if (t1.length >= 1) {
          t1 = [];
          t1.add(secondaryWorkingHours);
        }
        secto = true;
        print(secondaryWorkingHours);
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
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            ),
          );
        });
    if (ternaryFromTime != null)
      setState(() {
        _ternaryFromTime = ternaryFromTime;
        ternaryFromTimeString = _ternaryFromTime.format(context);
        thirdFromNo = ternaryFromTimeString.substring(
            0, ternaryFromTimeString.indexOf(' '));
        thirdFromEnd = ternaryFromTimeString.substring(
            ternaryFromTimeString.indexOf(' '), ternaryFromTimeString.length);
        if (thirdFromEnd.contains('ص') || thirdFromEnd.contains('AM')) {
          thirdFromAmPm = 'AM';
        } else {
          thirdFromAmPm = 'PM';
        }
        thirdfrom = true;
        ternaryFromTimeString = thirdFromNo + ' ' + thirdFromAmPm;
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
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            ),
          );
        });
    if (ternaryToTime != null)
      setState(() {
        _ternaryToTime = ternaryToTime;
        ternaryToTimeString = _ternaryToTime.format(context);
        thirdToNo =
            ternaryToTimeString.substring(0, ternaryToTimeString.indexOf(' '));
        thirdToEnd = ternaryToTimeString.substring(
            ternaryToTimeString.indexOf(' '), ternaryToTimeString.length);
        if (thirdToEnd.contains('ص') || thirdToEnd.contains('AM')) {
          thirdToAmPm = 'AM';
        } else {
          thirdToAmPm = 'PM';
        }
        ternaryToTimeString = thirdToNo + ' ' + thirdToAmPm;
        ternaryWorkingHours =
            'from ' + ternaryFromTimeString + ' to ' + ternaryToTimeString;
        if (t2.length == 0) {
          t2.add(ternaryWorkingHours);
        } else if (t2.length >= 1) {
          t2 = [];
          t2.add(ternaryWorkingHours);
        }
        thirdto = true;
        print(ternaryWorkingHours);
      });
  }
}
