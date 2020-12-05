import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_doctor/main.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/constants/language.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/sizing_information.dart';

class Home extends StatefulWidget {
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

      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
        appBarTitle = 25;
        appBarIcon = 25;
        appBarHeight = 60;
        buttonHeight = displayHeight(context) * 0.13;
        buttonWidth = displayWidth(context) * 0.85;
        buttonTitle = displayHeight(context) * 0.035;
        buttonSubTitle = displayHeight(context) * 0.022;
        buttonIconSize = 70;
      } else {
        appBarTitle = displayHeight(context) * 0.045;
        appBarIcon = 40;
        appBarHeight = 75;
        buttonHeight = displayHeight(context) * 0.15;
        buttonWidth = displayWidth(context) * 0.6;
        buttonTitle = displayHeight(context) * 0.045;
        buttonSubTitle = displayHeight(context) * 0.03;
        buttonIconSize = 100;
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
