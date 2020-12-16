import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/sizing_information.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUS extends StatefulWidget {
  @override
  _AboutUSState createState() => _AboutUSState();
}

class _AboutUSState extends State<AboutUS> {
  Future<void> _launchEmail(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String aboutUs =
      "Cura mobile app is developed by two certified medical practitioners trying to approximate distance and simplifying  the process of choosing the right medical specialty for the patient complaint.";
  String privacyPolicy1 = "";
  String privacyPolicy2 = "";
  String termsConditions1 =
      "By downloading or using the app, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. You’re not allowed to copy, or modify the app, any part of the app, or our trademarks in any way. You’re not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages, or make derivative versions. The app itself, and all the trade marks, copyright, database rights and other intellectual property rights related to it, still belong to Cura Mobile.\n Cura team  is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you’re paying for.\n The Cura app stores and processes personal data that you have provided to us, in order to provide our Service. It’s your responsibility to keep your phone and access to the app secure. We therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone’s security features and it could mean that the Cura app won’t work properly or at all.\n You should be aware that there are certain things that Cura mobile will not take responsibility for. Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi, or provided by your mobile network provider, but Cura mobile  cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, and you don’t have any of your data allowance left.";

  String termsConditions2 =
      "If you’re using the app outside of an area with Wi-Fi, you should remember that your terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third party charges. In using the app, you’re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you’re using the app, please be aware that we assume that you have received permission from the bill payer for using the app.\n Along the same lines, Cura cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged – if it runs out of battery and you can’t turn it on to avail the Service, Cura mobile  cannot accept responsibility.\n With respect to Cura mobile responsibility for your use of the app, when you’re using the app, it’s important to bear in mind that although we endeavour to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. Cura mobile accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app.\n At some point, we may wish to update the app. The app is currently available on Android & iOS – the requirements for both systems(and for any additional systems we decide to extend the availability of the app to) may change, and you’ll need to download the updates if you want to keep using the app. Cura mobile does not promise that it will always update the app so that it is relevant to you and/or works with the Android & iOS version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device.\n We may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Terms and Conditions on this page.";

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
          title = displayWidth(context) * 0.045;
          subTitle = displayWidth(context) * 0.03;
          footer = displayWidth(context) * 0.03;
          imageHeight = 300;
          buttonHeight = displayHeight(context) * 0.04;
          buttonWidth = displayWidth(context) * 0.4;
          // avatarRadius = 50;
          // techIconSize = 50;
        }
        TextStyle dialoge = TextStyle(
          fontFamily: 'HelveticaNow-Regular',
          fontWeight: FontWeight.normal,
          fontSize: subTitle,
        );

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
                      child: Column(
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
                          Container(
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
                                        'About us',
                                        textAlign: TextAlign.center,
                                      ),
                                      content: Text(
                                        aboutUs,
                                        style: dialoge,
                                        textAlign: TextAlign.justify,
                                        textDirection: TextDirection.ltr,
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('OK'),
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
                                'About us',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: title),
                              ),
                              color: Colors.deepOrange,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
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
                                        'Privacy Policy',
                                        textAlign: TextAlign.center,
                                      ),
                                      content: SingleChildScrollView(
                                          child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            privacyPolicy1,
                                            style: dialoge,
                                            textDirection: TextDirection.ltr,
                                            textAlign: TextAlign.justify,
                                          ),
                                          Text(
                                            privacyPolicy2,
                                            style: dialoge,
                                            textDirection: TextDirection.ltr,
                                            textAlign: TextAlign.justify,
                                          ),
                                        ],
                                      )),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('OK'),
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
                                'Privacy Policy',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: title),
                              ),
                              color: Colors.deepOrange,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                            ),
                          ),

                          SizedBox(
                            height: 25,
                          ),
                          Container(
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
                                        'Terms & Conditions',
                                        textAlign: TextAlign.center,
                                      ),
                                      content: SingleChildScrollView(
                                          child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            termsConditions1,
                                            style: dialoge,
                                            textDirection: TextDirection.ltr,
                                            textAlign: TextAlign.justify,
                                          ),
                                          Text(
                                            termsConditions2,
                                            style: dialoge,
                                            textDirection: TextDirection.ltr,
                                            textAlign: TextAlign.justify,
                                          ),
                                        ],
                                      )),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('OK'),
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
                                'Terms & Conditions',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: title),
                              ),
                              color: Colors.deepOrange,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
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
                              child: Text(
                                'Website',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: title),
                              ),
                              color: Colors.deepOrange,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: Text(
                              'Contact us',
                              style: TextStyle(fontSize: title, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          Container(
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
                                          _launchEmail('mailto:ahmedkhagani93@gmail.com?subject=News&body=New%20plugin');
                                        }),
                                        child: Text(
                                          'ahmedkhagani93@gmail.com',
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
                    Column(
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
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
