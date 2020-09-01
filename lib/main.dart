import 'package:flutter/material.dart';
import 'package:project_doctor/pages/home.dart';
import 'package:project_doctor/pages/patient.dart';
import 'package:project_doctor/pages/doctor.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.deepOrange,
  ));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Project demo',
    theme: ThemeData(
      fontFamily: 'noto_arabic',
    ),
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/patient': (context) => Patient(),
      '/doctor': (context) => Doctor(),
    },
  ));
}
