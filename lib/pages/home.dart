import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_doctor/main.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/constants/language.dart';

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
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.info),
          tooltip: AppLocalizations.of(context).translate('about_us'),
          onPressed: () {
            Navigator.pushNamed(context, '/patient_get_location');
          },
        ),
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            AppLocalizations.of(context).translate('home_title'),
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        actions: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: DropdownButton(
                onChanged: (Language language) {
                  _changeLanguage(language);
                },
                underline: SizedBox(),
                icon: Icon(
                  Icons.language,
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
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 75),
          child: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 90,
                    width: 300,
                    child: RaisedButton.icon(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/patient_complain'),
                      icon: Icon(
                        Icons.search,
                        size: 70,
                        color: Colors.white,
                      ),
                      label: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AutoSizeText.rich(
                          TextSpan(
                              text: AppLocalizations.of(context)
                                  .translate('home_patient_title'),
                              style: TextStyle(
                                  fontFamily: lang == 'ar'
                                      ? 'noto_arabic'
                                      : 'Helvetica',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              children: [
                                TextSpan(
                                    text: AppLocalizations.of(context)
                                        .translate('home_patient_subtitle'),
                                    style: TextStyle(
                                        fontFamily: lang == 'ar'
                                            ? 'noto_arabic'
                                            : 'Helvetica',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ]),
                          maxLines: 2,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      color: Colors.deepOrange,
                    ),
                  ),
                  SizedBox(
                    height: 90,
                    width: 300,
                    child: RaisedButton.icon(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/intermediate'),
                      icon: Icon(
                        Icons.people,
                        size: 70,
                        color: Colors.white,
                      ),
                      label: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AutoSizeText.rich(
                          TextSpan(
                              text: AppLocalizations.of(context)
                                  .translate('home_doctor_title'),
                              style: TextStyle(
                                  fontSize: 28,
                                  fontFamily: lang == 'ar'
                                      ? 'noto_arabic'
                                      : 'Helvetica',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              children: [
                                TextSpan(
                                    text: AppLocalizations.of(context)
                                        .translate('home_doctor_subtitle'),
                                    style: TextStyle(
                                        fontFamily: lang == 'ar'
                                            ? 'noto_arabic'
                                            : 'Helvetica',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ]),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
