import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_doctor/main.dart';
import 'package:project_doctor/pages/last_searched/Profile.dart';
import 'package:project_doctor/pages/last_searched/read_write_path.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/constants/language.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/sizing_information.dart';

class Home extends StatefulWidget {
  final LastSearchedStorage readFromStorage = LastSearchedStorage();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _changeLanguage(Language language) async {
    Locale _temp = await setLocale(language.languageCode);
    MyApp.setLocale(context, _temp);
  }

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      double appBarTitle;
      double appBarIcon;
      double appBarHeight;
      double buttonHeight;
      double buttonWidth;
      double buttonTitle;
      double buttonSubTitle;
      double buttonIconSize;
      double floatingButtonHeight;
      double floatingButtonWidth;
      double floatingButtonTitle;

      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
        appBarTitle = 25;
        appBarIcon = 25;
        appBarHeight = 60;
        buttonHeight = displayHeight(context) * 0.13;
        buttonWidth = displayWidth(context) * 0.85;
        buttonTitle = displayHeight(context) * 0.035;
        buttonSubTitle = displayHeight(context) * 0.022;
        buttonIconSize = 70;
        floatingButtonHeight = displayHeight(context) * 0.05;
        floatingButtonWidth = displayWidth(context) * 0.55;
        floatingButtonTitle = displayHeight(context) * 0.015;
      } else {
        appBarTitle = displayHeight(context) * 0.045;
        appBarIcon = 40;
        appBarHeight = 75;
        buttonHeight = displayHeight(context) * 0.15;
        buttonWidth = displayWidth(context) * 0.6;
        buttonTitle = displayHeight(context) * 0.045;
        buttonSubTitle = displayHeight(context) * 0.03;
        buttonIconSize = 100;
        floatingButtonHeight = displayHeight(context) * 0.05;
        floatingButtonWidth = displayWidth(context) * 0.5;
        floatingButtonTitle = displayHeight(context) * 0.025;
      }

      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: AppBar(
            leading: IconButton(
              icon: Icon(Icons.info),
              tooltip: AppLocalizations.of(context).translate('about_us'),
              iconSize: appBarIcon,
              onPressed: () {
                Navigator.pushNamed(context, '/about_us');
              },
            ),
            title: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                AppLocalizations.of(context).translate('home_title'),
                style: TextStyle(fontSize: appBarTitle, fontWeight: FontWeight.bold),
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.deepOrange,
            elevation: 0,
            actions: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 14),
                  child: Tooltip(
                    message: AppLocalizations.of(context).translate('language'),
                    child: DropdownButton(
                      onChanged: (Language language) {
                        _changeLanguage(language);
                      },
                      underline: SizedBox(),
                      icon: Icon(
                        Icons.language,
                        size: appBarIcon,
                        color: Colors.white,
                      ),
                      items: Language.languageList(context)
                          .map<DropdownMenuItem<Language>>(
                            (lang) => DropdownMenuItem(
                                value: lang,
                                child: Text(
                                  lang.name,
                                )),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton:
            // ShowFloatingActionButton.show
            //     ?
            Container(
          height: floatingButtonHeight,
          width: floatingButtonWidth,
          child: FloatingActionButton.extended(
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
            elevation: 0.0,
            backgroundColor: Colors.deepOrange,
            shape: RoundedRectangleBorder(
              borderRadius: lang == 'en'
                  ? BorderRadius.only(
                      topLeft: Radius.circular(20.0), topRight: Radius.zero, bottomLeft: Radius.circular(20.0), bottomRight: Radius.zero)
                  : BorderRadius.only(
                      topLeft: Radius.zero, topRight: Radius.circular(20.0), bottomLeft: Radius.zero, bottomRight: Radius.circular(20.0)),
            ),
            onPressed: () {
              //Navigator.pushNamed(context, '/phone');
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LastSearchedDoctor()));
            },
            label: Text(AppLocalizations.of(context).translate('last_searched_doctor'),
                style: TextStyle(color: Colors.white, fontSize: floatingButtonTitle, fontWeight: FontWeight.bold)),
          ),
        ),
        // : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: SafeArea(
          child: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: buttonHeight,
                    width: buttonWidth,
                    child: RaisedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, '/patient_complain'),
                      icon: Icon(
                        Icons.search,
                        size: buttonIconSize,
                        color: Colors.white,
                      ),
                      label: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AutoSizeText.rich(
                          TextSpan(
                              text: AppLocalizations.of(context).translate('home_patient_title'),
                              style: TextStyle(
                                  fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica',
                                  fontSize: buttonTitle,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              children: [
                                TextSpan(
                                    text: AppLocalizations.of(context).translate('home_patient_subtitle'),
                                    style: TextStyle(
                                        fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica',
                                        fontSize: buttonSubTitle,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ]),
                          maxLines: 2,
                        ),
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      color: Colors.deepOrange,
                    ),
                  ),
                  Container(
                    height: buttonHeight,
                    width: buttonWidth,
                    child: RaisedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, '/intermediate'),
                      icon: Icon(
                        Icons.people,
                        size: buttonIconSize,
                        color: Colors.white,
                      ),
                      label: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AutoSizeText.rich(
                          TextSpan(
                              text: AppLocalizations.of(context).translate('home_doctor_title'),
                              style: TextStyle(
                                  fontSize: buttonTitle,
                                  fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              children: [
                                TextSpan(
                                    text: AppLocalizations.of(context).translate('home_doctor_subtitle'),
                                    style: TextStyle(
                                        fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica',
                                        fontSize: buttonSubTitle,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ]),
                        ),
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
