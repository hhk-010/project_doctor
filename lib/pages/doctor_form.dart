import 'package:flutter/material.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/theme_const.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/authorization/loading.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/database.dart';
import 'package:provider/provider.dart';

class DoctorForm extends StatefulWidget {
  @override
  _DoctorFormState createState() => _DoctorFormState();
}

final _formKey = GlobalKey<FormState>();
final List<String> specialities = ['Cardio', 'Neuro', 'GIT'];
String _currentName;
String _currentSpeciality;
String _currentPhoneNumber;
String _currentProvince;
String _currentLocation;

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
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    return StreamBuilder<UpdateUserDataModel>(
        stream: DatabaseService(uid: user.uid).doctorDataFormStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UpdateUserDataModel userData = snapshot.data;
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
                            initialValue: userData.name,
                            cursorColor: Colors.deepOrange,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)
                                  .translate('doctor_form_name'),
                              labelText: AppLocalizations.of(context)
                                  .translate('doctor_form_name'),
                            ),
                            validator: (value) =>
                                value == null ? 'AAAAAA' : null,
                            onChanged: (val) =>
                                setState(() => _currentName = val),
                          ),
                          SizedBox(height: 15.0),
                          DropdownButtonFormField<String>(
                            value: _currentSpeciality,
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
                            onChanged: (val) =>
                                setState(() => _currentSpeciality = val),
                          ),
                          SizedBox(height: 15.0),
                          TextFormField(
                              initialValue: userData.phoneNumber,
                              onChanged: (val) =>
                                  setState(() => _currentPhoneNumber = val),
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)
                                    .translate('doctor_form_phoneNumber'),
                              ),
                              validator: validateMobile),
                          SizedBox(height: 15.0),
                          TextFormField(
                            initialValue: userData.province,
                            onChanged: (val) =>
                                setState(() => _currentProvince = val),
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)
                                  .translate('doctor_form_province'),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Row(
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
                              ButtonTheme(
                                height: 30,
                                child: RaisedButton(
                                  onPressed: () => _currentLocation = 'Baghdad',
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
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 60,
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
                                        borderRadius:
                                            BorderRadius.circular(80.0)),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        await DatabaseService(uid: user.uid)
                                            .updateUserData(
                                          _currentName ?? userData.name,
                                          _currentSpeciality ??
                                              userData.speciality,
                                          _currentPhoneNumber ??
                                              userData.phoneNumber,
                                          _currentProvince ?? userData.province,
                                          _currentLocation ?? userData.location,
                                        );
                                        Navigator.pushNamed(
                                            context, '/doctor_profile');
                                      }
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('doctor_form_search'),
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
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
