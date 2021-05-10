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
      height: getDeviceType(context, 30, 50, 50, 60),
      width: getDeviceType(context, 100, 200, 200, 250),
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
        child: Text(title, style: CStyle.getTitle(context)),
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
      height: getDeviceType(context, 30, 60, 50, 60),
      width: getDeviceType(context, 100, 300, 200, 250),
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
        child: Text(title, style: CStyle.getTitle(context)),
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
      height: 50,
      width: 200,
      successColor: Colors.green,
      color: LightPalette.button,
      controller: controller,
      onPressed: onPressed,
      child: Text(
        title,
        style: CStyle.getTitle(context),
      ),
    );
  }
}
