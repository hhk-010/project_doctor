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
    workDays[0] ? AppLocalizations.of(context).translate('sunday') : null,
    workDays[1] ? AppLocalizations.of(context).translate('monday') : null,
    workDays[2] ? AppLocalizations.of(context).translate('tuesday') : null,
    workDays[3] ? AppLocalizations.of(context).translate('wednesday') : null,
    workDays[4] ? AppLocalizations.of(context).translate('thursday') : null,
    workDays[5] ? AppLocalizations.of(context).translate('friday') : null,
    workDays[6] ? AppLocalizations.of(context).translate('saturday') : null,
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
  TimeOfDay _fromTime;
  TimeOfDay _toTime;
  _UpdateInfo2State(
      {this.name, this.speciality, this.phoneNumber, this.province});

  String address = '';
  String currentVacationDays = '';
  List currentListVacationDays = [];
  String currentWorkinghours = '';
  String firstTime = '';
  String secondTime = '';

  @override
  void initState() {
    super.initState();
    _fromTime = TimeOfDay.now();
    _toTime = TimeOfDay(hour: 00, minute: 0);
  }

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
      body: Container(
        height: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 75.0, horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Spacer(
                flex: 2,
              ),
              Container(
                decoration: boxDecorationDoctor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).translate(
                          'detailed_address',
                        ),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          validator: (val) => val.isEmpty
                              ? AppLocalizations.of(context)
                                  .translate('address_validator')
                              : null,
                          onChanged: (val) => setState(() => address = val),
                          decoration: textInputdecoration.copyWith(
                            hintText: 'مثال: شارع المغرب مجاور صيدليه الشفاء',
                            hintStyle: TextStyle(
                                fontSize: 12.0,
                                color: Colors.deepOrange,
                                fontFamily: 'noto_arabic'),
                            labelText: 'عنوان العياده',
                            labelStyle: TextStyle(
                                color: Colors.indigo,
                                fontFamily: 'noto_arabic'),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(
                                    color: Colors.orangeAccent, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(
                                    color: Colors.orangeAccent, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.orangeAccent)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(
                                    color: Colors.orangeAccent, width: 2)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Container(
                decoration: boxDecorationDoctor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).translate(
                          'work_days',
                        ),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      WeekdaySelector(
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
                            // print(workDays);
                            // print(currentVacationDays);
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
                          AppLocalizations.of(context).translate('wednesday'),
                          AppLocalizations.of(context).translate('thursday'),
                          AppLocalizations.of(context).translate('friday'),
                          AppLocalizations.of(context).translate('saturday'),
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
                    ],
                  ),
                ),
              ),
              Spacer(),
              Container(
                decoration: boxDecorationDoctor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).translate(
                          'work_hour',
                        ),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
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
                                      text: '${_fromTime.format(context)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.deepOrange,
                                      ),
                                    ),
                                  ]),
                            ),
                            onTap: _pickFromTime,
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
                                      text: '${_toTime.format(context)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.deepOrange,
                                      ),
                                    ),
                                  ]),
                            ),
                            onTap: _pickToTime,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(
                flex: 3,
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context).translate('location_setup'),
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
                  onPressed: () {
                    if (_formkey.currentState.validate()) {
                      if (address != '' &&
                          currentVacationDays != '' &&
                          currentWorkinghours != '') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UpdateMap(
                              name: name,
                              speciality: speciality,
                              number: phoneNumber,
                              province: province,
                              address: address,
                              vacation: currentVacationDays,
                              workinghours: currentWorkinghours,
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
    );
  }

  _pickFromTime() async {
    TimeOfDay fromTime = await showTimePicker(
        context: context,
        initialTime: _fromTime,
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
    if (fromTime != null)
      setState(() {
        _fromTime = fromTime;
        firstTime = _fromTime.format(context);
        print(firstTime);
      });
  }

  _pickToTime() async {
    TimeOfDay toTime = await showTimePicker(
        context: context,
        initialTime: _toTime,
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
    if (toTime != null)
      setState(() {
        _toTime = toTime;
        secondTime = _toTime.format(context);
        currentWorkinghours = AppLocalizations.of(context).translate('from') +
            firstTime +
            ' ' +
            AppLocalizations.of(context).translate('to') +
            secondTime;
        print(secondTime);
        print(currentWorkinghours);
      });
  }
}
