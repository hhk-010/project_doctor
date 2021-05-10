import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_home.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/generated/custom_icons.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:project_doctor/views/auth/sign_up.dart';
import 'package:project_doctor/views/auth/sign_wrapper.dart';
import 'package:project_doctor/views/home/support.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/search/search_history/history_profile.dart';
import 'dart:ui' as ui;
import 'package:project_doctor/views/search/search_wrapper.dart';
import 'package:stacked_themes/stacked_themes.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16)),
            gradient: LinearGradient(
              colors: [
                getColor(context, LightPalette.gradientTop, DarkPalette.gradientTop),
                getColor(context, LightPalette.gradientBottom, DarkPalette.gradientBottom),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            child: BottomNavigationBar(
                elevation: 0,
                iconSize: 24,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white,
                backgroundColor: Colors.transparent,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                onTap: (index) {
                  if (index == 0) Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchWrapper()));
                  if (index == 1) Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchHistoryProfile()));
                  if (index == 2) Navigator.of(context).push(MaterialPageRoute(builder: (context) => Intermediate()));
                  if (index == 3) Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpView()));
                  if (index == 4) Navigator.of(context).push(MaterialPageRoute(builder: (context) => SupportView()));
                },
                items: [
                  BottomNavigationBarItem(icon: Icon(CustomIcons.search), label: "Search"),
                  BottomNavigationBarItem(icon: Icon(CustomIcons.history), label: "History"),
                  BottomNavigationBarItem(icon: Icon(CustomIcons.account), label: "Account"),
                  BottomNavigationBarItem(icon: Icon(CustomIcons.favorite), label: "Favorite"),
                  BottomNavigationBarItem(
                    icon: Icon(
                      CustomIcons.support,
                    ),
                    label: "Support",
                  ),
                ]),
          ),
        ),
      ),
      body: HomeViewBody(),
    );
  }
}

class HomeViewBody extends StatefulWidget {
  @override
  _HomeViewBodyState createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isAppbar: false,
      child: Stack(
        children: [
          HomeAlignWidgets(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(0.0),
            isIcon: false,
            width: MediaQuery.of(context).size.width,
            height: 350,
            asset: getTheme(context) ? 'assets/images/home/header_light.png' : 'assets/images/home/header_dark.png',
          ),
          HomeAlignWidgets(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 75),
            isIcon: false,
            width: 120,
            height: 140,
            asset: 'assets/images/home/logo.png',
          ),
          HomeAlignWidgets(
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
          HomeAlignWidgets(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.all(8.0),
            isIcon: true,
            onTap: () => getThemeManager(context).toggleDarkLightTheme(),
            icon: getTheme(context) ? Image.asset('assets/images/home/moon.png') : Image.asset('assets/images/home/sun.png'),
            iconSize: 40,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 210),
              child: Container(
                width: 350,
                height: 300,
                padding: const EdgeInsets.all(16.0),
                decoration: CStyle.box,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: Text(
                        LocaleKeys.view_home_title.tr(),
                        style: CStyle.getHeading(context).copyWith(color: getColor(context, Colors.black87, Colors.white)),
                      ),
                    ),
                    Text(
                      LocaleKeys.view_home_search_complain.tr(),
                      textAlign: TextAlign.justify,
                      style: CStyle.getSubtitle(context),
                    ),
                    Text(
                      LocaleKeys.view_home_search_name.tr(),
                      textAlign: TextAlign.justify,
                      style: CStyle.getSubtitle(context),
                    ),
                    Text(
                      LocaleKeys.view_home_register_doctor.tr(),
                      textAlign: TextAlign.justify,
                      style: CStyle.getSubtitle(context),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
