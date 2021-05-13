import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomProfileColumn extends StatelessWidget {
  final String title;
  final String content;

  const CustomProfileColumn({Key key, this.title, this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getDeviceType(context, 65, 75, 90, 110),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CustomStyle.getFooter(context).copyWith(color: Colors.red),
          ),
          Text(
            content,
            style: CustomStyle.getTitleBlack(context),
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
        ],
      ),
    );
  }
}

class CustomProfileColumn2 extends StatelessWidget {
  final String title;
  final String content;

  const CustomProfileColumn2({Key key, this.title, this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getDeviceType(context, 75, 95, 120, 130),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CustomStyle.getFooter(context).copyWith(color: Colors.red),
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              content,
              style: CustomStyle.getFooter(context),
            ),
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
        ],
      ),
    );
  }
}

class CustomProfilePhoneCalling extends StatelessWidget {
  final String title;
  final String content;

  const CustomProfilePhoneCalling({Key key, this.title, this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getDeviceType(context, 65, 75, 90, 110),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CustomStyle.getFooter(context).copyWith(color: Colors.red),
          ),
          GestureDetector(
            onTap: () => _makePhoneCall('tel:$content'),
            child: Row(
              children: [
                Icon(
                  Icons.phone,
                  color: Colors.deepOrange,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  content,
                  style: CustomStyle.getTitleBlack(context),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
        ],
      ),
    );
  }
}

Future<void> _makePhoneCall(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
