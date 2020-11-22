import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'dart:ui';
import 'doctor03_map.dart';

class ClinicDay {
  static String day1;
  static String day2;
}

class ClinicForm extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  final String speciality;
  final String phoneNumber;
  final String province;

  ClinicForm(
      {this.email,
      this.password,
      this.name,
      this.phoneNumber,
      this.speciality,
      this.province});

  @override
  _ClinicFormState createState() => _ClinicFormState(
      email: email,
      password: password,
      name: name,
      speciality: speciality,
      phoneNumber: phoneNumber,
      province: province);
}

List<DropdownMenuItem<String>> exception1 = List();
List<DropdownMenuItem<String>> exception2 = List();
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
    workDays[0]
        ? "sunday"
        : null, //AppLocalizations.of(context).translate('sunday') : null,
    workDays[1]
        ? "monday"
        : null, //AppLocalizations.of(context).translate('monday') : null,
    workDays[2]
        ? "tuesday"
        : null, //AppLocalizations.of(context).translate('tuesday') : null,
    workDays[3]
        ? "wednesday"
        : null, //AppLocalizations.of(context).translate('wednesday') : null,
    workDays[4]
        ? "thursday"
        : null, //AppLocalizations.of(context).translate('thursday') : null,
    workDays[5]
        ? "friday"
        : null, //AppLocalizations.of(context).translate('friday') : null,
    workDays[6]
        ? "saturday"
        : null, //AppLocalizations.of(context).translate('saturday') : null,
  ];
}

TextDirection getTextDirection(Locale locale) {
  const rtlLanguages = ['ar'];
  return rtlLanguages.contains(locale.languageCode)
      ? TextDirection.rtl
      : TextDirection.ltr;
}

class _ClinicFormState extends State<ClinicForm> {
  // final _places = GoogleMapsPlaces(apiKey: apiKey);
  String email;
  String password;
  String name;
  String speciality;
  String phoneNumber;
  String province;
  List workDays01 = [];
  List workDays02 = [];
  List workDays03 = [];
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
        style: TextStyle(
            fontSize: 15,
            fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
      ),

