import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LightPalette {
  static const Color gradientTop = Color(0xFFFD6636);
  static const Color gradientBottom = Color(0xFFFCB536);
  static const Color button = Color(0xFFF9844A);
}

class DarkPalette {
  static const Color gradientTop = Color(0xFF03071E);
  static const Color gradientBottom = Color(0xFF577590);
  static const Color button = Color(0xFFF8961E);
}

class CustomStyle {
  static TextStyle getHeading(context) {
    return TextStyle(
        fontSize: getDeviceType(context, 18, 20, 24, 30),
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: getLocale(context) ? 'Montserrat' : 'noto_arabic');
  }

  static TextStyle getTitle(context) {
    return TextStyle(
        fontSize: getDeviceType(context, 14, 16, 20, 24),
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: getLocale(context) ? 'Montserrat' : 'noto_arabic');
  }

  static TextStyle getTitleBlack(context) {
    return TextStyle(
      fontSize: getDeviceType(context, 14, 16, 20, 24),
      fontWeight: FontWeight.bold,
      fontFamily: getLocale(context) ? 'Montserrat' : 'noto_arabic',
    );
  }

  static TextStyle getSubtitle(context) {
    return TextStyle(
        fontSize: getDeviceType(context, 12, 14, 18, 20), fontWeight: FontWeight.bold, fontFamily: getLocale(context) ? 'OpenSans' : 'noto_arabic');
  }

  static TextStyle getFooter(context) {
    return TextStyle(
      fontSize: getDeviceType(context, 10, 12, 16, 18),
      fontWeight: FontWeight.bold,
      fontFamily: getLocale(context) ? 'OpenSans' : 'noto_arabic',
    );
  }

  static BoxDecoration box = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
    border: Border.all(
      color: Colors.orange,
      width: 2.0,
    ),
  );
  static InputDecoration getInputDecoration(BuildContext context) {
    return InputDecoration(
      hintStyle: getSubtitle(context),
      labelStyle: CustomStyle.getSubtitle(context),
      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16.0)), borderSide: BorderSide(color: Colors.deepOrange, width: 2)),
      enabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16.0)), borderSide: BorderSide(color: Colors.orange, width: 2)),
      focusedBorder:
          OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16.0)), borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 3)),
      contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
    );
  }
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
