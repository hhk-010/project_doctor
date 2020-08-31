import 'package:flutter/material.dart';
import 'package:project_doctor/pages/home.dart';
import 'package:project_doctor/pages/patient.dart';
import 'package:project_doctor/pages/doctor.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Project demo',
    theme: ThemeData(
      primaryColor: Colors.black,
      primaryColorLight: Colors.black,
      accentColor: Colors.green,
    ),
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/patient': (context) => Patient(),
      '/doctor': (context) => Doctor(),
    },
  ));
}
