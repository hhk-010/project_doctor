import 'package:flutter/material.dart';
import 'package:project_doctor/authorization/01_wrapper.dart';
import 'package:project_doctor/constants.dart';
import 'package:project_doctor/pages/patient_pages/patient01_complain.dart';
import 'package:project_doctor/translations/locale_keys.g.dart';
import 'package:project_doctor/views/home/components.dart';
import 'package:easy_localization/easy_localization.dart';
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
        backgroundColor: Theme.of(context).backgroundColor,
        body: Stack(children: [
          HomeAlignComponent(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(0.0),
            isIcon: false,
            width: MediaQuery.of(context).size.width,
            height: 350,
            asset: Theme.of(context).brightness == Brightness.light ? 'assets/images/home/header_light.png' : 'assets/images/home/header_dark.png',
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
              if (getLocale(context) == "en") {
                await context.setLocale(Locale('ar'));
              } else {
                await context.setLocale(Locale('en'));
              }
            },
            icon: getLocale(context) == "en" ? Image.asset('assets/images/home/ar.png') : Image.asset('assets/images/home/en.png'),
            iconSize: 40,
          ),
          HomeAlignComponent(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.all(8.0),
            isIcon: true,
            onTap: () {
              getThemeManager(context).toggleDarkLightTheme();
            },
            icon: Theme.of(context).brightness == Brightness.light
                ? Image.asset('assets/images/home/moon.png')
                : Image.asset('assets/images/home/sun.png'),
            iconSize: 40,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/support'),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/home/info.png'), fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeButtonComponent(
                      title: LocaleKeys.home_view_search_button.tr(),
                      icon: 'assets/images/home/male_doctor.png',
                      color: Colors.deepOrange,
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => PatientComplain())),
                    ),
                    SizedBox(
                      height: getDeviceType(context, 35, 45, 55, 65),
                    ),
                    HomeButtonComponent(
                      title: LocaleKeys.home_view_profile_button.tr(),
                      icon: 'assets/images/home/stethoscope.png',
                      color: Colors.orange,
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Intermediate())),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
