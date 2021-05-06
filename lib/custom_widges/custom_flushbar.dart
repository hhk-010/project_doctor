import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';

Flushbar getFlushbar(BuildContext context, String title, String message) {
  return Flushbar(
    title: title,
    message: message,
    forwardAnimationCurve: Curves.decelerate,
    reverseAnimationCurve: Curves.easeOut,
    borderRadius: BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16)),
    duration: Duration(seconds: 2),
    backgroundGradient: LinearGradient(colors: [
      getColor(context, LightPalette.gradientTop, DarkPalette.gradientTop),
      getColor(context, LightPalette.gradientBottom, DarkPalette.gradientBottom),
    ]),
    shouldIconPulse: false,
    icon: Icon(
      Icons.error,
      size: 30,
      color: getColor(context, Colors.white, Colors.red),
    ),
  );
}
