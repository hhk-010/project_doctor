import 'package:flutter/material.dart';
import 'package:project_doctor/pages/doctor_map.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/auth.dart';

class DoctorForm extends StatefulWidget {
  final String email;
  final String password;
  DoctorForm({this.email, this.password});
  @override
  _DoctorFormState createState() =>
      _DoctorFormState(email: email, password: password);
}

final _formKey = GlobalKey<FormState>();
final List<String> specialities = [
  'Cardiologist',
  'Pulmonologist',
  'Endocrinologist',
  'Enterologist',
  'General Surgeon',
  'Thoracic Surgeon',
  'Emergency Department',
  'Internist',
  'Gynecologist',
  'Rheumatologist',
  'Nephrologist',
  'Heamatologist',
  'Neurologist',
  'Urosurgeon',
  'Orthopaedic Surgeon',
  'Neurosurgeon',
  'Plastic Surgeon'
];
String currentName;
String currentSpeciality;
String currentPhoneNumber;
String currentProvince;

final AuthService _auth = AuthService();
void choiceAction(String choice) async {
  if (choice == PopUpMenuConstants.logOut) {
    await _auth.signOut();
  } else {
    print('settings');
  }
}

//Iraq Mobile Number Validator
String validateMobile(String value) {
  if (value.length != 11)
    return 'Mobile Number must be of 11 digit';
  else
    return null;
}

class _DoctorFormState extends State<DoctorForm> {
  String email;
  String password;
  _DoctorFormState({this.email, this.password});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          AppLocalizations.of(context).translate('doctor_form_appbar'),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              onSelected: choiceAction,
              itemBuilder: (BuildContext context) {
                return PopUpMenuConstants.choices.map((String choice) {
                  return PopupMenuItem(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              }),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 60, horizontal: 40),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  TextFormField(
                    decoration: textInputdecoration.copyWith(
                      hintText: AppLocalizations.of(context)
                          .translate('doctor_form_name'),
                      labelText: AppLocalizations.of(context)
                          .translate('doctor_form_name'),
                    ),
                    validator: (value) => value == null ? 'AAAAAA' : null,
                    onChanged: (val) => setState(() => currentName = val),
                  ),
                  SizedBox(height: 25.0),
                  DropdownButtonFormField<String>(
                    value: currentSpeciality,
                    decoration: textInputdecoration,
                    hint: Text(
                      AppLocalizations.of(context)
                          .translate('doctor_form_speciality'),
                    ),
                    dropdownColor: Colors.grey[200],
                    elevation: 5,
                    icon: Icon(Icons.arrow_drop_down),
                    isExpanded: true,
                    items: specialities.map((speciality) {
                      return DropdownMenuItem(
                        value: speciality,
                        child: Text('$speciality'),
                      );
                    }).toList(),
                    validator: (value) => value == null
                        ? AppLocalizations.of(context)
                            .translate('doctor_form_speciality')
                        : null,
                    onChanged: (val) => setState(() => currentSpeciality = val),
                  ),
                  SizedBox(height: 25.0),
                  TextFormField(
                      onChanged: (val) =>
                          setState(() => currentPhoneNumber = val),
                      keyboardType: TextInputType.phone,
                      decoration: textInputdecoration.copyWith(
                        hintText: AppLocalizations.of(context)
                            .translate('doctor_form_phoneNumber'),
                        labelText: AppLocalizations.of(context)
                            .translate('doctor_form_phoneNumber'),
                      ),
                      validator: validateMobile),
                  SizedBox(height: 25.0),
                  TextFormField(
                    onChanged: (val) => setState(() => currentProvince = val),
                    decoration: textInputdecoration.copyWith(
                      hintText: AppLocalizations.of(context)
                          .translate('doctor_form_province'),
                      labelText: AppLocalizations.of(context)
                          .translate('doctor_form_province'),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    children: [
                      Text(
                        'Set up Your Clinic Location',
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
                          await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DocMap(
                                    email: email,
                                    password: password,
                                    name: currentName,
                                    speciality: currentSpeciality,
                                    phone: currentPhoneNumber,
                                    province: currentProvince,
                                  )));
                        }
                      },
                      label: Text(
                        'Google Map',
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
        ),
      ),
    );
  }
}
