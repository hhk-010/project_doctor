import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_home.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/database.dart';
import 'package:project_doctor/views/profile/6_clinic_data_update.dart';
import 'package:project_doctor/views/profile/password_update.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class UpdateProfileDataView extends StatefulWidget {
  @override
  _UpdateProfileDataViewState createState() => _UpdateProfileDataViewState();
}

class _UpdateProfileDataViewState extends State<UpdateProfileDataView> {
  final RoundedLoadingButtonController _controller = RoundedLoadingButtonController();

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
      action: getAppActions(context),
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
                    onChanged: (val) => setState(() => UpdateProfileData.name = val),
                    decoration: CustomStyle.getInputDecoration(context).copyWith(
                      hintText: LocaleKeys.view_doctor_name.tr(),
                      prefixIcon: Icon(
                        Icons.info,
                      ),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.phone,
                    decoration: CustomStyle.getInputDecoration(context).copyWith(
                      hintText: LocaleKeys.view_doctor_phoneNumber.tr(),
                      prefixIcon: Icon(
                        Icons.phone,
                      ),
                    ),
                    onChanged: (val) => setState(() => UpdateProfileData.phoneNumber = val),
                  ),
                  Container(
                    height: getDeviceType(context, 42, 50, 63, 60),
                    decoration: CustomStyle.box,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: getDeviceType(context, 15, 20, 25, 30),
                        ),
                        child: DropdownButton(
                          value: UpdateProfileData.speciality,
                          isDense: false,
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: getDeviceType(context, 30, 35, 40, 45),
                          underline: SizedBox(),
                          hint: Text(LocaleKeys.view_doctor_speciality.tr(), style: CustomStyle.getSubtitle(context)),
                          onChanged: (val) {
                            UpdateProfileData.speciality = val;
                            setState(() {});
                          },
                          items: [
                            DropdownMenuItem(
                              value: 'Internist',
                              child: Text('Internist'.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Pediatrician',
                              child: Text('Pediatrician'.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Cardiologist',
                              child: Text('Cardiologist'.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Pulmonologist',
                              child: Text('Pulmonologist'.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Endocrinologist',
                              child: Text('Endocrinologist'.tr(), style: CustomStyle.getSubtitle(context)),
                            ), //5
                            DropdownMenuItem(
                              value: 'Enterologist',
                              child: Text('Enterologist'.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Neurologist',
                              child: Text('Neurologist'.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Neurosurgeon',
                              child: Text('Neurosurgeon'.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Heamatologist',
                              child: Text('Heamatologist'.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Nephrologist',
                              child: Text('Nephrologist'.tr(), style: CustomStyle.getSubtitle(context)),
                            ), //10
                            DropdownMenuItem(
                              value: 'Rheumatologist',
                              child: Text('Rheumatologist'.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Emergency physician',
                              child: Text('Emergency physician'.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Dermatologist',
                              child: Text('Dermatologist'.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Psychiatrist',
                              child: Text('Psychiatrist'.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Gynecologist',
                              child: Text('Gynecologist'.tr(), style: CustomStyle.getSubtitle(context)),
                            ), //15
                            DropdownMenuItem(
                              value: 'General Surgeon',
                              child: Text('General Surgeon'.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Pediatric Surgeon',
                              child: Text('Pediatric Surgeon'.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'ThoracoVascular Surgeon',
                              child: Text('ThoracoVascular Surgeon'.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Orthopaedic Surgeon',
                              child: Text('Orthopaedic Surgeon'.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Urosurgeon',
                              child: Text('Urosurgeon'.tr(), style: CustomStyle.getSubtitle(context)),
                            ), //20
                            DropdownMenuItem(
                              value: 'Plastic Surgeon',
                              child: Text('Plastic Surgeon'.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Ophthalmologist',
                              child: Text('Ophthalmologist'.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Laryngologist',
                              child: Text('Laryngologist'.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: getDeviceType(context, 42, 50, 63, 60),
                    decoration: CustomStyle.box,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: getDeviceType(context, 15, 20, 25, 30),
                        ),
                        child: DropdownButton<String>(
                          onChanged: (val) => setState(() {
                            UpdateProfileData.province = val;
                            DatabaseService.validationProvince = val;
                            DatabaseService.province = val;
                          }),
                          isDense: false,
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: getDeviceType(context, 30, 35, 40, 45),
                          underline: SizedBox(),
                          value: UpdateProfileData.province,
                          hint: Text(LocaleKeys.view_doctor_province.tr(), style: CustomStyle.getSubtitle(context)),
                          items: [
                            DropdownMenuItem(
                              value: "Erbil",
                              child: Text(
                                LocaleKeys.iraq_provinces_Erbil.tr(),
                                style: CustomStyle.getSubtitle(context),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "Al Anbar",
                              child: Text(LocaleKeys.iraq_provinces_Al_Anbar.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Basra",
                              child: Text(LocaleKeys.iraq_provinces_Basra.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Al Qadisiyyah",
                              child: Text(LocaleKeys.iraq_provinces_Al_Qadisiyyah.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Muthanna",
                              child: Text(LocaleKeys.iraq_provinces_Muthanna.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Najaf"[0],
                              child: Text(LocaleKeys.iraq_provinces_Najaf.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Babil",
                              child: Text(LocaleKeys.iraq_provinces_Babil.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: 'Baghdad',
                              child: Text(LocaleKeys.iraq_provinces_Baghdad.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Duhok",
                              child: Text(LocaleKeys.iraq_provinces_Duhok.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Diyala",
                              child: Text(LocaleKeys.iraq_provinces_Diyala.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Dhi Qar",
                              child: Text(LocaleKeys.iraq_provinces_Dhi_Qar.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Sulaymaniyah",
                              child: Text(LocaleKeys.iraq_provinces_Sulaymaniyah.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Saladin",
                              child: Text(LocaleKeys.iraq_provinces_Saladin.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Karbala",
                              child: Text(LocaleKeys.iraq_provinces_Karbala.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Kirkuk",
                              child: Text(LocaleKeys.iraq_provinces_Kirkuk.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Maysan",
                              child: Text(LocaleKeys.iraq_provinces_Maysan.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Nineveh",
                              child: Text(LocaleKeys.iraq_provinces_Nineveh.tr(), style: CustomStyle.getSubtitle(context)),
                            ),
                            DropdownMenuItem(
                              value: "Wasit",
                              child: Text(LocaleKeys.iraq_provinces_Wasit.tr(), style: CustomStyle.getSubtitle(context)),
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
              child: CustomLoadingButton(
                controller: _controller,
                title: LocaleKeys.view_buttons_next.tr(),
                onPressed: () async {
                  if (UpdateProfileData.name != null &&
                      UpdateProfileData.phoneNumber != null &&
                      UpdateProfileData.speciality != null &&
                      UpdateProfileData.province != null) {
                    finalNumber = await validateNumber(UpdateProfileData.phoneNumber);
                    finalTextNumber = finalNumber.toString();
                    if (finalNumber != null) {
                      if (finalTextNumber.substring(0, 1) == '7') {
                        finalTextNumber = '0' + finalTextNumber;
                      } else if (finalTextNumber.substring(0, 1) == '9') {
                        finalTextNumber = '00' + finalTextNumber;
                      }
                      print(finalTextNumber);
                      await getSuccess(_controller);
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UpdateClinicView(),
                        ),
                      );
                    } else
                      getFlushbar(context, LocaleKeys.view_patient_age_format.tr(), _controller);
                  } else
                    getFlushbar(context, LocaleKeys.error_sign_info.tr(), _controller);
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
                    style: CustomStyle.getFooter(context),
                  ),
                  Text('  '),
                  Text(
                    LocaleKeys.view_doctor_change.tr(),
                    style: CustomStyle.getFooter(context).copyWith(color: Colors.red[400], fontWeight: FontWeight.bold),
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
