import 'dart:ui';
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
            Navigator.pushNamed(context, '/about_us');
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
          Padding(
            padding: EdgeInsets.all(8.0),
            child: DropdownButton(
              onChanged: (Language language) {
                _changeLanguage(language);
              },
              underline: SizedBox(),
              icon: Icon(
                Icons.language,
                color: Colors.white,
              ),
              items: Language.languageList()
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
          IconButton(
            icon: Icon(Icons.email),
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 75),
        child: Container(
          height: double.maxFinite,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.maxFinite,
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
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: AppLocalizations.of(context)
                                  .translate('home_patient_title'),
                              style: TextStyle(
                                  fontFamily: lang == 'ar'
                                      ? 'noto_arabic'
                                      : 'Helvetica',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
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
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    color: Colors.deepOrange,
                  ),
                ),
                Container(
                  width: double.maxFinite,
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
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: AppLocalizations.of(context)
                                  .translate('home_doctor_title'),
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: lang == 'ar'
                                      ? 'noto_arabic'
                                      : 'Helvetica',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
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
    );
  }
}
