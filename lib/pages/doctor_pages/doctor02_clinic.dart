import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'dart:ui';
import 'doctor03_map.dart';

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

final _formKey = GlobalKey<FormState>();
// const String apiKey = 'ApiKey';
String currentaddress = '';
String currentVacationDays = '';
List currentListVacationDays = [];
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
  List l1 = [];
  List l2 = [];
  _ClinicFormState({
    this.email,
    this.password,
    this.name,
    this.speciality,
    this.phoneNumber,
    this.province,
  });

  @override
  void initState() {
    super.initState();
    _mainFromTime = TimeOfDay.now();
    _secondaryFromTime = TimeOfDay.now();
    _mainToTime = TimeOfDay(hour: 00, minute: 0);
    _secondaryToTime = TimeOfDay(hour: 00, minute: 0);
    _ternaryFromTime = TimeOfDay.now();
    _ternaryToTime = TimeOfDay(hour: 00, minute: 0);
  }

  @override
  Widget build(BuildContext context) {
    final weekDaysList = {
      "1": [AppLocalizations.of(context).translate('sunday'), "Sunday"],
      "2": [AppLocalizations.of(context).translate('monday'), "Monday"],
      "3": [AppLocalizations.of(context).translate('tuesday'), "Tuesday"],
      "4": [AppLocalizations.of(context).translate('wednesday'), "Wednesday"],
      "5": [AppLocalizations.of(context).translate('thursday'), "Thursday"],
      "6": [AppLocalizations.of(context).translate('friday'), "Friday"],
      "7": [AppLocalizations.of(context).translate('saturday'), "Saturday"],
    };
    // final bloc = LocationProvider.of(context);
    final locale = Localizations.localeOf(context);
    final textDirection = getTextDirection(locale);
    return Scaffold(
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
                                workDays[index] = !workDays[index];
                                currentListVacationDays =
                                    boolToStringDays(context, workDays);
                                currentListVacationDays
                                    .removeWhere((value) => value == null);
                                currentVacationDays =
                                    currentListVacationDays.join(', ');
                                print(workDays);
                                print(currentListVacationDays);
                                print(currentVacationDays);
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
                              //AppLocalizations.of(context).translate('monday'),
                              "monday",
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
                        Center(
                          child: Text(
                            AppLocalizations.of(context).translate(
                              'work_hour',
                            ),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                                            color: Colors.deepOrange,
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
                                            color: Colors.deepOrange,
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
                              items: [
                                DropdownMenuItem(
                                  value: weekDaysList["1"][1],
                                  child: Text(weekDaysList["1"][0]),
                                ),
                                DropdownMenuItem(
                                  value: weekDaysList["2"][1],
                                  child: Text(weekDaysList["2"][0]),
                                ),
                                DropdownMenuItem(
                                  value: weekDaysList["3"][1],
                                  child: Text(weekDaysList["3"][0]),
                                ),
                                DropdownMenuItem(
                                  value: weekDaysList["4"][1],
                                  child: Text(weekDaysList["4"][0]),
                                ),
                                DropdownMenuItem(
                                  value: weekDaysList["5"][1],
                                  child: Text(weekDaysList["5"][0]),
                                ),
                                DropdownMenuItem(
                                  value: weekDaysList["6"][1],
                                  child: Text(weekDaysList["6"][0]),
                                ),
                                DropdownMenuItem(
                                  value: weekDaysList["7"][1],
                                  child: Text(weekDaysList["7"][0]),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  weekday01 = value;
                                  if (e1 == []) {
                                    e1.add(weekday01);
                                  } else {
                                    e1 = [];
                                    e1.add(weekday01);
                                  }
                                });
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
                                              color: Colors.deepOrange,
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
                                              color: Colors.deepOrange,
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
                              items: [
                                DropdownMenuItem(
                                  value: weekDaysList["1"][1],
                                  child: Text(weekDaysList["1"][0]),
                                ),
                                DropdownMenuItem(
                                  value: weekDaysList["2"][1],
                                  child: Text(weekDaysList["2"][0]),
                                ),
                                DropdownMenuItem(
                                  value: weekDaysList["3"][1],
                                  child: Text(weekDaysList["3"][0]),
                                ),
                                DropdownMenuItem(
                                  value: weekDaysList["4"][1],
                                  child: Text(weekDaysList["4"][0]),
                                ),
                                DropdownMenuItem(
                                  value: weekDaysList["5"][1],
                                  child: Text(weekDaysList["5"][0]),
                                ),
                                DropdownMenuItem(
                                  value: weekDaysList["6"][1],
                                  child: Text(weekDaysList["6"][0]),
                                ),
                                DropdownMenuItem(
                                  value: weekDaysList["7"][1],
                                  child: Text(weekDaysList["7"][0]),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  weekday02 = value;
                                  if (e2.isEmpty) {
                                    e2.add(weekday02);
                                  } else {
                                    e2 = [];
                                    e2.add(weekday02);
                                  }
                                });
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
                                              color: Colors.deepOrange,
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
                                              color: Colors.deepOrange,
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
                                  if (l1.isEmpty) {
                                    l1.add(e1[0]);
                                    l1.add(t1[0]);
                                  } else {
                                    l1 = [];
                                    l1.add(e1[0]);
                                    l1.add(t1[0]);
                                  }
                                } else if ((e1.isEmpty && t1.isNotEmpty) ||
                                    (e1.isNotEmpty && t1.isEmpty)) {
                                  //snackbar
                                }
                                if (e2.isNotEmpty && t2.isNotEmpty) {
                                  if (l2.isEmpty) {
                                    l2.add(e2[0]);
                                    l2.add(t2[0]);
                                  } else {
                                    l2 = [];
                                    l2.add(e2[0]);
                                    l2.add(t2[0]);
                                  }
                                } else if ((e2.isNotEmpty && t2.isEmpty) ||
                                    (e2.isEmpty && t2.isNotEmpty)) {
                                  //snackbar
                                }
                                print(l1);
                                print(l2);
                                if (currentaddress != '' &&
                                    currentVacationDays != '' &&
                                    mainFromTimeString != '' &&
                                    mainToTimeString != '' &&
                                    makeMePass == true) {
                                  setState(() {
                                    if (mainWorkingHours == '') {
                                      currentListVacationDays
                                          .add(mainWorkingHours);
                                    } else {
                                      currentListVacationDays.remove(
                                          currentListVacationDays[
                                              currentListVacationDays.length -
                                                  1]);
                                      currentListVacationDays
                                          .add(mainWorkingHours);
                                    }
                                    makeMePass = false;
                                    print(currentListVacationDays);
                                  });
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
                                        vacation: currentListVacationDays,
                                        mainWorkingHours: l1,
                                        secondaryWorkingHours: l2,
                                      ),
                                    ),
                                  );
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
        if (mainFromend == 'ص' || mainFromend == 'AM') {
          ampm = 'AM';
        } else {
          ampm = 'PM';
        }
        mainFromTimeNo = mainFromTimeNo + ' ' + ampm;
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
        if (mainToend == 'ًص' || mainToend == 'AM') {
          toampm = 'AM';
        } else {
          toampm = 'PM';
        }
        mainToTimeNo = mainToTimeNo + ' ' + toampm;
        mainWorkingHours = 'from ' + mainFromTimeNo + ' to ' + mainToTimeNo;
        makeMePass = true;
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
        if (secondFromEnd == 'ص' || secondFromEnd == 'AM') {
          secondFromAmPm = 'AM';
        } else {
          secondFromAmPm = 'PM';
        }
        secondaryFromTimeString = secondFromNo + ' ' + secondFromAmPm;
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
        if (secondToEnd == 'ص' || secondToEnd == 'AM') {
          secondToAmPm = 'AM';
        } else {
          secondToAmPm = 'PM';
        }
        secondaryToTimeString = secondToNo + ' ' + secondToAmPm;
        secondaryWorkingHours =
            'from ' + secondaryFromTimeString + ' to ' + secondaryToTimeString;
        /*secondaryWorkingHours = AppLocalizations.of(context).translate('from') +
            secondaryFromTimeString +
            ' ' +
            AppLocalizations.of(context).translate('to') +
            secondaryToTimeString;*/
        if (t1.isEmpty) {
          t1.add(secondaryWorkingHours);
        } else {
          t1 = [];
          t1.add(secondaryWorkingHours);
        }
        print(t1);
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
        if (thirdFromEnd == 'ص' || thirdFromEnd == 'AM') {
          thirdFromAmPm = 'AM';
        } else {
          thirdFromAmPm = 'PM';
        }
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
        thirdFromEnd = ternaryToTimeString.substring(
            ternaryToTimeString.indexOf(' '), ternaryToTimeString.length);
        if (thirdToEnd == 'ص' || thirdToEnd == 'AM') {
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
        print(t2);
        print(ternaryWorkingHours);
      });
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
