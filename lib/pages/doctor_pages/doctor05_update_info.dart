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
  String name = '';
  String speciality = '';
  String phonenumber = '';
  String _Province;
  String address = '';
  String vacation = '';
  String workinghours = '';

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final specialities = {
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
                /*items: specialities.map((speciality) {
                  return DropdownMenuItem(
                    value: speciality,
                    child: Text('$speciality'),
                  );
                }).toList(),*/
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
              DropdownButtonFormField<String>(
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
                validator: (value) =>
                    value == null ? 'Select your province' : null,
                onChanged: (val) => setState(() => _Province = val),
              ),
              /*TextFormField(
                onChanged: (val) => setState(() => province = val),
                decoration: textInputdecoration.copyWith(
                  hintText: AppLocalizations.of(context).translate('province'),
                  labelText: AppLocalizations.of(context).translate('province'),
                ),
                validator: (val) => val.isEmpty
                    ? AppLocalizations.of(context)
                        .translate('province_validator')
                    : null,
              ),*/
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
                            province: _Province,
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
                  print(speciality);
                  print(_Province);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UpdatePassword()));
                },
                child: RichText(
                  text: TextSpan(
                    text: '',
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
