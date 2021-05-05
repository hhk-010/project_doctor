import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/constants/custom_widgets.dart';
import 'package:project_doctor/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/home/custom_widgets.dart';

import 'dart:math' as math;

import 'package:url_launcher/url_launcher.dart';

class SupportView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseStack(
      isAppbar: false,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.all(0.0),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: getTheme(context) ? AssetImage("assets/images/home/header_light.png") : AssetImage("assets/images/home/header_dark.png"),
                      fit: BoxFit.fill),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 75),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Container(
                width: 140,
                height: 160,
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
            padding: const EdgeInsets.only(top: 250),
            child: Container(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SupportButtons(
                    title: LocaleKeys.support_view_about_us.tr(),
                    dialogContext: LocaleKeys.support_view_introduction.tr(),
                  ),
                  SupportButtons(
                    title: LocaleKeys.support_view_privacy_policy.tr(),
                    dialogContext: LocaleKeys.support_view_privacyPolicy.tr(),
                  ),
                  SupportButtons(
                    title: LocaleKeys.support_view_terms_conditions.tr(),
                    dialogContext: LocaleKeys.support_view_terms_conditions_details.tr(),
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          primary: Colors.white,
                          backgroundColor: Colors.deepOrange,
                        ),
                        onPressed: () async {
                          const url = 'https://sites.google.com/view/cura-mobile/home';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could Not Launch $url';
                          }
                        },
                        child: Text(LocaleKeys.support_view_website.tr(), style: CStyle.buttonText)),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.5,
            height: 30,
            child: Column(
              children: [
                Divider(
                  color: Colors.grey,
                  thickness: 2,
                  height: 2,
                ),
                Text(
                  LocaleKeys.home_view_cura_rights.tr(),
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
