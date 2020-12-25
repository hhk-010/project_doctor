import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/sizing_information.dart';
import 'package:url_launcher/url_launcher.dart';

class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  // Future<void> _launchEmail(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // var lang = Localizations.localeOf(context).languageCode;
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        double appBar;
        double appBarHeight;
        double containerHeight;
        double containerWidth;
        double title;
        double subTitle;
        double footer;
        double imageHeight;
        double buttonHeight;
        double buttonWidth;
        // double avatarRadius;
        // double techIconSize;

        if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
          appBar = 25;
          appBarHeight = 50;
          containerHeight = displayHeight(context) * 0.85;
          containerWidth = displayWidth(context) * 0.85;
          title = displayWidth(context) * 0.05;
          subTitle = displayWidth(context) * 0.035;
          footer = displayWidth(context) * 0.03;
          imageHeight = 200;
          buttonHeight = displayHeight(context) * 0.05;
          buttonWidth = displayWidth(context) * 0.6;
          // avatarRadius = 25;
          // techIconSize = 30;
        } else {
          appBar = displayHeight(context) * 0.045;
          appBarHeight = 75;
          containerHeight = displayHeight(context) * 0.85;
          containerWidth = displayWidth(context) * 0.65;
          title = displayWidth(context) * 0.04;
          subTitle = displayWidth(context) * 0.03;
          footer = displayWidth(context) * 0.025;
          imageHeight = 300;
          buttonHeight = displayHeight(context) * 0.045;
          buttonWidth = displayWidth(context) * 0.4;
          // avatarRadius = 50;
          // techIconSize = 50;
        }
        TextStyle dialoge = TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: subTitle,
        );

        return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(appBarHeight),
            child: AppBar(
              backgroundColor: Colors.deepOrange,
              title: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  AppLocalizations.of(context).translate('support'),
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
                          height: 50,
                        ),
                        Align(
                          child: Container(
                            height: buttonHeight,
                            width: buttonWidth,
                            child: FlatButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                      title: Text(
                                        AppLocalizations.of(context).translate('about_us'),
                                        style: TextStyle(fontSize: title),
                                        textAlign: TextAlign.center,
                                      ),
                                      content: Text(
                                        AppLocalizations.of(context).translate('introduction'),
                                        style: dialoge,
                                        textAlign: TextAlign.justify,
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            AppLocalizations.of(context).translate('ok'),
                                            style: TextStyle(fontSize: subTitle),
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
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  AppLocalizations.of(context).translate('about_us'),
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: title),
                                ),
                              ),
                              color: Colors.deepOrange,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Align(
                          child: Container(
                            height: buttonHeight,
                            width: buttonWidth,
                            child: FlatButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                      title: Text(
                                        AppLocalizations.of(context).translate('privacy_policy'),
                                        style: TextStyle(fontSize: title),
                                        textAlign: TextAlign.center,
                                      ),
                                      content: SingleChildScrollView(
                                          child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context).translate('privacyPolicy'),
                                            style: dialoge,
                                            textAlign: TextAlign.justify,
                                          ),
                                        ],
                                      )),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            AppLocalizations.of(context).translate('ok'),
                                            style: TextStyle(fontSize: subTitle),
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
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  AppLocalizations.of(context).translate('privacy_policy'),
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: title),
                                ),
                              ),
                              color: Colors.deepOrange,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 25,
                        ),
                        Align(
                          child: Container(
                            height: buttonHeight,
                            width: buttonWidth,
                            child: FlatButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                      title: Text(
                                        AppLocalizations.of(context).translate('terms_conditions'),
                                        style: TextStyle(fontSize: title),
                                        textAlign: TextAlign.center,
                                      ),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context).translate('terms&conditions'),
                                              style: dialoge,
                                              textAlign: TextAlign.justify,
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            AppLocalizations.of(context).translate('ok'),
                                            style: TextStyle(fontSize: subTitle),
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
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  AppLocalizations.of(context).translate('terms_conditions'),
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: title),
                                ),
                              ),
                              color: Colors.deepOrange,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Align(
                          child: Container(
                            height: buttonHeight,
                            width: buttonWidth,
                            child: FlatButton(
                              onPressed: () async {
                                const url = 'https://sites.google.com/view/cura-mobile/home';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could Not Launch $url';
                                }
                              },
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  AppLocalizations.of(context).translate('website'),
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: title),
                                ),
                              ),
                              color: Colors.deepOrange,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        /*Center(
                          child: Text(
                            AppLocalizations.of(context).translate('contact_us'),
                            style: TextStyle(fontSize: title, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),*/

                        /*Directionality(
                          textDirection: TextDirection.ltr,
                          child: Container(
                            decoration: boxDecoration,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.mail,
                                        color: Colors.deepOrange,
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      GestureDetector(
                                        onTap: () => setState(() {
                                          _launchEmail('mailto:ahmedkhaganikhagani@gmail.com?subject=News&body=New%20plugin');
                                        }),
                                        child: Text(
                                          'ahmedkhaganikhagani@gmail.com',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(fontSize: subTitle, fontWeight: FontWeight.normal, fontFamily: 'Helvatica'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                    child: Divider(
                                      color: Colors.grey,
                                      thickness: 2,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.mail,
                                        color: Colors.deepOrange,
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      GestureDetector(
                                        onTap: () => setState(() {
                                          _launchEmail('mailto:hhk.01831@gmail.com?subject=News&body=New%20plugin');
                                        }),
                                        child: Text(
                                          'hhk.01831@gmail.com',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(fontSize: subTitle, fontWeight: FontWeight.normal, fontFamily: 'Helvatica'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),*/
                        // Center(
                        //   child: Text(
                        //     'Developers',
                        //     style: TextStyle(
                        //         fontSize: title, fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Container(
                        //   decoration: boxDecoration,
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Column(
                        //       children: [
                        //         ListTile(
                        //           leading: CircleAvatar(
                        //             backgroundColor: Colors.grey[200],
                        //             radius: avatarRadius,
                        //             backgroundImage:
                        //                 AssetImage('assets/images/ahmed.png'),
                        //           ),
                        //           title: Text(
                        //             'A K',
                        //             style: TextStyle(
                        //                 fontWeight: FontWeight.bold,
                        //                 fontSize: title),
                        //           ),
                        //           subtitle: RichText(
                        //             text: TextSpan(
                        //               style: TextStyle(
                        //                   fontSize: subTitle,
                        //                   fontWeight: FontWeight.bold,
                        //                   color: Colors.indigoAccent,
                        //                   fontFamily: lang == 'ar'
                        //                       ? 'noto_arabic'
                        //                       : 'Helvetica'),
                        //               children: <TextSpan>[
                        //                 TextSpan(
                        //                     text: 'M.B.CH.B\n',
                        //                     style: TextStyle(
                        //                         color: Colors.redAccent)),
                        //                 TextSpan(
                        //                     text: 'Programmer',
                        //                     style: TextStyle()),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //         Divider(
                        //           color: Colors.grey,
                        //           thickness: 2,
                        //           indent: 0,
                        //           endIndent: 0,
                        //         ),
                        //         ListTile(
                        //           leading: CircleAvatar(
                        //             backgroundColor: Colors.grey[200],
                        //             radius: avatarRadius,
                        //             backgroundImage:
                        //                 AssetImage('assets/images/hhk.png'),
                        //           ),
                        //           title: Text(
                        //             'H H K',
                        //             style: TextStyle(
                        //                 fontWeight: FontWeight.bold,
                        //                 fontSize: title),
                        //           ),
                        //           subtitle: RichText(
                        //             text: TextSpan(
                        //               style: TextStyle(
                        //                   fontSize: subTitle,
                        //                   fontWeight: FontWeight.bold,
                        //                   color: Colors.indigoAccent,
                        //                   fontFamily: lang == 'ar'
                        //                       ? 'noto_arabic'
                        //                       : 'Helvetica'),
                        //               children: <TextSpan>[
                        //                 TextSpan(
                        //                     text: 'M.B.CH.B\n',
                        //                     style: TextStyle(
                        //                         color: Colors.redAccent)),
                        //                 TextSpan(
                        //                     text: 'Programmer',
                        //                     style: TextStyle()),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        // Center(
                        //   child: Text(
                        //     'This app is developed using the following technologies:',
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //         fontSize: subTitle,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Container(
                        //   decoration: boxDecoration,
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         SizedBox(
                        //           height: techIconSize,
                        //           width: techIconSize,
                        //           child: Image(
                        //             image:
                        //                 AssetImage('assets/images/windows.png'),
                        //           ),
                        //         ),
                        //         SizedBox(
                        //           height: techIconSize,
                        //           width: techIconSize,
                        //           child: Image(
                        //             image:
                        //                 AssetImage('assets/images/apple.png'),
                        //           ),
                        //         ),
                        //         SizedBox(
                        //           height: techIconSize,
                        //           width: techIconSize,
                        //           child: Image(
                        //             image:
                        //                 AssetImage('assets/images/flutter.png'),
                        //           ),
                        //         ),
                        //         SizedBox(
                        //           height: techIconSize,
                        //           width: techIconSize,
                        //           child: Image(
                        //             image: AssetImage('assets/images/dart.png'),
                        //           ),
                        //         ),
                        //         SizedBox(
                        //           height: techIconSize,
                        //           width: techIconSize,
                        //           child: Image(
                        //             image:
                        //                 AssetImage('assets/images/VScode.png'),
                        //           ),
                        //         ),
                        //         SizedBox(
                        //           height: techIconSize,
                        //           width: techIconSize,
                        //           child: Image(
                        //             image: AssetImage(
                        //                 'assets/images/firebase.png'),
                        //           ),
                        //         ),
                        //         SizedBox(
                        //           height: techIconSize,
                        //           width: techIconSize,
                        //           child: Image(
                        //             image: AssetImage(
                        //                 'assets/images/google_map.png'),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Column(
                      children: [
                        Divider(
                          thickness: 2,
                          color: Colors.grey,
                        ),
                        Text(
                          '© 2020 Cura Team. All Rights Reserved.',
                          style: TextStyle(fontSize: footer, fontFamily: 'HelveticaNow-Regular'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
