import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/pages/doctor_pages/doctor06_update_map.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:weekday_selector/weekday_selector.dart';

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

List<bool> workDays = List.filled(7, false);
List boolToStringDays(BuildContext context, List workDays) {
  return [
    workDays[0]
        ? 'sunday'
        : null, //AppLocalizations.of(context).translate('sunday') : null,
    workDays[1]
        ? 'monday'
        : null, //AppLocalizations.of(context).translate('monday') : null,
    workDays[2]
        ? 'tuesday'
        : null, //AppLocalizations.of(context).translate('tuesday') : null,
    workDays[3]
        ? 'wednesday'
        : null, //AppLocalizations.of(context).translate('wednesday') : null,
    workDays[4]
        ? 'thursday'
        : null, //AppLocalizations.of(context).translate('thursday') : null,
    workDays[5]
        ? 'friday'
        : null, //AppLocalizations.of(context).translate('friday') : null,
    workDays[6]
        ? 'saturday'
        : null, //AppLocalizations.of(context).translate('saturday') : null,
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
  String mainFromNo = '';
  String mainToNo = '';
  String fromAmPm = '';
  String toAmPm = '';
  String fromEnd = '';
  String toEnd = '';
  bool makeMePass = false;

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

  final _formkey = GlobalKey<FormState>();
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
                    decoration: boxDecorationDoctor,
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
                                  workDays[index] = !workDays[index];
                                  currentListVacationDays =
                                      boolToStringDays(context, workDays);
                                  currentListVacationDays
                                      .removeWhere((value) => value == null);
                                  currentVacationDays =
                                      currentListVacationDays.join(', ');
                                  print(currentListVacationDays);
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
                                          fontSize: 18,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                '${_mainFromTime.format(context)}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
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
                                          fontSize: 18,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                '${_mainToTime.format(context)}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
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
                      decoration: boxDecorationDoctor,
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
                                    child: Text(weekDaysList["5"][0]),
                                  ),
                                  DropdownMenuItem(
                                    value: weekDaysList["7"][1],
                                    child: Text(weekDaysList["5"][0]),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    weekday01 = value;
                                  });
                                  print(weekday01);
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
                                            fontSize: 18,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  '${_secondaryFromTime.format(context)}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
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
                                            fontSize: 18,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  '${_secondaryToTime.format(context)}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
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
                      decoration: boxDecorationDoctor,
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
                                    child: Text(weekDaysList["5"][0]),
                                  ),
                                  DropdownMenuItem(
                                    value: weekDaysList["7"][1],
                                    child: Text(weekDaysList["5"][0]),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    weekday02 = value;
                                  });
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
                                            fontSize: 18,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  '${_ternaryFromTime.format(context)}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
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
                                            fontSize: 18,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  '${_ternaryToTime.format(context)}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
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
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                          if (address != '' &&
                              currentVacationDays != '' &&
                              mainFromTimeString != '' &&
                              mainToTimeString != '' &&
                              makeMePass == true) {
                            setState(() {
                              if (mainWorkingHours == '') {
                                currentListVacationDays.add(mainWorkingHours);
                              } else {
                                currentListVacationDays.remove(
                                    currentListVacationDays[
                                        currentListVacationDays.length - 1]);
                                currentListVacationDays.add(mainWorkingHours);
                              }
                              makeMePass = false;
                            });
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UpdateMap(
                                  name: name,
                                  speciality: speciality,
                                  number: phoneNumber,
                                  province: province,
                                  address: address,
                                  vacation: currentListVacationDays,
                                  workinghours: mainWorkingHours,
                                ),
                              ),
                            );
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
        if (fromEnd == 'ص' || fromEnd == 'AM') {
          fromAmPm = 'AM';
        } else {
          fromAmPm = 'PM';
        }
        mainFromTimeString = mainFromNo + ' ' + fromAmPm;
        print(mainFromTimeString);
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
        mainToNo = mainToTimeString.substring(0, mainToTimeString.indexOf(' '));
        toEnd = mainToTimeString.substring(
            mainToTimeString.indexOf(' '), mainToTimeString.length);
        if (toEnd == 'ًص' || toEnd == 'AM') {
          toAmPm = "AM";
        } else {
          toAmPm = 'PM';
        }
        mainToTimeString = mainToNo + ' ' + toAmPm;
        mainWorkingHours =
            'from ' + mainFromTimeString + ' to ' + mainToTimeString;
        makeMePass = true;
        /*mainWorkingHours = AppLocalizations.of(context).translate('from') +
            mainFromTimeString +
            ' ' +
            AppLocalizations.of(context).translate('to') +
            mainToTimeString;*/
        print(mainToTimeString);
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
        print(secondaryFromTimeString);
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
        secondaryWorkingHours = AppLocalizations.of(context).translate('from') +
            secondaryFromTimeString +
            ' ' +
            AppLocalizations.of(context).translate('to') +
            secondaryToTimeString;
        print(secondaryToTimeString);
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
        print(ternaryFromTimeString);
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
        ternaryWorkingHours = AppLocalizations.of(context).translate('from') +
            ternaryFromTimeString +
            ' ' +
            AppLocalizations.of(context).translate('to') +
            ternaryToTimeString;
        print(ternaryToTimeString);
        print(ternaryWorkingHours);
      });
  }
}
