import 'package:flutter/material.dart';
import 'package:project_doctor/constants.dart';

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
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          primary: color, // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: getDeviceType(context, 14, 16, 30, 40),
              ),
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

  const HomeAlignComponent({Key key, this.alignment, this.padding, this.onTap, this.width, this.height, this.icon, this.asset, this.iconSize, this.isIcon})
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
