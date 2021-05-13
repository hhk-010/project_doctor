import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';

class CustomComplainColumn extends StatelessWidget {
  final Widget child1;
  final Widget child2;
  final Widget child3;
  final bool isMainTitle;
  final Function(bool) switchOnchanged;
  const CustomComplainColumn({Key key, this.child1, this.child2, this.isMainTitle, this.child3, this.switchOnchanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CustomStyle.box,
      height: getDeviceType(context, 200, 250, 300, 350),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getDeviceType(context, 8, 16, 24, 32), vertical: getDeviceType(context, 4, 8, 16, 24)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(
                isMainTitle ? LocaleKeys.view_patient_main_complain.tr() : LocaleKeys.view_patient_add_complains.tr(),
                style: CustomStyle.getTitleBlack(context),
              ),
            ),
            Divider(
              color: Colors.grey,
              thickness: 2,
              indent: 30,
              endIndent: 30,
            ),
            child1,
            child2,
            child3,
          ],
        ),
      ),
    );
  }
}

class CustomComplainSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;

  const CustomComplainSwitch({Key key, this.value, this.onChanged}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      activeColor: Colors.deepOrange,
      dense: true,
      title: Text(
        LocaleKeys.view_patient_other_complain.tr(),
        style: CustomStyle.getFooter(context),
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}
