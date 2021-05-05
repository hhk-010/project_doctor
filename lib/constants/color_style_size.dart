import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LightPalette {
  static const Color homeButton1 = Color(0xFFFD6636);
  static const Color homeButton2 = Color(0xFFFCBA36);
  static const Color homeButton3 = Color(0xFF3CA5D1);
  static const Color background = Color(0xFFEEEEEE);
  static const Color appbar1 = Color(0xFFFD6636);
  static const Color appbar2 = Color(0xFFFCB536);
  static const Color bottomBarBackgroundColor = Color(0xFFFCBE36);
}

class DarkPalette {
  static const Color homeButton1 = Color(0xFFF9844A);
  static const Color homeButton2 = Color(0xFFFF9E00);
  static const Color homeButton3 = Color(0xFF277DA1);
  static const Color background1 = Color(0xFF03071E);
  static const Color background2 = Color(0xFF577590);
  static const Color appbar1 = Color(0xFF03071E);
  static const Color appbar2 = Color(0xFF577590);
}

class CStyle {
  static const TextStyle buttonText = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  static const TextStyle appbarTitle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
}

// get currentTheme
bool getTheme(BuildContext context) {
  return Theme.of(context).brightness == Brightness.light ? true : false;
}

// method to set button color
Color getColor(BuildContext context, Color light, Color dark) {
  return getTheme(context) ? light : dark;
}

// responsive layout according to screensize
double getDeviceType(context, double small, double mobile, double tablet, double desktop) {
  var deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth < 350) return small;
  if (deviceWidth > 350 && deviceWidth < 600) return mobile;
  if (deviceWidth > 600 && deviceWidth < 950) return tablet;
  if (deviceWidth > 950) return desktop;
  return null;
}

// get current locale
bool getLocale(BuildContext context) {
  return EasyLocalization.of(context).locale.toString() == 'en' ? true : false;
}
