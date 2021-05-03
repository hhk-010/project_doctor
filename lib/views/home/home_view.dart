import 'package:flutter/material.dart';
import 'package:project_doctor/constants/device_size.dart';
import 'package:project_doctor/translations/locale_keys.g.dart';
import 'package:project_doctor/views/home/components.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
        body: Stack(children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/home/header.png'), fit: BoxFit.fill),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 75),
              child: Container(
                width: 120,
                height: 140,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/home/logo.png'), fit: BoxFit.fill),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () => null,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/home/ar.png'), fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () => null,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/home/moon.png'), fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/support'),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/home/info.png'), fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeButtonComponent(
                      title: LocaleKeys.home_search_button.tr(),
                      icon: 'assets/images/home/male_doctor.png',
                      color: Colors.deepOrange,
                      onPressed: () => Navigator.pushNamed(context, '/patient_complain'),
                    ),
                    SizedBox(
                      height: getDeviceType(context, 35, 45, 55, 65),
                    ),
                    HomeButtonComponent(
                      title: "Create an Account",
                      icon: 'assets/images/home/stethoscope.png',
                      color: Colors.orange,
                      onPressed: () => Navigator.pushNamed(context, '/intermediate'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
