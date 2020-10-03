import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/constants/multi_selection.dart';
import 'dart:io';

import '../constants/multi_selection.dart';
import 'pt_risk_f.dart';

class Patient extends StatefulWidget {
  @override
  _PatientState createState() => _PatientState();
}

class _PatientState extends State<Patient> {
  TextStyle _textStylePatient = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  List gender = ['Male', 'Female'];
  String select = '';
  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              select = value;
              print(select);
            });
          },
        ),
        Text(
          title,
          style: _textStylePatient,
        )
      ],
    );
  }

  bool state = false;

//-----------------Function to use DropdownMultiSelection-----------------
  String chronic1 = '';
  String chronic2 = '';
  String chronic3 = '';
  void _showChronicDiseaseMultiSelect(BuildContext context) async {
    chronic1 = '';
    chronic2 = '';
    chronic3 = '';
    final cdItems = <MultiSelectDialogItem<int>>[
      MultiSelectDialogItem(
          1, AppLocalizations.of(context).translate('cd_HTN')),
      MultiSelectDialogItem(2, AppLocalizations.of(context).translate('cd_DM')),
      MultiSelectDialogItem(
          3, AppLocalizations.of(context).translate('cd_heart')),
      MultiSelectDialogItem(
          4, AppLocalizations.of(context).translate('cd_heartFailure')),
      MultiSelectDialogItem(
          5, AppLocalizations.of(context).translate('cd_ctd')),
      MultiSelectDialogItem(
          6, AppLocalizations.of(context).translate('cd_ckd')),
      MultiSelectDialogItem(
          7, AppLocalizations.of(context).translate('cd_liver')),
      MultiSelectDialogItem(
          8, AppLocalizations.of(context).translate('cd_intestine')),
      MultiSelectDialogItem(
          9, AppLocalizations.of(context).translate('cd_epilepsy')),
      MultiSelectDialogItem(
          10, AppLocalizations.of(context).translate('cd_cva')),
      MultiSelectDialogItem(
          11, AppLocalizations.of(context).translate('cd_thyroid')),
      MultiSelectDialogItem(
          12, AppLocalizations.of(context).translate('cd_lung')),
      MultiSelectDialogItem(
          13, AppLocalizations.of(context).translate('cd_copd')),
      MultiSelectDialogItem(
          14, AppLocalizations.of(context).translate('cd_ashma')),
      MultiSelectDialogItem(
          15, AppLocalizations.of(context).translate('cd_tumor')),
    ];

    final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: cdItems,
        );
      },
    );
    var mappy = {1: 'headache', 2: 'abdominal pain'};
    for (var x in selectedValues) {
      if (x == 1) {
        chronic1 = 'headache';
      }
      if (x == 2) {
        chronic2 = 'abdominal pain';
      }
      if (x == 3) {
        chronic3 = 'chest pain';
      }
    }
    //chronics must be cleared after the pt proceed
    print(chronic1);
    print(chronic2);
    print(chronic3);
  }

