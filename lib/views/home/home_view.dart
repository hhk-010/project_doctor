import 'package:flutter/material.dart';
import 'package:project_doctor/authorization/01_wrapper.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/constants/custom_widgets.dart';
import 'package:project_doctor/pages/patient_pages/patient01_complain.dart';
import 'package:project_doctor/translations/locale_keys.g.dart';
import 'package:project_doctor/views/home/custom_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/home/support_view.dart';
import 'package:stacked_themes/stacked_themes.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GradientBackground(
          child: Stack(children: [
            HomeAlignComponent(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(0.0),
              isIcon: false,
              width: MediaQuery.of(context).size.width,
              height: 350,
              asset: getTheme(context) ? 'assets/images/home/header_light.png' : 'assets/images/home/header_dark.png',
            ),
            HomeAlignComponent(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 75),
              isIcon: false,
              width: 120,
              height: 140,
              asset: 'assets/images/home/logo.png',
            ),
            HomeAlignComponent(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(8.0),
              isIcon: true,
              onTap: () async {
                if (getLocale(context)) {
                  await context.setLocale(Locale('ar'));
                } else {
                  await context.setLocale(Locale('en'));
                }
              },
              icon: getLocale(context) ? Image.asset('assets/images/home/ar.png') : Image.asset('assets/images/home/en.png'),
              iconSize: 40,
            ),
            HomeAlignComponent(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.all(8.0),
              isIcon: true,
              onTap: () {
                getThemeManager(context).toggleDarkLightTheme();
              },
              icon: getTheme(context) ? Image.asset('assets/images/home/moon.png') : Image.asset('assets/images/home/sun.png'),
              iconSize: 40,
            ),
            HomeAlignComponent(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(8.0),
              isIcon: true,
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SupportView())),
              icon: Image.asset('assets/images/home/info.png'),
              iconSize: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeButtonComponent(
                        title: LocaleKeys.home_view_search_button.tr(),
                        icon: 'assets/images/home/male_doctor.png',
                        color: getColor(context, LightPalette.homeButton1, DarkPalette.homeButton1),
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => PatientComplain())),
                      ),
                      HomeButtonComponent(
                        title: LocaleKeys.home_view_search_button.tr(),
                        icon: 'assets/images/home/male_doctor.png',
                        color: getColor(context, LightPalette.homeButton3, DarkPalette.homeButton3),
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => PatientComplain())),
                      ),
                      HomeButtonComponent(
                        title: LocaleKeys.home_view_profile_button.tr(),
                        color: getColor(context, LightPalette.homeButton2, DarkPalette.homeButton2),
                        icon: 'assets/images/home/stethoscope.png',
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Intermediate())),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
