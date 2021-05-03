import 'package:flutter/material.dart';
import 'package:project_doctor/constants/device_size.dart';

class HomeButton extends StatelessWidget {
  final Function onpressed;
  final String title;
  final String icon;
  final Color color;

  const HomeButton({
    Key key,
    this.onpressed,
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
        onPressed: onpressed,
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
