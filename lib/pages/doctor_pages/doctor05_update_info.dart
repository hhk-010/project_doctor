import 'dart:ui';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/pages/doctor_pages/doctor06_update_map.dart';
import 'package:project_doctor/pages/doctor_pages/doctor07_update_password.dart';

class Updateinfo extends StatefulWidget {
  @override
  _UpdateinfoState createState() => _UpdateinfoState();
}

class _UpdateinfoState extends State<Updateinfo> {
  String name;
  String speciality;
  String phonenumber;
  String province;
  String address = '';
  String vacation = '';
  String workinghours = '';

  final _formkey = GlobalKey<FormState>();

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
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            AppLocalizations.of(context).translate('update_info'),
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
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
                    hintText: AppLocalizations.of(context).translate('name'),
                    labelText: AppLocalizations.of(context).translate('name')),
                onChanged: (val) {
                  name = val;
                },
                validator: (val) => val.isEmpty
                    ? AppLocalizations.of(context).translate('name_validator')
                    : null,
              ),
              Spacer(),
              DropdownButtonFormField<String>(
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
                onChanged: (val) => setState(() => speciality = val),
              ),
              Spacer(),
              TextFormField(
                  onChanged: (val) => setState(() => phonenumber = val),
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
                      : null),
              Spacer(),
              TextFormField(
                onChanged: (val) => setState(() => province = val),
                decoration: textInputdecoration.copyWith(
                  hintText: AppLocalizations.of(context).translate('province'),
                  labelText: AppLocalizations.of(context).translate('province'),
                ),
                validator: (val) => val.isEmpty
                    ? AppLocalizations.of(context)
                        .translate('province_validator')
                    : null,
              ),
              Spacer(),
              TextFormField(
                onChanged: (val) => setState(() => address = val),
                decoration:
                    textInputdecoration.copyWith(hintText: 'detailed address'),
                validator: (val) =>
                    val.isEmpty ? 'enter a valid address' : null,
              ),
              Spacer(),
              TextFormField(
                onChanged: (val) => setState(() => vacation = val),
                decoration:
                    textInputdecoration.copyWith(hintText: 'clinic vacation'),
                validator: (val) =>
                    val.isEmpty ? 'enter a valid clinic vacation days' : null,
              ),
              Spacer(),
              TextFormField(
                onChanged: (val) => setState(() => workinghours = val),
                decoration:
                    textInputdecoration.copyWith(hintText: 'working hours'),
                validator: (val) =>
                    val.isEmpty ? 'enter valid working hours' : null,
              ),
              Spacer(
                flex: 3,
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context).translate('finish_update'),
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UpdateMap(
                            name: name,
                            speciality: speciality,
                            number: phonenumber,
                            province: province,
                            address: address,
                            vacation: vacation,
                            workinghours: workinghours,
                          ),
                        ),
                      );
                    }
                  },
                  label: Text(
                    AppLocalizations.of(context).translate('google_map'),
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
                      TextSpan(
                          text: AppLocalizations.of(context)
                              .translate('change_password')),
                      TextSpan(
                          text:
                              AppLocalizations.of(context).translate('change'),
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
