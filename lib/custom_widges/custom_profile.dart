import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';

class CustomProfileColumn extends StatelessWidget {
  final String title;
  final String content;

  const CustomProfileColumn({Key key, this.title, this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CStyle.getFooter(context).copyWith(color: Colors.red),
          ),
          Text(
            content,
            style: CStyle.getTitleBlack(context),
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
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CStyle.getFooter(context).copyWith(color: Colors.red),
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              content,
              style: CStyle.getFooter(context),
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
