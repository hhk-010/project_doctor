import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:project_doctor/constants/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/services/theme.dart';
import 'package:project_doctor/services/database.dart';
import 'package:project_doctor/views/profile/doctor05.5_update_clinic.dart';
import 'package:project_doctor/views/profile/doctor07_update_password.dart';
import 'dart:ui' as ui;

class Updateinfo extends StatefulWidget {
  final String profileName;
  final String profileSpeciality;
  Updateinfo({this.profileName, this.profileSpeciality});
  @override
  _UpdateinfoState createState() => _UpdateinfoState(profileName: profileName, profileSpeciality: profileSpeciality);
}

class _UpdateinfoState extends State<Updateinfo> {
  final String profileName;
  final String profileSpeciality;
  _UpdateinfoState({this.profileName, this.profileSpeciality});
  String name = '';
  String speciality = '';
  String phonenumber = '';
  String finalTextNumber = '';
  String _province;
  String address = '';

  final _formkey = GlobalKey<FormState>();
  String _error = '';
  //-----------validate phonenumber------------
  int _number = 0;
  int finalNumber = 0;
  String error;
  validateNumber(String number) {
    try {
      _number = int.parse(number);
      return _number;
    } catch (e) {
      return null;
    }
  }

  //==============snackbar for empty latlng============
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    var lang = Localizations.localeOf(context).languageCode;

