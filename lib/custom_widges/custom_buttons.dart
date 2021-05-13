import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class BaseButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  const BaseButton({
    Key key,
    this.title,
    this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getDeviceType(context, 40, 50, 60, 75),
      width: getDeviceType(context, 150, 200, 250, 300),
      child: TextButton(
        style: TextButton.styleFrom(
          enableFeedback: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          primary: Colors.white,
          backgroundColor: LightPalette.button,
        ),
        onPressed: onPressed,
        child: Text(title, style: CustomStyle.getTitle(context)),
      ),
    );
  }
}

class SearchWrapperButtons extends StatelessWidget {
  final String title;
  final Function onPressed;

  const SearchWrapperButtons({
    Key key,
    this.title,
    this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getDeviceType(context, 45, 60, 70, 80),
      width: getDeviceType(context, 210, 260, 310, 350),
      child: TextButton(
        style: TextButton.styleFrom(
          enableFeedback: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          primary: Colors.white,
          backgroundColor: LightPalette.button,
        ),
        onPressed: onPressed,
        child: FittedBox(fit: BoxFit.fitWidth, child: Text(title, style: CustomStyle.getTitle(context))),
      ),
    );
  }
}

class CustomLoadingButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final RoundedLoadingButtonController controller;

  const CustomLoadingButton({Key key, this.title, this.onPressed, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      elevation: 0,
      height: getDeviceType(context, 40, 50, 60, 70),
      width: getDeviceType(context, 150, 200, 300, 400),
      successColor: Colors.green,
      color: LightPalette.button,
      controller: controller,
      onPressed: onPressed,
      child: Text(
        title,
        style: CustomStyle.getTitle(context),
      ),
    );
  }
}
