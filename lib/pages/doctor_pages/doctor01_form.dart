import 'dart:ui';
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

String currentName = '';
String currentSpeciality;
String currentPhoneNumber = '';
String currentProvince;

class _DoctorFormState extends State<DoctorForm> {
  String email;
  String password;
  _DoctorFormState({this.email, this.password});

  @override
  Widget build(BuildContext context) {
    final Map specialities = {
      "1": [AppLocalizations.of(context).translate('Internist'), 'Internist'],
      "2": [
        AppLocalizations.of(context).translate('Pediatrician'),
        'Pediatrician'
      ],
      "3": [
        AppLocalizations.of(context).translate('Cardiologist'),
        'Cardiologist'
      ],
      "4": [
        AppLocalizations.of(context).translate('Pulmonologist'),
        'Pulmonologist'
      ],
      "5": [
        AppLocalizations.of(context).translate('Endocrinologist'),
        'Endocrinologist'
      ],
      "6": [
        AppLocalizations.of(context).translate('Enterologist'),
        'Enterologist'
      ],
      "7": [
        AppLocalizations.of(context).translate('Neurologist'),
        'Neurologist'
      ],
      "8": [
        AppLocalizations.of(context).translate('Neurosurgeon'),
        'Neurosurgeon'
      ],
      "9": [
        AppLocalizations.of(context).translate('Heamatologist'),
        'Heamatologist'
      ],
      "10": [
        AppLocalizations.of(context).translate('Nephrologist'),
        'Nephrologist'
      ],
      "11": [
        AppLocalizations.of(context).translate('Rheumatologist'),
        'Rheumatologist'
      ],
      "12": [
        AppLocalizations.of(context).translate('Emergency physician'),
        'Emergency physician'
      ],
      "13": [
        AppLocalizations.of(context).translate('Dermatologist'),
        'Dermatologist'
      ],
      "14": [
        AppLocalizations.of(context).translate('Psychiatrist'),
        'Psychiatrist'
      ],
      "15": [
        AppLocalizations.of(context).translate('Gynecologist'),
        'Gynecologist'
      ],
      "16": [
        AppLocalizations.of(context).translate('General Surgeon'),
        'General Surgeon'
      ],
      "17": [
        AppLocalizations.of(context).translate('Pediatric Surgeon'),
        'Pediatric Surgeon'
      ],
      "18": [
        AppLocalizations.of(context).translate('ThoracoVascular Surgeon'),
        'ThoracoVascular Surgeon'
      ],
      "19": [
        AppLocalizations.of(context).translate('Orthopaedic Surgeon'),
        'Orthopaedic Surgeon'
      ],
      "20": [
        AppLocalizations.of(context).translate('Urosurgeon'),
        'Urosurgeon'
      ],
      "21": [
        AppLocalizations.of(context).translate('Plastic Surgeon'),
        'Plastic Surgeon'
      ],
      "22": [
        AppLocalizations.of(context).translate('Ophthalmologist'),
        'Ophthalmologist'
      ],
      "23": [
        AppLocalizations.of(context).translate('Laryngologist'),
        'Laryngologist'
      ],
    };
    final province = {
      "1": [
        'Baghdad',
        AppLocalizations.of(context).translate('Baghdad'),
      ],
      "2": [
        'Northern Region',
        AppLocalizations.of(context).translate("Northern Region"),
      ],
      "3": [
        'Southern Region',
        AppLocalizations.of(context).translate("Southern Region"),
      ],
      "4": [
        'Western Region',
        AppLocalizations.of(context).translate("Western Region"),
      ],
      "5": [
        'Middle Region',
        AppLocalizations.of(context).translate("Middle Region"),
      ],
    };
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
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    decoration: textInputdecoration.copyWith(
                      hintText: AppLocalizations.of(context).translate('name'),
                      labelText: AppLocalizations.of(context).translate('name'),
                    ),
                    validator: (val) => val.isEmpty
                        ? AppLocalizations.of(context)
                            .translate('name_validator')
                        : null,
                    onChanged: (val) => setState(() => currentName = val),
                  ),
                ),
                Spacer(),
                DropdownButtonFormField<String>(
                  value: currentSpeciality,
                  isDense: false,
                  decoration: textInputdecoration,
                  hint: Text(
                    AppLocalizations.of(context).translate('speciality'),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  dropdownColor: Colors.grey[200],
                  elevation: 5,
                  icon: Icon(Icons.arrow_drop_down),
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(
                      value: specialities['1'][1],
                      child: Text(specialities['1'][0]),
                    ),
                    DropdownMenuItem(
                      value: specialities["2"][1],
                      child: Text(specialities["2"][0]),
                    ),
                    DropdownMenuItem(
                      value: specialities["3"][1],
                      child: Text(specialities["3"][0]),
                    ),
                    DropdownMenuItem(
                      value: specialities["4"][1],
                      child: Text(specialities["4"][0]),
                    ),
                    DropdownMenuItem(
                      value: specialities["5"][1],
                      child: Text(specialities["5"][0]),
                    ), //5
                    DropdownMenuItem(
                      value: specialities["6"][1],
                      child: Text(specialities["6"][0]),
                    ),
                    DropdownMenuItem(
                      value: specialities["7"][1],
                      child: Text(specialities["7"][0]),
                    ),
                    DropdownMenuItem(
                      value: specialities["8"][1],
                      child: Text(specialities["8"][0]),
                    ),
                    DropdownMenuItem(
                      value: specialities["9"][1],
                      child: Text(specialities["9"][0]),
                    ),
                    DropdownMenuItem(
                      value: specialities["10"][1],
                      child: Text(specialities["10"][0]),
                    ), //10
                    DropdownMenuItem(
                      value: specialities["11"][1],
                      child: Text(specialities["11"][0]),
                    ),
                    DropdownMenuItem(
                      value: specialities["12"][1],
                      child: Text(specialities["12"][0]),
                    ),
                    DropdownMenuItem(
                      value: specialities["13"][1],
                      child: Text(specialities['13'][0]),
                    ),
                    DropdownMenuItem(
                      value: specialities["14"][1],
                      child: Text(specialities["14"][0]),
                    ),
                    DropdownMenuItem(
                      value: specialities["15"][1],
                      child: Text(specialities["15"][0]),
                    ), //15
                    DropdownMenuItem(
                      value: specialities["16"][1],
                      child: Text(specialities["16"][0]),
                    ),
                    DropdownMenuItem(
                      value: specialities["17"][1],
                      child: Text(specialities["17"][0]),
                    ),
                    DropdownMenuItem(
                      value: specialities["18"][1],
                      child: Text(specialities["18"][0]),
                    ),
                    DropdownMenuItem(
                      value: specialities["19"][1],
                      child: Text(specialities["19"][0]),
                    ),
                    DropdownMenuItem(
                      value: specialities["20"][1],
                      child: Text(specialities["20"][0]),
                    ), //20
                    DropdownMenuItem(
                      value: specialities["21"][1],
                      child: Text(specialities["21"][0]),
                    ),
                    DropdownMenuItem(
                      value: specialities["22"][1],
                      child: Text(specialities["22"][0]),
                    ),
                    DropdownMenuItem(
                      value: specialities["23"][1],
                      child: Text(specialities["23"][0]),
                    )
                  ],
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
                  validator: (val) => val.length < 11 && val.length > 11
                      ? AppLocalizations.of(context)
                          .translate('phoneNumber_validator')
                      : null,
                ),
                Spacer(),
                DropdownButtonFormField<String>(
                  isDense: false,
                  value: currentProvince,
                  decoration: textInputdecoration,
                  hint: Text(
                    AppLocalizations.of(context).translate('province'),
                  ),
                  dropdownColor: Colors.grey[200],
                  elevation: 5,
                  icon: Icon(Icons.arrow_drop_down),
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(
                      value: province["1"][0],
                      child: Text(province["1"][1]),
                    ),
                    DropdownMenuItem(
                      value: province["2"][0],
                      child: Text(province["2"][1]),
                    ),
                    DropdownMenuItem(
                      value: province["3"][0],
                      child: Text(province["3"][1]),
                    ),
                    DropdownMenuItem(
                      value: province["4"][0],
                      child: Text(province["4"][1]),
                    ),
                    DropdownMenuItem(
                      value: province["5"][0],
                      child: Text(province["5"][1]),
                    ),
                  ],
                  /*items: province.map((province) {
                    return DropdownMenuItem(
                      value: province,
                      child: Text('$province'),
                    );
                  }).toList(),*/
                  validator: (value) =>
                      value == null ? 'Select your province' : null,
                  onChanged: (val) => setState(() => currentProvince = val),
                ),
                Spacer(
                  flex: 5,
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                  child: ButtonTheme(
                    child: RaisedButton.icon(
                      color: Colors.deepOrange,
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      onPressed: () async {
                        print(currentSpeciality);
                        print(currentProvince);
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
