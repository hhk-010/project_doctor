import 'dart:ui';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/pages/doctor_pages/doctor05_update_map.dart';
import 'package:project_doctor/pages/doctor_pages/doctor05_update_password.dart';

class Updateinfo extends StatefulWidget {
  @override
  _UpdateinfoState createState() => _UpdateinfoState();
}

class _UpdateinfoState extends State<Updateinfo> {
  String name;
  String speciality;
  String phonenumber;
  String province;

  final _formkey = GlobalKey<FormState>();
  final List<String> specialities = [
    'Cardiologist',
    'Pulmonologist',
    'Endocrinologist',
    'Enterologist',
    'General Surgeon',
    'Pediatric Surgeon',
    'ThoracoVascular Surgeon',
    'Emergency Department',
    'Internist',
    'Pediatrician',
    'Gynecologist',
    'Rheumatologist',
    'Nephrologist',
    'Heamatologist',
    'Neurologist',
    'Urosurgeon',
    'Orthopaedic Surgeon',
    'Neurosurgeon',
    'Plastic Surgeon',
    'Dermatologist',
    'Ophthalmologist',
    'Psychiatrist',
    'Laryngologist'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Update your Information',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
              TextFormField(
                decoration: textInputdecoration.copyWith(
                    hintText: 'Name', labelText: 'Name'),
                onChanged: (val) {
                  name = val;
                },
                validator: (val) => val.isEmpty ? 'Enter Your Name' : null,
              ),
              Spacer(),
              DropdownButtonFormField<String>(
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
                validator: (value) =>
                    value == null ? 'Choose your Speciality' : null,
                onChanged: (val) => setState(() => speciality = val),
              ),
              Spacer(),
              TextFormField(
                  onChanged: (val) => setState(() => phonenumber = val),
                  keyboardType: TextInputType.phone,
                  decoration: textInputdecoration.copyWith(
                    hintText: AppLocalizations.of(context)
                        .translate('doctor_form_phoneNumber'),
                    labelText: AppLocalizations.of(context)
                        .translate('doctor_form_phoneNumber'),
                  ),
                  validator: (val) => val.length < 11
                      ? "Phone Number must be 11 digits"
                      : null),
              Spacer(),
              TextFormField(
                onChanged: (val) => setState(() => province = val),
                decoration: textInputdecoration.copyWith(
                  hintText: AppLocalizations.of(context)
                      .translate('doctor_form_province'),
                  labelText: AppLocalizations.of(context)
                      .translate('doctor_form_province'),
                ),
                validator: (val) => val.isEmpty ? '' : null,
              ),
              Spacer(
                flex: 3,
              ),
              Row(
                children: [
                  Text(
                    'Finish Updating your Information by ',
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UpdateMap(
                                name: name,
                                speciality: speciality,
                                number: phonenumber,
                                province: province,
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
              Spacer(
                flex: 3,
              ),
              Divider(color: Colors.black),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UpdatePassword()));
                },
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: 'Change Your Password?'),
                      TextSpan(
                          text: ' Change',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
