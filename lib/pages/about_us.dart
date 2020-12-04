import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/sizing_information.dart';

class AboutUS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      double appBar;
      double appBarHeight;
      double containerHeight;
      double containerWidth;
      double title;
      double subTitle;
      double footer;
      double imageHeight;
      double avatarRadius;
      double techIconSize;

      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
        appBar =  25;
        appBarHeight = 50;
        containerHeight = displayHeight(context) * 0.85;
        containerWidth = displayWidth(context) * 0.85;
        title = displayWidth(context) * 0.05;
        subTitle = displayWidth(context) * 0.035;
        footer = displayWidth(context) * 0.03;
        imageHeight = 200;
        avatarRadius = 25;
        techIconSize = 30;
      } else {
        appBar = displayHeight(context) * 0.045;
        appBarHeight = 75;
        containerHeight = displayHeight(context) * 0.85;
        containerWidth = displayWidth(context) * 0.65;
        title = displayWidth(context) * 0.045;
        subTitle = displayWidth(context) * 0.03;
        footer = displayWidth(context) * 0.03;
        imageHeight = 300;
        avatarRadius = 50;
        techIconSize = 50;
      }

      return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(appBarHeight),
            child: AppBar(
              backgroundColor: Colors.deepOrange,
              title: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  AppLocalizations.of(context).translate('about_us'),
                  style: TextStyle(fontSize: appBar, fontWeight: FontWeight.bold),
                ),
              ),
              centerTitle: true,
              elevation: 0,
            ),
          ),
          body: Center(
            child: Container(
              height: containerHeight,
              width: containerWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: imageHeight,
                          child: Image(
                            image: AssetImage('assets/images/about_us.png'),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            'Purpose',
                            style: TextStyle(fontSize: title, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: boxDecoration,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "This app is made with the purpose of simplifying process of choosing the right doctor for the patient's Complain.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: subTitle, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            'Developers',
                            style: TextStyle(fontSize: title, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: boxDecoration,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    radius: avatarRadius,
                                    backgroundImage: AssetImage('assets/images/ahmed.png'),
                                  ),
                                  title: Text(
                                    'A K',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: title),
                                  ),
                                  subtitle: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                          fontSize: subTitle,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigoAccent,
                                          fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
                                      children: <TextSpan>[
                                        TextSpan(text: 'M.B.CH.B\n', style: TextStyle(color: Colors.redAccent)),
                                        TextSpan(text: 'Programmer', style: TextStyle()),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                  indent: 0,
                                  endIndent: 0,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    radius: avatarRadius,
                                    backgroundImage: AssetImage('assets/images/hhk.png'),
                                  ),
                                  title: Text(
                                    'H H K',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: title),
                                  ),
                                  subtitle: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                          fontSize: subTitle,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigoAccent,
                                          fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
                                      children: <TextSpan>[
                                        TextSpan(text: 'M.B.CH.B\n', style: TextStyle(color: Colors.redAccent)),
                                        TextSpan(text: 'Programmer', style: TextStyle()),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            'This app is developed using the following technologies:',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: subTitle, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: boxDecoration,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: techIconSize,
                                  width: techIconSize,
                                  child: Image(
                                    image: AssetImage('assets/images/windows.png'),
                                  ),
                                ),
                                SizedBox(
                                  height: techIconSize,
                                  width: techIconSize,
                                  child: Image(
                                    image: AssetImage('assets/images/apple.png'),
                                  ),
                                ),
                                SizedBox(
                                  height: techIconSize,
                                  width: techIconSize,
                                  child: Image(
                                    image: AssetImage('assets/images/flutter.png'),
                                  ),
                                ),
                                SizedBox(
                                  height: techIconSize,
                                  width: techIconSize,
                                  child: Image(
                                    image: AssetImage('assets/images/dart.png'),
                                  ),
                                ),
                                SizedBox(
                                  height: techIconSize,
                                  width: techIconSize,
                                  child: Image(
                                    image: AssetImage('assets/images/VScode.png'),
                                  ),
                                ),
                                SizedBox(
                                  height: techIconSize,
                                  width: techIconSize,
                                  child: Image(
                                    image: AssetImage('assets/images/firebase.png'),
                                  ),
                                ),
                                SizedBox(
                                  height: techIconSize,
                                  width: techIconSize,
                                  child: Image(
                                    image: AssetImage('assets/images/google_map.png'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Divider(
                        thickness: 2,
                        color: Colors.grey,
                      ),
                      Text(
                        '© 2020 Cura Team. All Rights Reserved.',
                        style: TextStyle(fontSize: footer),
                      ),
                      
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
