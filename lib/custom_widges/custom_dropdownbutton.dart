import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';

class CustomDropDownButton extends StatelessWidget {
  final String value;
  final String hint;
  final Function(String) onChanged;
  final Color color;
  final List<DropdownMenuItem<String>> items;
  const CustomDropDownButton({
    Key key,
    this.value,
    this.hint,
    this.onChanged,
    this.items,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getDeviceType(context, 40, 50, 60, 70),
      decoration: CustomStyle.box,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: getDeviceType(context, 0, 0, 8, 8),
          horizontal: getDeviceType(context, 8, 16, 24, 32),
        ),
        child: DropdownButton<String>(
          value: value,
          isDense: false,
          isExpanded: true,
          underline: SizedBox(),
          icon: Icon(Icons.keyboard_arrow_down),
          iconSize: getDeviceType(context, 25, 35, 45, 55),
          hint: Text(hint, style: CustomStyle.getSubtitle(context).copyWith(color: color)),
          onChanged: onChanged,
          items: items,
        ),
      ),
    );
  }
}

class CustomComplainDropDownButton extends StatelessWidget {
  final String value;
  final String genderSelect;
  final Function(String) onChanged;
  final List<DropdownMenuItem<String>> items;
  const CustomComplainDropDownButton({
    Key key,
    this.value,
    this.onChanged,
    this.items,
    this.genderSelect,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getDeviceType(context, 40, 50, 60, 70),
      decoration: CustomStyle.box,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: getDeviceType(context, 0, 0, 8, 8),
          horizontal: getDeviceType(context, 8, 16, 24, 32),
        ),
        child: DropdownButton<String>(
          value: value,
          isDense: false,
          isExpanded: true,
          underline: SizedBox(),
          icon: Icon(Icons.keyboard_arrow_down),
          iconSize: getDeviceType(context, 25, 35, 45, 55),
          hint: FittedBox(fit: BoxFit.fitWidth, child: Text(LocaleKeys.view_patient_complain_area.tr(), style: CustomStyle.getSubtitle(context))),
          onChanged: onChanged,
          items: [
            DropdownMenuItem<String>(
              value: "cardioRespiratory",
              child: Text(
                ('heart_lung').tr(),
                style: CustomStyle.getSubtitle(context),
              ),
            ),
            DropdownMenuItem<String>(
              value: "gastroIntestinal",
              child: Text(
                ('git').tr(),
                style: CustomStyle.getSubtitle(context),
              ),
            ),
            DropdownMenuItem<String>(
              value: "peiranalAbdomen",
              child: Text(
                ('perianal_abdomen').tr(),
                style: CustomStyle.getSubtitle(context),
              ),
            ),
            DropdownMenuItem<String>(
              value: "neurology",
              child: Text(
                ('brain_neuron').tr(),
                style: CustomStyle.getSubtitle(context),
              ),
            ),
            DropdownMenuItem<String>(
              value: "musckuloskeletal",
              child: Text(
                ('skeleton_muscles').tr(),
                style: CustomStyle.getSubtitle(context),
              ),
            ),
            DropdownMenuItem<String>(
              value: "headNeckBack",
              child: Text(
                ('head_neck_back').tr(),
                style: CustomStyle.getSubtitle(context),
              ),
            ),
            DropdownMenuItem<String>(
              value: "upperLimb",
              child: Text(
                ('upper_limb').tr(),
                style: CustomStyle.getSubtitle(context),
              ),
            ),
            DropdownMenuItem<String>(
              value: "lowerLimb",
              child: Text(
                ('lower_limb').tr(),
                style: CustomStyle.getSubtitle(context),
              ),
            ),
            DropdownMenuItem<String>(
              value: "hand",
              child: Text(
                ('Hand').tr(),
                style: CustomStyle.getSubtitle(context),
              ),
            ),
            DropdownMenuItem<String>(
              value: "mouth",
              child: Text(
                ('mouth').tr(),
                style: CustomStyle.getSubtitle(context),
              ),
            ),
            DropdownMenuItem<String>(
              value: "appetite",
              child: Text(
                ('appetite').tr(),
                style: CustomStyle.getSubtitle(context),
              ),
            ),
            DropdownMenuItem<String>(
              value: "entThroat",
              child: Text(
                ('throat').tr(),
                style: CustomStyle.getSubtitle(context),
              ),
            ),
            DropdownMenuItem<String>(
              value: "entNose",
              child: Text(
                ('nose').tr(),
                style: CustomStyle.getSubtitle(context),
              ),
            ),
            DropdownMenuItem<String>(
              value: "entEar",
              child: Text(
                ('ear').tr(),
                style: CustomStyle.getSubtitle(context),
              ),
            ),
            DropdownMenuItem<String>(
              value: "ophthalmology",
              child: Text(
                ('eye').tr(),
                style: CustomStyle.getSubtitle(context),
              ),
            ),
            DropdownMenuItem<String>(
              value: "dermatology",
              child: Text(
                ('skin').tr(),
                style: CustomStyle.getSubtitle(context),
              ),
            ),
            DropdownMenuItem<String>(
              value: "uroKidney",
              child: Text(
                ('uro').tr(),
                style: CustomStyle.getSubtitle(context),
              ),
            ),
            genderSelect == 'Male'
                ? DropdownMenuItem<String>(
                    value: "maleGenital",
                    child: Text(
                      ('male_genital').tr(),
                      style: CustomStyle.getSubtitle(context),
                    ),
                  )
                : DropdownMenuItem<String>(
                    value: "gynecology",
                    child: Text(
                      ('gynecology').tr(),
                      style: CustomStyle.getSubtitle(context),
                    ),
                  ),
            DropdownMenuItem<String>(
              value: "breast",
              child: Text(
                ('Breast').tr(),
                style: CustomStyle.getSubtitle(context),
              ),
            ),
            DropdownMenuItem<String>(
              value: "psychology",
              child: Text(
                ('psychology').tr(),
                style: CustomStyle.getSubtitle(context),
              ),
            ),
            DropdownMenuItem<String>(
              value: "injuriesSuicideIntoxicationBurn",
              child: Text(
                ('injuriesSuicideIntoxicationBurn').tr(),
                style: CustomStyle.getSubtitle(context),
              ),
            ),
            DropdownMenuItem<String>(
              value: "others",
              child: Text(
                ('other_symptoms').tr(),
                style: CustomStyle.getSubtitle(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
