import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/custom_widges/custom_home.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';

class SupportView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isAppbar: false,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: getDeviceType(context, 250, 350, 450, 600),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: getTheme(context)
                          ? AssetImage("assets/images/home/header_light.png")
                          : AssetImage("assets/images/home/header_dark.png"),
                      fit: BoxFit.fill),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: getDeviceType(context, 50, 75, 120, 160)),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: Container(
                  width: getDeviceType(context, 100, 120, 140, 180),
                  height: getDeviceType(context, 120, 140, 160, 210),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/home/support.png"), fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                top: getDeviceType(context, 150, 250, 300, 350),
              ),
              child: Container(
                height: getDeviceType(context, 250, 350, 450, 550),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BaseButton(
                      title: LocaleKeys.view_support_about_us.tr(),
                      onPressed: () => getDialog(
                        context,
                        LocaleKeys.view_support_about_us.tr(),
                        LocaleKeys.view_support_introduction.tr(),
                      ),
                    ),
                    BaseButton(
                      title: LocaleKeys.view_support_privacy_policy.tr(),
                      onPressed: () => getDialog(
                        context,
                        LocaleKeys.view_support_privacy_policy.tr(),
                        LocaleKeys.view_support_privacyPolicy.tr(),
                      ),
                    ),
                    BaseButton(
                      title: LocaleKeys.view_support_terms_conditions.tr(),
                      onPressed: () => getDialog(
                        context,
                        LocaleKeys.view_support_terms_conditions.tr(),
                        LocaleKeys.view_support_terms_conditions_details.tr(),
                      ),
                    ),
                    BaseButton(
                      title: LocaleKeys.view_support_website.tr(),
                      onPressed: () async {
                        const url = 'https://sites.google.com/view/cura-mobile/home';
                        await launch(url);
                      },
                    ),
                    BaseButton(
                      title: LocaleKeys.view_support_contact_us.tr(),
                      onPressed: () async {
                        const url = 'mailto:hhk.01831@gmail.com';
                        await launch(url);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          CustomFooter(
            child: Text(
              LocaleKeys.view_support_cura_rights.tr(),
              style: CustomStyle.getFooter(context),
            ),
          )
        ],
      ),
    );
  }
}
