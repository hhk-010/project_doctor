import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_home.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/generated/custom_icons.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:project_doctor/views/auth/sign_wrapper.dart';
import 'package:project_doctor/views/favorite/favorite_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/profile/2_clinic_data.dart';
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
                iconSize: getDeviceType(context, 20, 24, 28, 32),
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
                  if (index == 3) Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavoriteListView()));
                  if (index == 4) Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClinicStream()));
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
            height: getDeviceType(context, 250, 350, 450, 600),
            asset: getTheme(context) ? 'assets/images/home/header_light.png' : 'assets/images/home/header_dark.png',
          ),
          HomeAlignWidgets(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: getDeviceType(context, 50, 75, 120, 160)),
            isIcon: false,
            width: getDeviceType(context, 100, 120, 140, 180),
            height: getDeviceType(context, 120, 140, 160, 210),
            asset: 'assets/images/home/logo.png',
          ),
          HomeAlignWidgets(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(getDeviceType(context, 8, 8, 24, 32)),
            isIcon: true,
            onTap: () async {
              if (getLocale(context)) {
                await context.setLocale(Locale('ar'));
              } else {
                await context.setLocale(Locale('en'));
              }
            },
            icon: getLocale(context) ? Image.asset('assets/images/home/ar.png') : Image.asset('assets/images/home/en.png'),
            iconSize: getDeviceType(context, 30, 40, 50, 60),
          ),
          HomeAlignWidgets(
            alignment: Alignment.topRight,
            padding: EdgeInsets.all(getDeviceType(context, 8, 8, 24, 32)),
            isIcon: true,
            onTap: () => getThemeManager(context).toggleDarkLightTheme(),
            icon: getTheme(context) ? Image.asset('assets/images/home/moon.png') : Image.asset('assets/images/home/sun.png'),
            iconSize: getDeviceType(context, 30, 40, 50, 60),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                top: getDeviceType(context, 150, 210, 250, 300),
              ),
              child: Container(
                width: getDeviceType(context, 250, 350, 450, 500),
                height: getDeviceType(context, 250, 300, 400, 450),
                padding: EdgeInsets.all(
                  getDeviceType(context, 8, 16, 24, 32),
                ),
                decoration: CustomStyle.box,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: Text(LocaleKeys.view_home_title.tr(), style: CustomStyle.getTitleBlack(context)),
                    ),
                    Text(
                      LocaleKeys.view_home_search_complain.tr(),
                      textAlign: TextAlign.justify,
                      style: CustomStyle.getSubtitle(context),
                    ),
                    Text(
                      LocaleKeys.view_home_search_name.tr(),
                      textAlign: TextAlign.justify,
                      style: CustomStyle.getSubtitle(context),
                    ),
                    Text(
                      LocaleKeys.view_home_register_doctor.tr(),
                      textAlign: TextAlign.justify,
                      style: CustomStyle.getSubtitle(context),
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
