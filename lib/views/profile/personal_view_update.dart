import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_home.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/custom_widges/custom_button.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/data_model/auth_data.dart';
import 'package:project_doctor/services/database.dart';
import 'package:project_doctor/views/profile/doctor05.5_update_clinic.dart';
import 'package:project_doctor/views/profile/password_update_view.dart';

class UpdateProfileDataView extends StatefulWidget {
  @override
  _UpdateProfileDataViewState createState() => _UpdateProfileDataViewState();
}

class _UpdateProfileDataViewState extends State<UpdateProfileDataView> {
  //-----------validate phonenumber------------
  int _number = 0;
  int finalNumber = 0;
  String finalTextNumber = '';
  validateNumber(String number) {
    try {
      _number = int.parse(number);
      return _number;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isAppbar: true,
      title: LocaleKeys.view_doctor_update_info.tr(),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Container(
              height: 300,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    onChanged: (val) => setState(() => RegisterData.name = val),
                    decoration: CStyle.getInputDecoration(context).copyWith(
                      hintText: LocaleKeys.view_doctor_name.tr(),
                      prefixIcon: Icon(
                        Icons.info,
                      ),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.phone,
                    decoration: CStyle.getInputDecoration(context).copyWith(
                      hintText: LocaleKeys.view_doctor_phoneNumber.tr(),
                      prefixIcon: Icon(
                        Icons.phone,
                      ),
                    ),
                    onChanged: (val) => setState(() => RegisterData.phoneNumber = val),
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
                          hint: Text(LocaleKeys.view_doctor_speciality.tr(), style: CStyle.getSubtitle(context)),
                          onChanged: (val) {
                            RegisterData.speciality = val;
                            setState(() {});
                          },
                          items: [
                            DropdownMenuItem(
                              value: 'Internist',
                              child: Text(LocaleKeys.medical_specialty_Internist.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Pediatrician',
                              child: Text(LocaleKeys.medical_specialty_Pediatrician.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Cardiologist',
                              child: Text(LocaleKeys.medical_specialty_Cardiologist.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Pulmonologist',
                              child: Text(LocaleKeys.medical_specialty_Pulmonologist.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Endocrinologist',
                              child: Text(LocaleKeys.medical_specialty_Endocrinologist.tr(), style: CStyle.getSubtitle(context)),
                            ), //5
                            DropdownMenuItem(
                              value: 'Enterologist',
                              child: Text(LocaleKeys.medical_specialty_Enterologist.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Neurologist',
                              child: Text(LocaleKeys.medical_specialty_Neurologist.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Neurosurgeon',
                              child: Text(LocaleKeys.medical_specialty_Neurosurgeon.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Heamatologist',
                              child: Text(LocaleKeys.medical_specialty_Heamatologist.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Nephrologist',
                              child: Text(LocaleKeys.medical_specialty_Nephrologist.tr(), style: CStyle.getSubtitle(context)),
                            ), //10
                            DropdownMenuItem(
                              value: 'Rheumatologist',
                              child: Text(LocaleKeys.medical_specialty_Rheumatologist.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Emergency physician',
                              child: Text(LocaleKeys.medical_specialty_Emergency_physician.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Dermatologist',
                              child: Text(LocaleKeys.medical_specialty_Dermatologist.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Psychiatrist',
                              child: Text(LocaleKeys.medical_specialty_Psychiatrist.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Gynecologist',
                              child: Text(LocaleKeys.medical_specialty_Gynecologist.tr(), style: CStyle.getSubtitle(context)),
                            ), //15
                            DropdownMenuItem(
                              value: 'General Surgeon',
                              child: Text(LocaleKeys.medical_specialty_General_Surgeon.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Pediatric Surgeon',
                              child: Text(LocaleKeys.medical_specialty_Pediatric_Surgeon.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'ThoracoVascular Surgeon',
                              child: Text(LocaleKeys.medical_specialty_ThoracoVascular_Surgeon.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Orthopaedic Surgeon',
                              child: Text(LocaleKeys.medical_specialty_Orthopaedic_Surgeon.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Urosurgeon',
                              child: Text(LocaleKeys.medical_specialty_Urosurgeon.tr(), style: CStyle.getSubtitle(context)),
                            ), //20
                            DropdownMenuItem(
                              value: 'Plastic Surgeon',
                              child: Text(LocaleKeys.medical_specialty_Plastic_Surgeon.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Ophthalmologist',
                              child: Text(LocaleKeys.medical_specialty_Ophthalmologist.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Laryngologist',
                              child: Text(LocaleKeys.medical_specialty_Laryngologist.tr(), style: CStyle.getSubtitle(context)),
                            ),
                          ],
                        ),
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
                        child: DropdownButton<String>(
                          onChanged: (val) => setState(() {
                            RegisterData.province = val;
                            DatabaseService.validationProvince = val;
                            DatabaseService.province = val;
                          }),
                          isDense: false,
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: getDeviceType(context, 30, 35, 40, 45),
                          underline: SizedBox(),
                          value: RegisterData.province,
                          hint: Text(LocaleKeys.view_doctor_province.tr(), style: CStyle.getSubtitle(context)),
                          items: [
                            DropdownMenuItem(
                              value: "Erbil",
                              child: Text(
                                LocaleKeys.iraq_provinces_Erbil.tr(),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "Al Anbar",
                              child: Text(LocaleKeys.iraq_provinces_Al_Anbar.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Basra",
                              child: Text(LocaleKeys.iraq_provinces_Basra.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Al Qadisiyyah",
                              child: Text(LocaleKeys.iraq_provinces_Al_Qadisiyyah.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Muthanna",
                              child: Text(LocaleKeys.iraq_provinces_Muthanna.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Najaf"[0],
                              child: Text(LocaleKeys.iraq_provinces_Najaf.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Babil",
                              child: Text(LocaleKeys.iraq_provinces_Babil.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Baghdad',
                              child: Text(LocaleKeys.iraq_provinces_Baghdad.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Duhok",
                              child: Text(LocaleKeys.iraq_provinces_Duhok.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Diyala",
                              child: Text(LocaleKeys.iraq_provinces_Diyala.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Dhi Qar",
                              child: Text(LocaleKeys.iraq_provinces_Dhi_Qar.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Sulaymaniyah",
                              child: Text(LocaleKeys.iraq_provinces_Sulaymaniyah.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Saladin",
                              child: Text(LocaleKeys.iraq_provinces_Saladin.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Karbala",
                              child: Text(LocaleKeys.iraq_provinces_Karbala.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Kirkuk",
                              child: Text(LocaleKeys.iraq_provinces_Kirkuk.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Maysan",
                              child: Text(LocaleKeys.iraq_provinces_Maysan.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Nineveh",
                              child: Text(LocaleKeys.iraq_provinces_Nineveh.tr(), style: CStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Wasit",
                              child: Text(LocaleKeys.iraq_provinces_Wasit.tr(), style: CStyle.getSubtitle(context)),
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
              padding: const EdgeInsets.only(bottom: 100),
              child: BaseButton(
                title: LocaleKeys.view_buttons_next.tr(),
                onPressed: () async {
                  if (RegisterData.name != null &&
                      RegisterData.name.isNotEmpty &&
                      RegisterData.phoneNumber != null &&
                      RegisterData.phoneNumber.isNotEmpty &&
                      RegisterData.province != null &&
                      RegisterData.province.isNotEmpty) {
                    finalNumber = await validateNumber(RegisterData.phoneNumber);
                    finalTextNumber = finalNumber.toString();
                    if (finalNumber != null) {
                      if (finalTextNumber.substring(0, 1) == '7') {
                        finalTextNumber = '0' + finalTextNumber;
                      } else if (finalTextNumber.substring(0, 1) == '9') {
                        finalTextNumber = '00' + finalTextNumber;
                      }
                      print(finalTextNumber);
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UpdateInfo2(),
                        ),
                      );
                    } else
                      getFlushbar(context, LocaleKeys.view_patient_age_format.tr())..show(context);
                  } else
                    getFlushbar(context, LocaleKeys.view_snack_error_sign_info.tr())..show(context);
                },
              ),
            ),
          ),
          CustomFooter(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PasswordUpdateView()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.view_doctor_change_password.tr(),
                    style: CStyle.getFooter(context),
                  ),
                  Text('  '),
                  Text(
                    LocaleKeys.view_doctor_change.tr(),
                    style: CStyle.getFooter(context).copyWith(color: Colors.red[400], fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
