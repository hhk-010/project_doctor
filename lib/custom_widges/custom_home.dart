import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeAlignWidgets extends StatelessWidget {
  final AlignmentGeometry alignment;
  final EdgeInsets padding;
  final Function onTap;
  final bool isIcon;
  final double width;
  final double height;
  final String asset;
  final double iconSize;
  final Widget icon;

  const HomeAlignWidgets(
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

Future getDialog(context, String title, String dialogContext) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
        title: Text(
          title,
          style: CustomStyle.getTitleBlack(context),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                dialogContext,
                style: CustomStyle.getSubtitle(context).copyWith(fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              LocaleKeys.view_buttons_ok.tr(),
              style: CustomStyle.getTitle(context).copyWith(color: LightPalette.gradientTop),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}

class CustomFooter extends StatelessWidget {
  final Widget child;

  const CustomFooter({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: getDeviceType(context, 250, 300, 400, 500),
        height: getDeviceType(context, 35, 40, 50, 60),
        child: Column(
          children: [
            Divider(
              color: Colors.grey,
              thickness: 2,
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.5),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
