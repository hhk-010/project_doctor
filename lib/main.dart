import 'package:flutter/material.dart';
import 'package:project_doctor/pages/home.dart';
import 'package:project_doctor/pages/intermediate.dart';
import 'package:project_doctor/pages/patient.dart';
import 'package:project_doctor/pages/doctor.dart';
import 'package:project_doctor/pages/result.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.deepOrange,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

      theme: ThemeData(
        fontFamily: 'noto_arabic',
      ),

      //set routing for the app
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/intermediate': (context) => Intermediate(),
        '/patient': (context) => Patient(),
        '/doctor': (context) => Doctor(),
        '/result': (context) => Result(),
      },
    );
  }
}