      //duration: new Duration(seconds: 3),
      backgroundColor: Colors.deepOrange,
    );
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    _mainFromTime = TimeOfDay.now();
    _secondaryFromTime = TimeOfDay.now();
    _mainToTime = TimeOfDay(hour: 12, minute: 0);
    _secondaryToTime = TimeOfDay(hour: 12, minute: 0);
    _ternaryFromTime = TimeOfDay.now();
    _ternaryToTime = TimeOfDay(hour: 12, minute: 0);
  }

  @override
  Widget build(BuildContext context) {
    final weekDaysList = {
      0: [
        workDays[0],
        AppLocalizations.of(context).translate('sunday'),
        "sunday"
      ],
      1: [
        workDays[1],
        AppLocalizations.of(context).translate('monday'),
        "monday"
      ],
      2: [
        workDays[2],
        AppLocalizations.of(context).translate('tuesday'),
        "tuesday"
      ],
      3: [
        workDays[3],
        AppLocalizations.of(context).translate('wednesday'),
        "wednesday"
      ],
      4: [
        workDays[4],
        AppLocalizations.of(context).translate('thursday'),
        "thursday"
      ],
      5: [
        workDays[5],
        AppLocalizations.of(context).translate('friday'),
        "friday"
      ],
      6: [
        workDays[6],
        AppLocalizations.of(context).translate('saturday'),
        "saturday"
      ],
    };
    void makeException1() {
      exception1 = [];
      for (int key in weekDaysList.keys) {
        if (!weekDaysList[key][0] && weekDaysList[key][2] != ClinicDay.day2) {
          exception1.add(DropdownMenuItem<String>(
              child: Text(weekDaysList[key][1]), value: weekDaysList[key][2]));
        }
      }
    }

    void makeException2() {
      exception2 = [];
      for (int key in weekDaysList.keys) {
        if (!weekDaysList[key][0] && weekDaysList[key][2] != ClinicDay.day1) {
          exception2.add(DropdownMenuItem<String>(
              child: Text(weekDaysList[key][1]), value: weekDaysList[key][2]));
        }
      }
    }

    // final bloc = LocationProvider.of(context);
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
            AppLocalizations.of(context).translate('doctor_form'),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 35),
        child: Form(
          key: _formKey,
          child: Container(
            child: ListView(
              children: [
                // _searchField(context, bloc),
                // _buildLocation(bloc),

                Container(
                  decoration: boxDecoration,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
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
                                  setState(() => currentaddress = val),
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
                                if (ClinicDay.day1 != weekDaysList[index][2] &&
                                    ClinicDay.day2 != weekDaysList[index][2]) {
                                  workDays[index] = !workDays[index];
                                  workDays01 =
                                      boolToStringDays(context, workDays);
                                  workDays01
                                      .removeWhere((value) => value == null);
                                  currentWorkDays = workDays01.join(', ');
                                  weekDaysList[index][0] = workDays[index];
                                  //!weekDaysList[index][0];
                                  makeException1();
                                  makeException2();
                                } else {
                                  _error = AppLocalizations.of(context)
                                      .translate("dayselected");
                                  _showSnackBar();
                                }
                              });
                            },
                            values: workDays,
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
                              AppLocalizations.of(context).translate('sunday'),
                              AppLocalizations.of(context).translate('monday'),
                              AppLocalizations.of(context).translate('tuesday'),
                              AppLocalizations.of(context)
                                  .translate('wednesday'),
                              AppLocalizations.of(context)
                                  .translate('thursday'),
                              AppLocalizations.of(context).translate('friday'),
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
                                print(weekday01);
                                print(e1);
                                print(ClinicDay.day1);
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
                                    fontWeight: FontWeight.bold, fontSize: 16),
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
                                print(weekday02);
                                print(e2);
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)
                                  .translate('location_setup'),
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                        ButtonTheme(
                          minWidth: double.infinity,
                          child: RaisedButton.icon(
                            color: Colors.deepOrange,
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0)),
                            onPressed: () async {
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
                                } else if ((e1.isEmpty && t1.isNotEmpty) ||
                                    (e1.isNotEmpty && t1.isEmpty)) {
                                  //snackbar
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
                                  //snackbar
                                }
                                print(workDays02);
                                print(workDays03);
                                if (currentaddress != '' &&
                                    currentWorkDays != '' &&
                                    mainFromTimeString != '' &&
                                    mainToTimeString != '' &&
                                    makeMePass == true &&
                                    ((e1.isNotEmpty && t1.isNotEmpty) ||
                                        (e1.isEmpty && t1.isEmpty)) &&
                                    ((e2.isNotEmpty && t2.isNotEmpty) ||
                                        (e2.isEmpty && t2.isEmpty))) {
                                  setState(() {
                                    if (mainWorkingHours == '') {
                                      workDays01.add(mainWorkingHours);
                                    } else {
                                      workDays01.remove(
                                          workDays01[workDays01.length - 1]);
                                      workDays01.add(mainWorkingHours);
                                    }
                                    makeMePass = false;
                                    print(workDays01);
                                  });
                                  mainfrom = false;
                                  mainto = false;
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DocMap(
                                        email: email,
                                        password: password,
                                        name: name,
                                        speciality: speciality,
                                        phone: phoneNumber,
                                        province: province,
                                        address: currentaddress,
                                        workDays01: workDays01,
                                        workDays02: workDays02,
                                        workDays03: workDays03,
                                      ),
                                    ),
                                  );
                                } else if (currentWorkDays == '') {
                                  _error = AppLocalizations.of(context)
                                      .translate('selectmaindays');
                                  _showSnackBar();
                                } else if (mainFromTimeString == '' ||
                                    mainToTimeString == '') {
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
                              AppLocalizations.of(context)
                                  .translate('google_map'),
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
                )
              ],
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
        mainFromTimeNo =
            mainFromTimeString.substring(0, mainFromTimeString.indexOf(' '));
        mainFromend = mainFromTimeString.substring(
            mainFromTimeString.indexOf(' ') + 1, mainFromTimeString.length);
        if (mainFromend.contains('ص') || mainFromend == 'AM') {
          ampm = 'AM';
        } else {
          ampm = 'PM';
        }
        mainFromTimeNo = mainFromTimeNo + ' ' + ampm;
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
        mainToTimeNo =
            mainToTimeString.substring(0, mainToTimeString.indexOf(' '));
        mainToend = mainToTimeString.substring(
            mainToTimeString.indexOf(' '), mainToTimeString.length);
        if (mainToend.contains('ص') || mainToend.contains('AM')) {
          toampm = 'AM';
        } else if (mainToend.contains('م') || mainToend.contains('PM')) {
          toampm = 'PM';
        }
        mainToTimeNo = mainToTimeNo + ' ' + toampm;
        mainWorkingHours = 'from ' + mainFromTimeNo + ' to ' + mainToTimeNo;
        makeMePass = true;
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
        } else {
          secondToAmPm = 'PM';
        }
        secondaryToTimeString = secondToNo + ' ' + secondToAmPm;
        secondaryWorkingHours =
            'from ' + secondaryFromTimeString + ' to ' + secondaryToTimeString;

        if (t1.isEmpty) {
          t1.add(secondaryWorkingHours);
        } else {
          t1 = [];
          t1.add(secondaryWorkingHours);
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
        ternaryFromTimeString = thirdFromNo + ' ' + thirdFromAmPm;
        thirdfrom = true;
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
        /*ternaryWorkingHours = AppLocalizations.of(context).translate('from') +
            ternaryFromTimeString +
            ' ' +
            AppLocalizations.of(context).translate('to') +
            ternaryToTimeString;*/
        if (t2.isEmpty) {
          t2.add(ternaryWorkingHours);
        } else {
          t2 = [];
          t2.add(ternaryWorkingHours);
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
