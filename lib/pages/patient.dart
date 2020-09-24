import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/theme_const.dart';
import 'package:project_doctor/services/dropdown_multi_selection.dart';

class Patient extends StatefulWidget {
  @override
  _PatientState createState() => _PatientState();
}

class _PatientState extends State<Patient> {
// ------------------the Logic for the Radio Buttons-----------------
  TextStyle _textStylePatient = TextStyle(
    fontSize: 18,
    color: Colors.black,
  );

  List gender = ['Male', 'Female'];
  String select;
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
            });
          },
        ),
        Text(
          title,
          style: TextStyle(fontSize: 18),
        )
      ],
    );
  }

  bool state = false;
  // ------------------------------END-----------------------------

//-----------------Function to use DropdownMultiSelection-----------------
  void _showMultiSelect(BuildContext context) async {
    final items = <MultiSelectDialogItem<int>>[
      MultiSelectDialogItem(
          1, AppLocalizations.of(context).translate('cd_hyt')),
      MultiSelectDialogItem(2, AppLocalizations.of(context).translate('cd_DM')),
      MultiSelectDialogItem(
          3, AppLocalizations.of(context).translate('cd_heart')),
    ];

    final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
        );
      },
    );
    print(selectedValues);
  }

//----------------------------------END-------------------------------

  // ----------------Conditional DropDownMenu ---------------------
  String value = "";
  List<DropdownMenuItem<String>> menuitems = List();
  bool disabledropdown = true;

  final head = {
    "1": "Headache",
    "2": "Fever",
    "3": "Epilepsy",
  };

  final chest = {
    "1": "Chest Pain",
    "2": "Cough",
    "3": "Fever",
  };

  final abdomen = {
    "1": "Vomiting",
    "2": "Diarrhea",
    "3": "Abdominal Pain",
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
    }
    setState(() {
      value = _value;

      disabledropdown = false;
    });
  }

  void secondselected(_value) {
    setState(() {
      value = _value;
    });
  }
//------------------------------END------------------------------

// ------------------function to get the user location------------------
  void _getCurrentLocation() async {
    final Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
  }
//-------------------------------END--------------------------------------

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
                      )
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
                            Text(
                                AppLocalizations.of(context)
                                    .translate('patient_chronic_diseases'),
                                style: _textStylePatient),
                            SizedBox(
                              width: 50,
                            ),
                            FlatButton(
                              onPressed: () => _showMultiSelect(context),
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
                        Row(
                          children: [],
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
                          ],
                          onChanged: (_value) => selected(_value),
                          hint: Text(AppLocalizations.of(context)
                              .translate('patient_area_of_choice')),
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          items: menuitems,
                          onChanged: disabledropdown
                              ? null
                              : (_value) => secondselected(_value),
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
                SizedBox(height: 75),
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

                            Navigator.pushNamed(context, '/result');
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
