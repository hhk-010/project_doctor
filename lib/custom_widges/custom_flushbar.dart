import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

getFlushbar(BuildContext context, String message, RoundedLoadingButtonController controller) {
  Flushbar(
    title: LocaleKeys.view_snack_error_error_title.tr(),
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
  )..show(context);
  controller.error();
  Timer(Duration(seconds: 2), () {
    controller.reset();
  });
}

void getSuccess(RoundedLoadingButtonController controller) {
  controller.success();
  Timer(Duration(seconds: 2), () {
    controller.reset();
  });
}
