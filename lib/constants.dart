import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// color Pallete
Color homeSearchButton = Color(0xFFE63946);
Color homeRegisterButton = Color(0xFFBEB9B9);

// responsive layout according to screensize
double getDeviceType(context, double small, double mobile, double tablet, double desktop) {
  var deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth < 350) return small;
  if (deviceWidth > 350 && deviceWidth < 600) return mobile;
  if (deviceWidth > 600 && deviceWidth < 950) return tablet;
  if (deviceWidth > 950) return desktop;
  return null;
}

String getLocale(BuildContext context) {
  return EasyLocalization.of(context).locale.toString();
}
