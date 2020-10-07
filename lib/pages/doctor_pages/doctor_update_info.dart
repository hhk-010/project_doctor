import 'dart:ui';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/pages/doctor_pages/doctor_update_map.dart';
import 'package:project_doctor/pages/doctor_pages/doctor_update_password.dart';

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
  String validateMobile(String value) {
    if (value.length != 11)
      return 'Mobile Number must be of 11 digit';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: EdgeInsets.symmetric(vertical: 60, horizontal: 40),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: textInputdecoration.copyWith(
                      hintText: 'Name', labelText: 'Name'),
                  onChanged: (val) {
                    name = val;
                  },
                  validator: (val) =>
                      val.isEmpty ? 'Enter Your Name Please' : null,
                ),
                SizedBox(height: 25.0),
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
                  validator: (value) => value == null
                      ? AppLocalizations.of(context)
                          .translate('doctor_form_speciality')
                      : null,
                  onChanged: (val) => setState(() => speciality = val),
                ),
                SizedBox(height: 25.0),
                TextFormField(
                    onChanged: (val) => setState(() => phonenumber = val),
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
                  onChanged: (val) => setState(() => province = val),
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
                SizedBox(height: 50.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UpdatePassword()));
                  },
                  child: RichText(
                    text: TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Do you Want to Change Your Password? '),
                        TextSpan(
                            text: 'Change',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                      ],
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
