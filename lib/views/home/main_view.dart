import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/generated/custom_icons.dart';
import 'package:project_doctor/views/auth/sign_up_view.dart';
import 'package:project_doctor/views/auth/sign_wrapper.dart';
import 'package:project_doctor/views/home/home_view.dart';
import 'package:project_doctor/views/home/support_view.dart';
import 'dart:ui';

import 'package:project_doctor/views/search/wrapper.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16)),
            gradient: LinearGradient(
              colors: [
                getColor(context, LightPalette.gradientTop, DarkPalette.gradientTop),
                getColor(context, LightPalette.gradientBottom, DarkPalette.gradientBottom),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            child: BottomNavigationBar(
                elevation: 0,
                iconSize: 24,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white,
                backgroundColor: Colors.transparent,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                onTap: (index) {
                  if (index == 0) Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchWrapper()));
                  if (index == 1) Navigator.of(context).push(MaterialPageRoute(builder: (context) => SupportView()));
                  if (index == 2) Navigator.of(context).push(MaterialPageRoute(builder: (context) => Intermediate()));
                  if (index == 3) Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpView()));
                  if (index == 4) Navigator.of(context).push(MaterialPageRoute(builder: (context) => SupportView()));
                },
                items: [
                  BottomNavigationBarItem(icon: Icon(CustomIcons.search), label: "Search"),
                  BottomNavigationBarItem(icon: Icon(CustomIcons.history), label: "History"),
                  BottomNavigationBarItem(icon: Icon(CustomIcons.account), label: "Account"),
                  BottomNavigationBarItem(icon: Icon(CustomIcons.favorite), label: "Favorite"),
                  BottomNavigationBarItem(
                    icon: Icon(
                      CustomIcons.support,
                    ),
                    label: "Support",
                  ),
                ]),
          ),
        ),
      ),
      body: HomeView(),
    );
  }
}
