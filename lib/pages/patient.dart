import 'package:flutter/material.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/pages/patient_risks.dart';

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

  final ageController = TextEditingController();

  // -------------------------Radio Buttons-------------------------
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

  // ----------------Conditional DropDownMenu -------------------------
  String value = '';
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
    "4": "fit",
    "5": "coma",
    "6": "syncope",
    "7": "back pain"
  };

  final chest = {
    "1": "chest pain",
    "2": "cough",
    "3": "fever",
    "4":"dyspnea",
    "5":"heamoptysis",
    "6" : "wheeze"
  };

  final abdomen = {
    "1": "vomiting",
    "2": "watery diarrhea",
    "3": "abdominal Pain",
    "4": "amenorrhea",
    "5": "heamaturia"
  };

  final lowerlimb = {
    '1': 'limb pain',
    '2': 'joint pain',
    '3': 'joint swelling'
  };

  final upperlimb = {};

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
                          keyboardType: TextInputType.number,
                          controller: ageController,
                          autocorrect: true,
                          decoration: InputDecoration(
                            hintText: 'Enter Your Age in Years...',
                            prefixIcon: Icon(Icons.person_outline),
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                          )),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8.0,
                        ),
                        Center(
                          child: Container(
                            child: Text(
                              'Chief Complaint',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 2,
                          indent: 30,
                          endIndent: 30,
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
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 75),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonTheme(
                    minWidth: double.infinity,
                    height: 45,
                    child: RaisedButton(
                      color: Colors.deepOrange,
                      onPressed: () {
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
                        AppLocalizations.of(context).translate('next'),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
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
