import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/constants/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeButtonComponent extends StatelessWidget {
  final Function onPressed;
  final String title;
  final String icon;
  final Color color;

  const HomeButtonComponent({
    Key key,
    this.onPressed,
    this.title,
    this.icon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getDeviceType(context, 50, 70, 90, 120),
      width: getDeviceType(context, 250, 300, 400, 500),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          primary: Colors.white,
          backgroundColor: color,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.toUpperCase(),
              style: CStyle.buttonText,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage(
                  (icon),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeAlignComponent extends StatelessWidget {
  final AlignmentGeometry alignment;
  final EdgeInsets padding;
  final Function onTap;
  final bool isIcon;
  final double width;
  final double height;
  final String asset;
  final double iconSize;
  final Widget icon;

  const HomeAlignComponent(
      {Key key, this.alignment, this.padding, this.onTap, this.width, this.height, this.icon, this.asset, this.iconSize, this.isIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: padding,
        child: isIcon
            ? IconButton(
                onPressed: onTap,
                icon: icon,
                iconSize: iconSize,
              )
            : Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(asset), fit: BoxFit.fill),
                ),
              ),
      ),
    );
  }
}

class SupportButtons extends StatelessWidget {
  final String title;
  final String dialogContext;

  const SupportButtons({
    Key key,
    this.title,
    this.dialogContext,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 200,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          primary: Colors.white,
          backgroundColor: Colors.deepOrange,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                title: Text(
                  title,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        dialogContext,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      LocaleKeys.app_buttons_ok.tr(),
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            },
          );
        },
        child: Text(
          title,
        ),
      ),
    );
  }
}
