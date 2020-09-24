import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:project_doctor/main.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/language.dart';
import 'package:project_doctor/services/theme_const.dart';

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
    return Scaffold(
      drawer: _drawerList(),
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('home_title')),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        brightness: Brightness.dark,
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
        ],
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 60.0,
                  width: 300.0,
                  child: RaisedButton(
                    onPressed: () => Navigator.pushNamed(context, '/patient'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: boxDecoration,
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('home_patient'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  height: 60.0,
                  width: 350.0,
                  child: RaisedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/intermediate'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: boxDecoration,
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 350.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context).translate('home_doctor'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _drawerList() {
    TextStyle _textStyle = TextStyle(
      fontSize: 24,
      color: Colors.white,
    );
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      color: Theme.of(context).primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(
              height: 100,
              child: CircleAvatar(),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              AppLocalizations.of(context).translate('about_us'),
              style: _textStyle,
            ),
            onTap: () {
              Navigator.pop(context);
              // Navigator.pushNamed(context, routeName),
            },
          ),
        ],
      ),
    );
  }
}