    final snackBar = new SnackBar(
      content: new Text(
        _error,
        style: TextStyle(fontSize: 15, fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
      ),

      //duration: new Duration(seconds: 3),
      backgroundColor: Colors.deepOrange,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;

    final specialities = {
      "1": [LocaleKeys.medical_specialty_Internist.tr(), 'Internist'],
      "2": [LocaleKeys.medical_specialty_Pediatrician.tr(), 'Pediatrician'],
      "3": [LocaleKeys.medical_specialty_Cardiologist.tr(), 'Cardiologist'],
      "4": [LocaleKeys.medical_specialty_Pulmonologist.tr(), 'Pulmonologist'],
      "5": [LocaleKeys.medical_specialty_Endocrinologist.tr(), 'Endocrinologist'],
      "6": [LocaleKeys.medical_specialty_Enterologist.tr(), 'Enterologist'],
      "7": [LocaleKeys.medical_specialty_Neurologist.tr(), 'Neurologist'],
      "8": [LocaleKeys.medical_specialty_Neurosurgeon.tr(), 'Neurosurgeon'],
      "9": [LocaleKeys.medical_specialty_Heamatologist.tr(), 'Heamatologist'],
      "10": [LocaleKeys.medical_specialty_Nephrologist.tr(), 'Nephrologist'],
      "11": [LocaleKeys.medical_specialty_Rheumatologist.tr(), 'Rheumatologist'],
      "12": [LocaleKeys.medical_specialty_Emergency_physician.tr(), 'Emergency physician'],
      "13": [LocaleKeys.medical_specialty_Dermatologist.tr(), 'Dermatologist'],
      "14": [LocaleKeys.medical_specialty_Psychiatrist.tr(), 'Psychiatrist'],
      "15": [LocaleKeys.medical_specialty_Gynecologist.tr(), 'Gynecologist'],
      "16": [LocaleKeys.medical_specialty_General_Surgeon.tr(), 'General Surgeon'],
      "17": [LocaleKeys.medical_specialty_Pediatric_Surgeon.tr(), 'Pediatric Surgeon'],
      "18": [LocaleKeys.medical_specialty_ThoracoVascular_Surgeon.tr(), 'ThoracoVascular Surgeon'],
      "19": [LocaleKeys.medical_specialty_Orthopaedic_Surgeon.tr(), 'Orthopaedic Surgeon'],
      "20": [LocaleKeys.medical_specialty_Urosurgeon.tr(), 'Urosurgeon'],
      "21": [LocaleKeys.medical_specialty_Plastic_Surgeon.tr(), 'Plastic Surgeon'],
      "22": [LocaleKeys.medical_specialty_Ophthalmologist.tr(), 'Ophthalmologist'],
      "23": [LocaleKeys.medical_specialty_Laryngologist.tr(), 'Laryngologist'],
    };
    final province = {
      "1": [
        "Erbil",
        LocaleKeys.iraq_provinces_Erbil.tr(),
      ],
      "2": [
        "Al Anbar",
        LocaleKeys.iraq_provinces_Al_Anbar.tr(),
      ],
      "3": [
        "Basra",
        LocaleKeys.iraq_provinces_Basra.tr(),
      ],
      "4": [
        "Al Qadisiyyah",
        LocaleKeys.iraq_provinces_Al_Qadisiyyah.tr(),
      ],
      "5": [
        "Muthanna",
        LocaleKeys.iraq_provinces_Muthanna.tr(),
      ],
      "6": [
        "Najaf",
        LocaleKeys.iraq_provinces_Najaf.tr(),
      ],
      "7": [
        "Babil",
        LocaleKeys.iraq_provinces_Babil.tr(),
      ],
      "8": [
        'Baghdad',
        LocaleKeys.iraq_provinces_Baghdad.tr(),
      ],
      "9": [
        "Duhok",
        LocaleKeys.iraq_provinces_Duhok.tr(),
      ],
      "10": [
        "Diyala",
        LocaleKeys.iraq_provinces_Diyala.tr(),
      ],
      "11": [
        "Dhi Qar",
        LocaleKeys.iraq_provinces_Dhi_Qar.tr(),
      ],
      "12": [
        "Sulaymaniyah",
        LocaleKeys.iraq_provinces_Sulaymaniyah.tr(),
      ],
      "13": [
        "Saladin",
        LocaleKeys.iraq_provinces_Saladin.tr(),
      ],
      "14": [
        "Karbala",
        LocaleKeys.iraq_provinces_Karbala.tr(),
      ],
      "15": [
        "Kirkuk",
        LocaleKeys.iraq_provinces_Kirkuk.tr(),
      ],
      "16": [
        "Maysan",
        LocaleKeys.iraq_provinces_Maysan.tr(),
      ],
      "17": [
        "Nineveh",
        LocaleKeys.iraq_provinces_Nineveh.tr(),
      ],
      "18": [
        "Wasit",
        LocaleKeys.iraq_provinces_Wasit.tr(),
      ],
    };

    return Scaffold(
      key: _scaffoldkey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.deepOrange,
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              LocaleKeys.view_doctor_update_info.tr(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Center(
        child: Container(
          width: 100,
          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: Form(
            key: _formkey,
            child: Container(
              height: double.maxFinite,
              child: Column(
                children: [
                  Directionality(
                    textDirection: ui.TextDirection.rtl,
                    child: TextFormField(
                      decoration:
                          textInputdecoration.copyWith(hintText: LocaleKeys.view_doctor_name.tr(), labelText: LocaleKeys.view_doctor_name.tr()),
                      onChanged: (val) {
                        name = val;
                      },
                      validator: (val) => val.isEmpty ? LocaleKeys.view_doctor_name_validator.tr() : null,
                    ),
                  ),
                  Spacer(),
                  DropdownButtonFormField<String>(
                    decoration: textInputdecoration,
                    isDense: false,
                    hint: Text(
                      LocaleKeys.view_doctor_speciality.tr(),
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
                    validator: (value) => value == null ? LocaleKeys.view_doctor_speciality_validator.tr() : null,
                    onChanged: (val) => setState(() => speciality = val),
                  ),
                  Spacer(),
                  TextFormField(
                      onChanged: (val) => setState(() => phonenumber = val),
                      keyboardType: TextInputType.phone,
                      decoration: textInputdecoration.copyWith(
                        hintText: LocaleKeys.view_doctor_phoneNumber.tr(),
                        labelText: LocaleKeys.view_doctor_phoneNumber.tr(),
                      ),
                      validator: (val) => val.length < 11 && val.length > 11 ? LocaleKeys.view_doctor_phoneNumber_validator.tr() : null),
                  Spacer(),
                  DropdownButtonFormField<String>(
                    isDense: false,
                    decoration: textInputdecoration,
                    hint: Text(
                      LocaleKeys.view_doctor_province.tr(),
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
                      DropdownMenuItem(
                        value: province["6"][0],
                        child: Text(province["6"][1]),
                      ),
                      DropdownMenuItem(
                        value: province["7"][0],
                        child: Text(province["7"][1]),
                      ),
                      DropdownMenuItem(
                        value: province["8"][0],
                        child: Text(province["8"][1]),
                      ),
                      DropdownMenuItem(
                        value: province["9"][0],
                        child: Text(province["9"][1]),
                      ),
                      DropdownMenuItem(
                        value: province["10"][0],
                        child: Text(province["10"][1]),
                      ),
                      DropdownMenuItem(
                        value: province["11"][0],
                        child: Text(province["11"][1]),
                      ),
                      DropdownMenuItem(
                        value: province["12"][0],
                        child: Text(province["12"][1]),
                      ),
                      DropdownMenuItem(
                        value: province["13"][0],
                        child: Text(province["13"][1]),
                      ),
                      DropdownMenuItem(
                        value: province["14"][0],
                        child: Text(province["14"][1]),
                      ),
                      DropdownMenuItem(
                        value: province["15"][0],
                        child: Text(province["15"][1]),
                      ),
                      DropdownMenuItem(
                        value: province["16"][0],
                        child: Text(province["16"][1]),
                      ),
                      DropdownMenuItem(
                        value: province["17"][0],
                        child: Text(province["17"][1]),
                      ),
                      DropdownMenuItem(
                        value: province["18"][0],
                        child: Text(province["18"][1]),
                      ),
                    ],
                    validator: (value) => value == null ? 'Select your province' : null,
                    onChanged: (val) => setState(() {
                      DatabaseService.validationProvince = val;
                      _province = val;
                    }),
                  ),
                  Spacer(
                    flex: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        LocaleKeys.view_doctor_finish_update.tr(),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
                  Container(
                    height: 50,
                    width: 150,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        backgroundColor: Colors.deepOrange,
                      ),
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          finalNumber = await validateNumber(phonenumber);
                          finalTextNumber = finalNumber.toString();
                          if (finalNumber != null) {
                            if ((profileSpeciality == speciality || profileSpeciality == '')) {
                              if (finalTextNumber.substring(0, 1) == '7') {
                                finalTextNumber = '0' + finalTextNumber;
                              } else if (finalTextNumber.substring(0, 1) == '9') {
                                finalTextNumber = '00' + finalTextNumber;
                              }
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => UpdateInfo2(
                                    name: name,
                                    speciality: speciality,
                                    phoneNumber: finalTextNumber,
                                    province: _province,
                                  ),
                                ),
                              );
                            } else {
                              setState(() {
                                _error = LocaleKeys.view_snack_error_snack_update.tr();
                              });
                              _showSnackBar();
                            }
                          } else {
                            _error = LocaleKeys.view_patient_age_format.tr();
                            _showSnackBar();
                          }
                        }
                      },
                      label: Text(
                        LocaleKeys.view_buttons_next.tr(),
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 3,
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdatePassword()));
                    },
                    child: RichText(
                      text: TextSpan(
                        text: '',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica',
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: LocaleKeys.view_doctor_change_password.tr(),
                          ),
                          TextSpan(text: " " + LocaleKeys.view_doctor_change.tr(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
