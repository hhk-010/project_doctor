import 'package:flutter/material.dart';
import 'package:project_doctor/pages/home.dart';
import 'package:project_doctor/pages/patient.dart';
import 'package:project_doctor/pages/doctor.dart';
import 'package:project_doctor/pages/result.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.deepOrange,
  ));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    localizationsDelegates: [
      GlobalCupertinoLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
      Locale("ar", "AE"), // OR Locale('ar', 'AE') OR Other RTL locales
    ],
    locale: Locale("ar", "AE"), // OR Locale('ar', 'AE') OR Other RTL locales,

    title: 'Project demo',
    theme: ThemeData(
      fontFamily: 'noto_arabic',
    ),
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/patient': (context) => Patient(),
      '/doctor': (context) => Doctor(),
      '/result': (context) => Result(),
    },
  ));
}
