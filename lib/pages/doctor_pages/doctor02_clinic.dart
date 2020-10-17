import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'dart:ui';
import 'doctor03_map.dart';

class ClinicForm extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  final String speciality;
  final String phoneNumber;
  final String province;

  ClinicForm(
      {this.email,
      this.password,
      this.name,
      this.phoneNumber,
      this.speciality,
      this.province});

  @override
  _ClinicFormState createState() => _ClinicFormState(
      email: email,
      password: password,
      name: name,
      speciality: speciality,
      phoneNumber: phoneNumber,
      province: province);
}

final _formKey = GlobalKey<FormState>();
String currentaddress = '';
String currentvacation = '';
String currentworkinghours = '';

class _ClinicFormState extends State<ClinicForm> {
  String email;
  String password;
  String name;
  String speciality;
  String phoneNumber;
  String province;

  _ClinicFormState({
    this.email,
    this.password,
    this.name,
    this.speciality,
    this.phoneNumber,
    this.province,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  validator: (val) => val.isEmpty ? 'Enter your address' : null,
                  onChanged: (val) => setState(() => currentaddress = val),
                  decoration: textInputdecoration.copyWith(
                      hintText:
                          'detailed address' /*AppLocalizations.of(context)
                        .translate('doctor_form_province'),
                    labelText: AppLocalizations.of(context)
                        .translate('doctor_form_province'),*/
                      ),
                ),
                Spacer(),
                TextFormField(
                  validator: (val) =>
                      val.isEmpty ? 'Enter your clinic vacation days' : null,
                  onChanged: (val) => setState(() => currentvacation = val),
                  decoration: textInputdecoration.copyWith(
                      hintText:
                          'clinic vacation days' /*AppLocalizations.of(context)
                        .translate('doctor_province'),
                    labelText: AppLocalizations.of(context)
                        .translate('doctor_province'),*/
                      ),
                ),
                Spacer(),
                TextFormField(
                  validator: (val) =>
                      val.isEmpty ? 'Enter your clinic working hours' : null,
                  onChanged: (val) => setState(() => currentworkinghours = val),
                  decoration: textInputdecoration.copyWith(
                      hintText:
                          'clinic working hours' /*AppLocalizations.of(context)
                        .translate('doctor_province'),
                    labelText: AppLocalizations.of(context)
                        .translate('doctor_province'),*/
                      ),
                ),
                Spacer(
                  flex: 3,
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context).translate('location_setup'),
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
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DocMap(
                            email: email,
                            password: password,
                            name: name,
                            speciality: speciality,
                            phone: phoneNumber,
                            province: province,
                            address: currentaddress,
                            vacation: currentvacation,
                            workinghours: currentworkinghours,
                          ),
                        ),
                      );
                    },
                    label: Text(
                      AppLocalizations.of(context).translate('google_map'),
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
