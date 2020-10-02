import 'package:flutter/material.dart';
import 'package:project_doctor/pages/doctor_map.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/theme_const.dart';
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
final List<String> specialities = ['Cardio', 'Neuro', 'GIT'];
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
        elevation: 1,
        actions: [
          PopupMenuButton<String>(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    cursorColor: Colors.deepOrange,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)
                          .translate('doctor_form_name'),
                      labelText: AppLocalizations.of(context)
                          .translate('doctor_form_name'),
                    ),
                    validator: (value) => value == null ? 'AAAAAA' : null,
                    onChanged: (val) => setState(() => currentName = val),
                  ),
                  SizedBox(height: 15.0),
                  DropdownButtonFormField<String>(
                    value: currentSpeciality,
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
                  SizedBox(height: 15.0),
                  TextFormField(
                      onChanged: (val) =>
                          setState(() => currentPhoneNumber = val),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)
                            .translate('doctor_form_phoneNumber'),
                      ),
                      validator: validateMobile),
                  SizedBox(height: 15.0),
                  TextFormField(
                    onChanged: (val) => setState(() => currentProvince = val),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)
                          .translate('doctor_form_province'),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  /*Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)
                                    .translate('doctor_form_location'),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 18,
                                ),
                              ),
                              /* ButtonTheme(
                                height: 30,
                                child: RaisedButton(
                                  onPressed: () => currentLocation = 'Baghdad',
                                  color: Colors.deepOrange,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(80.0)),
                                  child: Text(
                                    'Google Map',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),*/
                            ],*/
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    'Specify Your Clinic Location Via Google Map',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(
                    height: 15,
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0)),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                await Navigator.of(context)
                                    .push(MaterialPageRoute(
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
                            child: Text(
                              'go to google map',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
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
      ),
    );
  }
}
