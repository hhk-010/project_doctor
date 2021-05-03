import 'package:flutter/material.dart';

double getDeviceType(
    context, double small, double mobile, double tablet, double desktop) {
  var deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth < 350) return small;
  if (deviceWidth > 350 && deviceWidth < 600) return mobile;
  if (deviceWidth > 600 && deviceWidth < 950) return tablet;
  if (deviceWidth > 950) return desktop;
  return null;
}
