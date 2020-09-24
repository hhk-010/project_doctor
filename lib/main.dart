import 'package:flutter/material.dart';
import 'package:project_doctor/pages/home.dart';
import 'package:project_doctor/authorization/wrapper.dart';
import 'package:project_doctor/pages/patient.dart';
import 'package:project_doctor/pages/result.dart';
import 'package:project_doctor/pages/doctor_update.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_doctor/pages/doctor_info.dart';
import 'package:project_doctor/services/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.deepOrange,
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cura',
        theme: ThemeData(
          primaryColor: Colors.deepOrange,
        ),
        locale: _locale,
        supportedLocales: [
          Locale('en', 'US'),
          Locale("ar", "IQ"),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        initialRoute: '/home',
        routes: {
          '/home': (context) => Home(),
          '/intermediate': (context) => Intermediate(),
          '/patient': (context) => Patient(),
          '/doctor_update': (context) => DoctorUpdate(),
          '/doctor_info': (context) => DoctorInfo(),
          '/result': (context) => Result(),
        },
      );
    }
  }
}
