import 'package:flutter/material.dart';
import 'package:project_doctor/pages/doctor_pages/doctor02_clinic.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/constants/theme.dart';

class DoctorForm extends StatefulWidget {
  final String email;
  final String password;
  DoctorForm({this.email, this.password});
  @override
  _DoctorFormState createState() =>
      _DoctorFormState(email: email, password: password);
}

final _formKey = GlobalKey<FormState>();

String currentName;
String currentSpeciality;
String currentPhoneNumber;
String currentProvince;

class _DoctorFormState extends State<DoctorForm> {
  String email;
  String password;
  _DoctorFormState({this.email, this.password});
  @override
  Widget build(BuildContext context) {
    final List<String> specialities = [
      AppLocalizations.of(context).translate('Internist'),
      AppLocalizations.of(context).translate('Pediatrician'),
      AppLocalizations.of(context).translate('Cardiologist'),
      AppLocalizations.of(context).translate('Pulmonologist'),
      AppLocalizations.of(context).translate('Enterologist'),
      AppLocalizations.of(context).translate('Neurologist'),
      AppLocalizations.of(context).translate('Heamatologist'),
      AppLocalizations.of(context).translate('Nephrologist'),
      AppLocalizations.of(context).translate('Rheumatologist'),
      AppLocalizations.of(context).translate('Emergency physician'),
      AppLocalizations.of(context).translate('Dermatologist'),
      AppLocalizations.of(context).translate('Psychiatrist'),
      AppLocalizations.of(context).translate('Gynecologist'),
      AppLocalizations.of(context).translate('General Surgeon'),
      AppLocalizations.of(context).translate('Pediatric Surgeon'),
      AppLocalizations.of(context).translate('ThoracoVascular Surgeon'),
      AppLocalizations.of(context).translate('Orthopaedic Surgeon'),
      AppLocalizations.of(context).translate('Urosurgeon'),
      AppLocalizations.of(context).translate('Plastic Surgeon'),
      AppLocalizations.of(context).translate('Ophthalmologist'),
      AppLocalizations.of(context).translate('Laryngologist'),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          AppLocalizations.of(context).translate('doctor_form'),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 75, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Container(
            height: double.maxFinite,
            child: Column(
              children: [
                TextFormField(
                  decoration: textInputdecoration.copyWith(
                    hintText: AppLocalizations.of(context).translate('name'),
                    labelText: AppLocalizations.of(context).translate('name'),
                  ),
                  validator: (val) => val.isEmpty
                      ? AppLocalizations.of(context).translate('name_validator')
                      : null,
                  onChanged: (val) => setState(() => currentName = val),
                ),
                Spacer(),
                DropdownButtonFormField<String>(
                  value: currentSpeciality,
                  decoration: textInputdecoration,
                  hint: Text(
                    AppLocalizations.of(context).translate('speciality'),
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
                          .translate('speciality_validator')
                      : null,
                  onChanged: (val) => setState(() => currentSpeciality = val),
                ),
                Spacer(),
                TextFormField(
                  onChanged: (val) => setState(() => currentPhoneNumber = val),
                  keyboardType: TextInputType.phone,
                  decoration: textInputdecoration.copyWith(
                    hintText:
                        AppLocalizations.of(context).translate('phoneNumber'),
                    labelText:
                        AppLocalizations.of(context).translate('phoneNumber'),
                  ),
                  validator: (val) => val.length < 11
                      ? AppLocalizations.of(context)
                          .translate('phoneNumber_validator')
                      : null,
                ),
                Spacer(),
                TextFormField(
                  validator: (val) =>
                      val.isEmpty ? 'Enter your province' : null,
                  onChanged: (val) => setState(() => currentProvince = val),
                  decoration: textInputdecoration.copyWith(
                    hintText:
                        AppLocalizations.of(context).translate('province'),
                    labelText:
                        AppLocalizations.of(context).translate('province'),
                  ),
                ),
                Spacer(
                  flex: 5,
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
                        if (currentName != null &&
                            currentSpeciality != null &&
                            currentPhoneNumber != null &&
                            currentProvince != null) {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ClinicForm(
                                email: email,
                                password: password,
                                name: currentName,
                                speciality: currentSpeciality,
                                phoneNumber: currentPhoneNumber,
                                province: currentProvince,
                              ),
                            ),
                          );
                        }
                      }
                    },
                    label: Text(
                      AppLocalizations.of(context).translate('next'),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
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
}
