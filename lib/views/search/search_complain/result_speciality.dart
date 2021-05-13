import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/matching_algorithm/final_score.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/search/search_complain/get_location_wrapper.dart';

class SpecialityResultView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        title: LocaleKeys.view_patient_speciality_result.tr(),
        isAppbar: true,
        action: getAppActions(context),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: CustomStyle.box,
                width: getDeviceType(context, 250, 350, 450, 550),
                height: getDeviceType(context, 250, 350, 450, 550),
                padding: EdgeInsets.symmetric(
                  vertical: getDeviceType(context, 16, 24, 32, 38),
                  horizontal: getDeviceType(context, 8, 16, 24, 32),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: getDeviceType(context, 75, 100, 125, 150),
                      child: Image(
                        image: AssetImage('assets/images/speciality.png'),
                      ),
                    ),
                    Text(
                      LocaleKeys.view_patient_result_speciality.tr(),
                      style: CustomStyle.getSubtitle(context),
                      textAlign: TextAlign.center,
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 2,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Center(
                      child: ListTile(
                        leading: Icon(
                          Icons.person_add,
                          size: getDeviceType(context, 30, 40, 50, 60),
                          color: Colors.deepOrangeAccent,
                        ),
                        title: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            (FinalScore.speciality).tr() + (FinalScore.or).tr() + (FinalScore.speciality2).tr(),
                            style: CustomStyle.getTitleBlack(context),
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
                padding: EdgeInsets.only(
                  bottom: getDeviceType(context, 25, 50, 75, 100),
                ),
                child: BaseButton(
                  title: LocaleKeys.view_buttons_next.tr(),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LocationWrapper()));
                  },
                ),
              ),
            )
          ],
        ));
  }
}
