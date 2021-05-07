import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/custom_widges/custom_button.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/data_model/auth_data.dart';
import 'package:project_doctor/services/database.dart';
import 'package:project_doctor/views/profile/doctor02_clinic.dart';
import 'dart:ui' as ui;

class ProfileDataView extends StatefulWidget {
  @override
  _ProfileDataViewState createState() => _ProfileDataViewState();
}

class _ProfileDataViewState extends State<ProfileDataView> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isAppbar: true,
      title: LocaleKeys.view_doctor_doctor_form.tr(),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Container(
              height: 500,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Directionality(
                    textDirection: ui.TextDirection.rtl,
                    child: TextField(
                      onChanged: (val) => setState(() => RegisterData.name = val),
                      decoration: CStyle.getInputDecoration(context).copyWith(
                        hintText: LocaleKeys.view_doctor_name.tr(),
                      ),
                    ),
                  ),
                  Container(
                    height: getDeviceType(context, 42, 50, 63, 60),
                    decoration: CStyle.box,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: getDeviceType(context, 15, 20, 25, 30),
                        ),
                        child: DropdownButton(
                          value: RegisterData.speciality,
                          isDense: false,
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: getDeviceType(context, 30, 35, 40, 45),
                          underline: SizedBox(),
                          hint: Text(LocaleKeys.view_doctor_speciality.tr(), style: CStyle.getTitleBlack(context)),
                          onChanged: (val) {
                            RegisterData.speciality = val;
                            setState(() {});
                          },
                          items: [
                            DropdownMenuItem(
                              value: CuraData.specialities['1'][1],
                              child: Text(CuraData.specialities['1'][0]),
                            ),
                            DropdownMenuItem(
                              value: CuraData.specialities["2"][1],
                              child: Text(CuraData.specialities["2"][0]),
                            ),
                            DropdownMenuItem(
                              value: CuraData.specialities["3"][1],
                              child: Text(CuraData.specialities["3"][0]),
                            ),
                            DropdownMenuItem(
                              value: CuraData.specialities["4"][1],
                              child: Text(CuraData.specialities["4"][0]),
                            ),
                            DropdownMenuItem(
                              value: CuraData.specialities["5"][1],
                              child: Text(CuraData.specialities["5"][0]),
                            ), //5
                            DropdownMenuItem(
                              value: CuraData.specialities["6"][1],
                              child: Text(CuraData.specialities["6"][0]),
                            ),
                            DropdownMenuItem(
                              value: CuraData.specialities["7"][1],
                              child: Text(CuraData.specialities["7"][0]),
                            ),
                            DropdownMenuItem(
                              value: CuraData.specialities["8"][1],
                              child: Text(CuraData.specialities["8"][0]),
                            ),
                            DropdownMenuItem(
                              value: CuraData.specialities["9"][1],
                              child: Text(CuraData.specialities["9"][0]),
                            ),
                            DropdownMenuItem(
                              value: CuraData.specialities["10"][1],
                              child: Text(CuraData.specialities["10"][0]),
                            ), //10
                            DropdownMenuItem(
                              value: CuraData.specialities["11"][1],
                              child: Text(CuraData.specialities["11"][0]),
                            ),
                            DropdownMenuItem(
                              value: CuraData.specialities["12"][1],
                              child: Text(CuraData.specialities["12"][0]),
                            ),
                            DropdownMenuItem(
                              value: CuraData.specialities["13"][1],
                              child: Text(CuraData.specialities['13'][0]),
                            ),
                            DropdownMenuItem(
                              value: CuraData.specialities["14"][1],
                              child: Text(CuraData.specialities["14"][0]),
                            ),
                            DropdownMenuItem(
                              value: CuraData.specialities["15"][1],
                              child: Text(CuraData.specialities["15"][0]),
                            ), //15
                            DropdownMenuItem(
                              value: CuraData.specialities["16"][1],
                              child: Text(CuraData.specialities["16"][0]),
                            ),
                            DropdownMenuItem(
                              value: CuraData.specialities["17"][1],
                              child: Text(CuraData.specialities["17"][0]),
                            ),
                            DropdownMenuItem(
                              value: CuraData.specialities["18"][1],
                              child: Text(CuraData.specialities["18"][0]),
                            ),
                            DropdownMenuItem(
                              value: CuraData.specialities["19"][1],
                              child: Text(CuraData.specialities["19"][0]),
                            ),
                            DropdownMenuItem(
                              value: CuraData.specialities["20"][1],
                              child: Text(CuraData.specialities["20"][0]),
                            ), //20
                            DropdownMenuItem(
                              value: CuraData.specialities["21"][1],
                              child: Text(CuraData.specialities["21"][0]),
                            ),
                            DropdownMenuItem(
                              value: CuraData.specialities["22"][1],
                              child: Text(CuraData.specialities["22"][0]),
                            ),
                            DropdownMenuItem(
                              value: CuraData.specialities["23"][1],
                              child: Text(CuraData.specialities["23"][0]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: BaseButton(
                title: "NEXT",
                onPressed: () {
                  print(CuraData.specialities["5"]);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DoctorForm extends StatefulWidget {
  final String email;
  final String password;

  DoctorForm({this.email, this.password});
  @override
  _DoctorFormState createState() => _DoctorFormState(email: email, password: password);
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
  //-----------validate phonenumber------------
  int _number = 0;
  int finalNumber = 0;
  String finalTextNumber = '';
  String error;
  validateNumber(String number) {
    try {
      _number = int.parse(number);
      return _number;
    } catch (e) {
      return null;
    }
  }

  _showSnackBar() {
    var lang = Localizations.localeOf(context).languageCode;

    final snackBar = new SnackBar(
      content: new Text(
        error,
        style: TextStyle(fontSize: 15, fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
      ),

      //duration: new Duration(seconds: 3),
      backgroundColor: Colors.deepOrange,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: currentSpeciality,
              isDense: false,
              decoration: CStyle.getInputDecoration(context),
              hint: Text(
                LocaleKeys.view_doctor_speciality.tr(),
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
                  value: CuraData.specialities['1'][1],
                  child: Text(CuraData.specialities['1'][0]),
                ),
                DropdownMenuItem(
                  value: CuraData.specialities["2"][1],
                  child: Text(CuraData.specialities["2"][0]),
                ),
                DropdownMenuItem(
                  value: CuraData.specialities["3"][1],
                  child: Text(CuraData.specialities["3"][0]),
                ),
                DropdownMenuItem(
                  value: CuraData.specialities["4"][1],
                  child: Text(CuraData.specialities["4"][0]),
                ),
                DropdownMenuItem(
                  value: CuraData.specialities["5"][1],
                  child: Text(CuraData.specialities["5"][0]),
                ), //5
                DropdownMenuItem(
                  value: CuraData.specialities["6"][1],
                  child: Text(CuraData.specialities["6"][0]),
                ),
                DropdownMenuItem(
                  value: CuraData.specialities["7"][1],
                  child: Text(CuraData.specialities["7"][0]),
                ),
                DropdownMenuItem(
                  value: CuraData.specialities["8"][1],
                  child: Text(CuraData.specialities["8"][0]),
                ),
                DropdownMenuItem(
                  value: CuraData.specialities["9"][1],
                  child: Text(CuraData.specialities["9"][0]),
                ),
                DropdownMenuItem(
                  value: CuraData.specialities["10"][1],
                  child: Text(CuraData.specialities["10"][0]),
                ), //10
                DropdownMenuItem(
                  value: CuraData.specialities["11"][1],
                  child: Text(CuraData.specialities["11"][0]),
                ),
                DropdownMenuItem(
                  value: CuraData.specialities["12"][1],
                  child: Text(CuraData.specialities["12"][0]),
                ),
                DropdownMenuItem(
                  value: CuraData.specialities["13"][1],
                  child: Text(CuraData.specialities['13'][0]),
                ),
                DropdownMenuItem(
                  value: CuraData.specialities["14"][1],
                  child: Text(CuraData.specialities["14"][0]),
                ),
                DropdownMenuItem(
                  value: CuraData.specialities["15"][1],
                  child: Text(CuraData.specialities["15"][0]),
                ), //15
                DropdownMenuItem(
                  value: CuraData.specialities["16"][1],
                  child: Text(CuraData.specialities["16"][0]),
                ),
                DropdownMenuItem(
                  value: CuraData.specialities["17"][1],
                  child: Text(CuraData.specialities["17"][0]),
                ),
                DropdownMenuItem(
                  value: CuraData.specialities["18"][1],
                  child: Text(CuraData.specialities["18"][0]),
                ),
                DropdownMenuItem(
                  value: CuraData.specialities["19"][1],
                  child: Text(CuraData.specialities["19"][0]),
                ),
                DropdownMenuItem(
                  value: CuraData.specialities["20"][1],
                  child: Text(CuraData.specialities["20"][0]),
                ), //20
                DropdownMenuItem(
                  value: CuraData.specialities["21"][1],
                  child: Text(CuraData.specialities["21"][0]),
                ),
                DropdownMenuItem(
                  value: CuraData.specialities["22"][1],
                  child: Text(CuraData.specialities["22"][0]),
                ),
                DropdownMenuItem(
                  value: CuraData.specialities["23"][1],
                  child: Text(CuraData.specialities["23"][0]),
                )
              ],
              validator: (value) => value == null ? LocaleKeys.view_doctor_speciality_validator.tr() : null,
              onChanged: (val) => setState(() {
                currentSpeciality = val;
              }),
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: CStyle.getInputDecoration(context).copyWith(
                hintText: LocaleKeys.view_doctor_phoneNumber.tr(),
                labelText: LocaleKeys.view_doctor_phoneNumber.tr(),
              ),
              validator: (val) => val.length < 11 ? LocaleKeys.view_doctor_phoneNumber_validator.tr() : null,
              onChanged: (val) => setState(() => currentPhoneNumber = val),
            ),
            DropdownButtonFormField<String>(
              isDense: false,
              value: currentProvince,
              decoration: CStyle.getInputDecoration(context),
              hint: Text(
                LocaleKeys.view_doctor_province.tr(),
              ),
              dropdownColor: Colors.grey[200],
              elevation: 5,
              icon: Icon(Icons.arrow_drop_down),
              isExpanded: true,
              items: [
                DropdownMenuItem(
                  value: CuraData.province["1"][0],
                  child: Text(CuraData.province["1"][1]),
                ),
                DropdownMenuItem(
                  value: CuraData.province["2"][0],
                  child: Text(CuraData.province["2"][1]),
                ),
                DropdownMenuItem(
                  value: CuraData.province["3"][0],
                  child: Text(CuraData.province["3"][1]),
                ),
                DropdownMenuItem(
                  value: CuraData.province["4"][0],
                  child: Text(CuraData.province["4"][1]),
                ),
                DropdownMenuItem(
                  value: CuraData.province["5"][0],
                  child: Text(CuraData.province["5"][1]),
                ),
                DropdownMenuItem(
                  value: CuraData.province["6"][0],
                  child: Text(CuraData.province["6"][1]),
                ),
                DropdownMenuItem(
                  value: CuraData.province["7"][0],
                  child: Text(CuraData.province["7"][1]),
                ),
                DropdownMenuItem(
                  value: CuraData.province["8"][0],
                  child: Text(CuraData.province["8"][1]),
                ),
                DropdownMenuItem(
                  value: CuraData.province["9"][0],
                  child: Text(CuraData.province["9"][1]),
                ),
                DropdownMenuItem(
                  value: CuraData.province["10"][0],
                  child: Text(CuraData.province["10"][1]),
                ),
                DropdownMenuItem(
                  value: CuraData.province["11"][0],
                  child: Text(CuraData.province["11"][1]),
                ),
                DropdownMenuItem(
                  value: CuraData.province["12"][0],
                  child: Text(CuraData.province["12"][1]),
                ),
                DropdownMenuItem(
                  value: CuraData.province["13"][0],
                  child: Text(CuraData.province["13"][1]),
                ),
                DropdownMenuItem(
                  value: CuraData.province["14"][0],
                  child: Text(CuraData.province["14"][1]),
                ),
                DropdownMenuItem(
                  value: CuraData.province["15"][0],
                  child: Text(CuraData.province["15"][1]),
                ),
                DropdownMenuItem(
                  value: CuraData.province["16"][0],
                  child: Text(CuraData.province["16"][1]),
                ),
                DropdownMenuItem(
                  value: CuraData.province["17"][0],
                  child: Text(CuraData.province["17"][1]),
                ),
                DropdownMenuItem(
                  value: CuraData.province["18"][0],
                  child: Text(CuraData.province["18"][1]),
                ),
              ],
              /*items: province.map((province) {
                return DropdownMenuItem(
                  value: province,
                  child: Text('$province'),
                );
              }).toList(),*/
              validator: (val) => val == null ? LocaleKeys.view_doctor_province_validator.tr() : null,
              onChanged: (val) => setState(() {
                currentProvince = val;
                DatabaseService.validationProvince = val;
                DatabaseService.province = val;
              }),
            ),
            Spacer(
              flex: 5,
            ),
            Container(
              height: 50,
              width: 150,
              child: ButtonTheme(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                  ),
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      finalNumber = await validateNumber(currentPhoneNumber);
                      finalTextNumber = finalNumber.toString();
                      if (finalNumber != null) {
                        if (currentName != null && currentSpeciality != null && currentPhoneNumber != null && currentProvince != null) {
                          if (finalTextNumber.substring(0, 1) == '7') {
                            finalTextNumber = '0' + finalTextNumber;
                          } else if (finalTextNumber.substring(0, 1) == '9') {
                            finalTextNumber = '00' + finalTextNumber;
                          }
                          print(finalTextNumber);
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => GrandClinicForm(
                                email: email,
                                password: password,
                                name: currentName,
                                speciality: currentSpeciality,
                                phoneNumber: finalTextNumber,
                                province: currentProvince,
                              ),
                            ),
                          );
                        }
                      } else {
                        error = LocaleKeys.view_patient_age_format.tr();
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
            )
          ],
        ),
      ),
    );
  }
}
