import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_dropdownbutton.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/database.dart';
import 'package:project_doctor/views/profile/2_clinic_data.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ProfileDataView extends StatefulWidget {
  @override
  _ProfileDataViewState createState() => _ProfileDataViewState();
}

class _ProfileDataViewState extends State<ProfileDataView> {
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
      title: LocaleKeys.view_doctor_doctor_form.tr(),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: getDeviceType(context, 15, 25, 50, 75),
            ),
            child: Container(
              height: getDeviceType(context, 250, 300, 400, 500),
              width: getDeviceType(context, 250, 300, 400, 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: getDeviceType(context, 40, 50, 60, 70),
                    child: TextField(
                      onChanged: (val) => setState(() => RegisterData.name = val),
                      decoration: CustomStyle.getInputDecoration(context).copyWith(
                        hintText: LocaleKeys.view_doctor_name.tr(),
                        prefixIcon: Icon(
                          Icons.info,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: getDeviceType(context, 40, 50, 60, 70),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: CustomStyle.getInputDecoration(context).copyWith(
                        hintText: LocaleKeys.view_doctor_phoneNumber.tr(),
                        prefixIcon: Icon(
                          Icons.phone,
                        ),
                      ),
                      onChanged: (val) => setState(() => RegisterData.phoneNumber = val),
                    ),
                  ),
                  CustomDropDownButton(
                    value: RegisterData.speciality,
                    hint: LocaleKeys.view_doctor_speciality.tr(),
                    onChanged: (val) {
                      RegisterData.speciality = val;
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
                  CustomDropDownButton(
                    value: RegisterData.province,
                    hint: LocaleKeys.view_doctor_province.tr(),
                    onChanged: (val) => setState(() {
                      RegisterData.province = val;
                      DatabaseService.validationProvince = val;
                      DatabaseService.province = val;
                    }),
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
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: getDeviceType(context, 50, 100, 150, 200)),
              child: CustomLoadingButton(
                controller: _controller,
                title: LocaleKeys.view_buttons_next.tr(),
                onPressed: () async {
                  if (RegisterData.name != null &&
                      RegisterData.speciality != null &&
                      RegisterData.phoneNumber != null &&
                      RegisterData.province != null) {
                    finalNumber = await validateNumber(RegisterData.phoneNumber);
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
                          builder: (context) => ClinicStream(),
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
        ],
      ),
    );
  }
}
