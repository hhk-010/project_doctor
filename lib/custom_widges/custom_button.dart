import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';

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

class BaseIconButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final IconData icon;
  const BaseIconButton({
    Key key,
    this.onPressed,
    this.title,
    this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: getDeviceType(context, 30, 50, 50, 60),
        width: getDeviceType(context, 100, 200, 200, 250),
        child: TextButton.icon(
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: LightPalette.button,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          onPressed: onPressed,
          label: Text(
            title,
            style: CStyle.getTitle(context),
          ),
        ),
      ),
    );
  }
}