//-----------------Function to use DropdownMultiSelection-----------------
  void _showLifeStyleMultiSelect(BuildContext context) async {
    final lsItems = <MultiSelectDialogItem<int>>[
      MultiSelectDialogItem(1, 'Obesity'),
      MultiSelectDialogItem(2, 'Smoking'),
      MultiSelectDialogItem(3, 'Drinking'),
    ];

    final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: lsItems,
        );
      },
    );
    print(selectedValues);
  }

  // ----------------Conditional DropDownMenu -------------------------
  String value = "";
  String value2 = '';
  String value3 = '';
  String value4 = '';
  String value5 = '';
  String value6 = '';
  String value7 = '';
  List<DropdownMenuItem<String>> menuitems = List();
  bool disabledropdown1 = true;
  bool disabledropdown2 = true;
  bool disabledropdown3 = true;
  bool disabledropdown4 = true;
  bool disabledropdown5 = true;
  bool disabledropdown6 = true;
  bool disabledropdown7 = true;

  final head = {
    "1": "headache",
    "2": "fever",
    "3": "epilepsy",
  };

  final chest = {
    "1": "chest Pain",
    "2": "cough",
    "3": "fever",
  };

  final abdomen = {
    "1": "vomiting",
    "2": "waterry diarrhea",
    "3": "abdominal Pain",
  };

  final lowerlimb = {
    '1': 'limb pain',
    '2': 'joint pain',
    '3': 'joint swelling'
  };

  void populatehead() {
    for (String key in head.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Center(
          child: Text(head[key]),
        ),
        value: head[key],
      ));
    }
  }

  void populatechest() {
    for (String key in chest.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Center(
          child: Text(chest[key]),
        ),
        value: chest[key],
      ));
    }
  }

  void populateabdomen() {
    for (String key in abdomen.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Center(
          child: Text(abdomen[key]),
        ),
        value: abdomen[key],
      ));
    }
  }

  void populatelowerlimb() {
    for (String key in lowerlimb.keys) {
      menuitems.add(DropdownMenuItem<String>(
        child: Center(
          child: Text(lowerlimb[key]),
        ),
        value: lowerlimb[key],
      ));
    }
  }

  void selected(_value) {
    if (_value == "Head") {
      menuitems = [];
      populatehead();
    } else if (_value == "Chest") {
      menuitems = [];
      populatechest();
    } else if (_value == "Abdomen") {
      menuitems = [];
      populateabdomen();
    } else if (_value == 'lowerlimb') {
      menuitems = [];
      populatelowerlimb();
    }
    setState(() {
      value = _value;

      disabledropdown1 = false;
    });
  }

  void selected2(_value) {
    if (_value == "Head") {
      menuitems = [];
      populatehead();
    } else if (_value == "Chest") {
      menuitems = [];
      populatechest();
    } else if (_value == "Abdomen") {
      menuitems = [];
      populateabdomen();
    } else if (_value == 'lowerlimb') {
      menuitems = [];
      populatelowerlimb();
    }
    setState(() {
      value2 = _value;

      disabledropdown2 = false;
    });
  }

  void selected3(_value) {
    if (_value == "Head") {
      menuitems = [];
      populatehead();
    } else if (_value == "Chest") {
      menuitems = [];
      populatechest();
    } else if (_value == "Abdomen") {
      menuitems = [];
      populateabdomen();
    } else if (_value == 'lowerlimb') {
      menuitems = [];
      populatelowerlimb();
    }
    setState(() {
      value3 = _value;

      disabledropdown3 = false;
    });
  }

  void selected4(_value) {
    if (_value == "Head") {
      menuitems = [];
      populatehead();
    } else if (_value == "Chest") {
      menuitems = [];
      populatechest();
    } else if (_value == "Abdomen") {
      menuitems = [];
      populateabdomen();
    } else if (_value == 'lowerlimb') {
      menuitems = [];
      populatelowerlimb();
    }
    setState(() {
      value4 = _value;

      disabledropdown4 = false;
    });
  }

  void selected5(_value) {
    if (_value == "Head") {
      menuitems = [];
      populatehead();
    } else if (_value == "Chest") {
      menuitems = [];
      populatechest();
    } else if (_value == "Abdomen") {
      menuitems = [];
      populateabdomen();
    } else if (_value == 'lowerlimb') {
      menuitems = [];
      populatelowerlimb();
    }
    setState(() {
      value5 = _value;

      disabledropdown5 = false;
    });
  }

  void selected6(_value) {
    if (_value == "Head") {
      menuitems = [];
      populatehead();
    } else if (_value == "Chest") {
      menuitems = [];
      populatechest();
    } else if (_value == "Abdomen") {
      menuitems = [];
      populateabdomen();
    } else if (_value == 'lowerlimb') {
      menuitems = [];
      populatelowerlimb();
    }
    setState(() {
      value6 = _value;

      disabledropdown6 = false;
    });
  }

  void selected7(_value) {
    if (_value == "Head") {
      menuitems = [];
      populatehead();
    } else if (_value == "Chest") {
      menuitems = [];
      populatechest();
    } else if (_value == "Abdomen") {
      menuitems = [];
      populateabdomen();
    } else if (_value == 'lowerlimb') {
      menuitems = [];
      populatelowerlimb();
    }
    setState(() {
      value7 = _value;

      disabledropdown7 = false;
    });
  }

  void secondselected(_value) {
    setState(() {
      value = _value;
    });
  }

  void secondselected2(_value) {
    setState(() {
      value2 = _value;
    });
  }

  void secondselected3(_value) {
    setState(() {
      value3 = _value;
    });
  }

  void secondselected4(_value) {
    setState(() {
      value4 = _value;
    });
  }

  void secondselected5(_value) {
    setState(() {
      value5 = _value;
    });
  }

  void secondselected6(_value) {
    setState(() {
      value6 = _value;
    });
  }

  void secondselected7(_value) {
    setState(() {
      value7 = _value;
    });
  }

  void val() {
    print(value);
    print(value2);
    print(value3);
    print(value4);
    print(value5);
    print(value6);
    print(value7);
  }

  void _getCurrentLocation() async {
    final Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
  }

  bool _isInternet = true;
  checkInternet() async {
    try {
      final response = await InternetAddress.lookup('example.com');
      if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
        _isInternet = true; // internet
        setState(() {});
      }
    } on SocketException catch (_) {
      _isInternet = false; // no internet
      setState(() {});
    }
  }

  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          AppLocalizations.of(context).translate('patient_appbar'),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: boxDecorationPatient,
                  child: Column(
                    children: [
                      TextField(
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          hintText: AppLocalizations.of(context)
                              .translate('patient_name'),
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          addRadioButton(
                              0,
                              AppLocalizations.of(context)
                                  .translate('patient_male')),
                          addRadioButton(
                              1,
                              AppLocalizations.of(context)
                                  .translate('patient_female')),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: boxDecorationPatient,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate('patient_chronic_diseases'),
                                  style: _textStylePatient),
                            ),
                            FlatButton(
                              onPressed: () =>
                                  _showChronicDiseaseMultiSelect(context),
                              color: Colors.deepOrange,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0)),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('patient_dialogue_list_button'),
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: boxDecorationPatient,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8.0,
                        ),
                        Center(
                          child: Text(
                            'cheif complaint',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          items: [
                            DropdownMenuItem<String>(
                              value: "Head",
                              child: Center(
                                child: Text("Head"),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: "Chest",
                              child: Center(
                                child: Text("Chest"),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: "Abdomen",
                              child: Center(
                                child: Text("Abdomen"),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: 'lowerlimb',
                              child: Center(
                                child: Text('lowerlimb'),
                              ),
                            ),
                          ],
                          onChanged: (_value) => selected(_value),
                          hint: Text(AppLocalizations.of(context)
                              .translate('patient_area_of_choice')),
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          items: menuitems,
                          onChanged: disabledropdown1
                              ? null
                              : (value) => secondselected(value),
                          hint: Text(AppLocalizations.of(context)
                              .translate('patient_complain')),
                          disabledHint: Text(AppLocalizations.of(context)
                              .translate('patient_disablehint')),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Head",
                              style: _textStylePatient,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              "Heahache",
                              style: _textStylePatient,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: boxDecorationPatient,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8.0,
                        ),
                        Center(
                          child: Text(
                            'the 2nd symptom',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          items: [
                            DropdownMenuItem<String>(
                              value: "Head",
                              child: Center(
                                child: Text("Head"),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: "Chest",
                              child: Center(
                                child: Text("Chest"),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: "Abdomen",
                              child: Center(
                                child: Text("Abdomen"),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: 'lowerlimb',
                              child: Center(
                                child: Text('lowerlimb'),
                              ),
                            ),
                          ],
                          onChanged: (_value) => selected2(_value),
                          hint: Text(AppLocalizations.of(context)
                              .translate('patient_area_of_choice')),
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          items: menuitems,
                          onChanged: disabledropdown2
                              ? null
                              : (value) => secondselected2(value),
                          hint: Text(AppLocalizations.of(context)
                              .translate('patient_complain')),
                          disabledHint: Text(AppLocalizations.of(context)
                              .translate('patient_disablehint')),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Head",
                              style: _textStylePatient,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              "Heahache",
                              style: _textStylePatient,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(children: [
                          Text(
                            AppLocalizations.of(context)
                                .translate('patient_other_complain'),
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          Switch(
                              activeColor: Colors.deepOrange,
                              value: state,
                              onChanged: (bool s) {
                                setState(() {
                                  state = s;
                                });
                              }),
                        ]),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: boxDecorationPatient,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8.0,
                        ),
                        Center(
                          child: Text(
                            'the 3rd symptom',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          items: [
                            DropdownMenuItem<String>(
                              value: "Head",
                              child: Center(
                                child: Text("Head"),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: "Chest",
                              child: Center(
                                child: Text("Chest"),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: "Abdomen",
                              child: Center(
                                child: Text("Abdomen"),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: 'lowerlimb',
                              child: Center(
                                child: Text('lowerlimb'),
                              ),
                            ),
                          ],
                          onChanged: (_value) => selected3(_value),
                          hint: Text(AppLocalizations.of(context)
                              .translate('patient_area_of_choice')),
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          items: menuitems,
                          onChanged: disabledropdown3
                              ? null
                              : (value) => secondselected3(value),
                          hint: Text(AppLocalizations.of(context)
                              .translate('patient_complain')),
                          disabledHint: Text(AppLocalizations.of(context)
                              .translate('patient_disablehint')),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Head",
                              style: _textStylePatient,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              "Heahache",
                              style: _textStylePatient,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: boxDecorationPatient,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8.0,
                        ),
                        Center(
                          child: Text(
                            'the 4th symptom',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          items: [
                            DropdownMenuItem<String>(
                              value: "Head",
                              child: Center(
                                child: Text("Head"),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: "Chest",
                              child: Center(
                                child: Text("Chest"),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: "Abdomen",
                              child: Center(
                                child: Text("Abdomen"),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: 'lowerlimb',
                              child: Center(
                                child: Text('lowerlimb'),
                              ),
                            ),
                          ],
                          onChanged: (_value) => selected4(_value),
                          hint: Text(AppLocalizations.of(context)
                              .translate('patient_area_of_choice')),
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          items: menuitems,
                          onChanged: disabledropdown4
                              ? null
                              : (value) => secondselected4(value),
                          hint: Text(AppLocalizations.of(context)
                              .translate('patient_complain')),
                          disabledHint: Text(AppLocalizations.of(context)
                              .translate('patient_disablehint')),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Head",
                              style: _textStylePatient,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              "Heahache",
                              style: _textStylePatient,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: boxDecorationPatient,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8.0,
                        ),
                        Center(
                          child: Text(
                            'the 5th symptom',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          items: [
                            DropdownMenuItem<String>(
                              value: "Head",
                              child: Center(
                                child: Text("Head"),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: "Chest",
                              child: Center(
                                child: Text("Chest"),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: "Abdomen",
                              child: Center(
                                child: Text("Abdomen"),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: 'lowerlimb',
                              child: Center(
                                child: Text('lowerlimb'),
                              ),
                            ),
                          ],
                          onChanged: (_value) => selected5(_value),
                          hint: Text(AppLocalizations.of(context)
                              .translate('patient_area_of_choice')),
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          items: menuitems,
                          onChanged: disabledropdown5
                              ? null
                              : (value) => secondselected5(value),
                          hint: Text(AppLocalizations.of(context)
                              .translate('patient_complain')),
                          disabledHint: Text(AppLocalizations.of(context)
                              .translate('patient_disablehint')),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Head",
                              style: _textStylePatient,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              "Heahache",
                              style: _textStylePatient,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: boxDecorationPatient,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8.0,
                        ),
                        Center(
                          child: Text(
                            'the 6th symptom',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          items: [
                            DropdownMenuItem<String>(
                              value: "Head",
                              child: Center(
                                child: Text("Head"),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: "Chest",
                              child: Center(
                                child: Text("Chest"),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: "Abdomen",
                              child: Center(
                                child: Text("Abdomen"),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: 'lowerlimb',
                              child: Center(
                                child: Text('lowerlimb'),
                              ),
                            ),
                          ],
                          onChanged: (_value) => selected6(_value),
                          hint: Text(AppLocalizations.of(context)
                              .translate('patient_area_of_choice')),
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          items: menuitems,
                          onChanged: disabledropdown6
                              ? null
                              : (value) => secondselected6(value),
                          hint: Text(AppLocalizations.of(context)
                              .translate('patient_complain')),
                          disabledHint: Text(AppLocalizations.of(context)
                              .translate('patient_disablehint')),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Head",
                              style: _textStylePatient,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              "Heahache",
                              style: _textStylePatient,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: boxDecorationPatient,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8.0,
                        ),
                        Center(
                          child: Text(
                            'the 7th symptom',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          items: [
                            DropdownMenuItem<String>(
                              value: "Head",
                              child: Center(
                                child: Text("Head"),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: "Chest",
                              child: Center(
                                child: Text("Chest"),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: "Abdomen",
                              child: Center(
                                child: Text("Abdomen"),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: 'lowerlimb',
                              child: Center(
                                child: Text('lowerlimb'),
                              ),
                            ),
                          ],
                          onChanged: (_value) => selected7(_value),
                          hint: Text(AppLocalizations.of(context)
                              .translate('patient_area_of_choice')),
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          items: menuitems,
                          onChanged: disabledropdown7
                              ? null
                              : (value) => secondselected7(value),
                          hint: Text(AppLocalizations.of(context)
                              .translate('patient_complain')),
                          disabledHint: Text(AppLocalizations.of(context)
                              .translate('patient_disablehint')),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Head",
                              style: _textStylePatient,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              "Heahache",
                              style: _textStylePatient,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 75),
                RaisedButton(
                  onPressed: () {
                    val();
                  },
                ),
                Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ButtonTheme(
                        minWidth: double.infinity,
                        height: 45,
                        child: RaisedButton(
                          color: Colors.deepOrange,
                          onPressed: () {
                            _getCurrentLocation();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PatientRisks(
                                      chiehcomplaint: value,
                                      sym2: value2,
                                      sym3: value3,
                                      sym4: value4,
                                      sym5: value5,
                                      sym6: value6,
                                      sym7: value7,
                                    )));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('patient_search_button'),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
