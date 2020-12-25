import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/matching_algorithm/final_score.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/sizing_information.dart';

class SpecialityResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      double appBarTitle;
      double appBarHeight;
      double containerHeight;
      double containerWidth;
      double buttonHeight;
      double buttonWidth;
      double title;
      double subTitle;
      double imageHeight;
      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
        appBarTitle = 25;
        appBarHeight = 50;
        containerHeight = displayHeight(context) * 0.75;
        containerWidth = displayWidth(context) * 0.85;
        title = displayWidth(context) * 0.055;
        subTitle = displayWidth(context) * 0.045;
        buttonHeight = displayHeight(context) * 0.05;
        buttonWidth = displayWidth(context) * 0.7;
        imageHeight = displayHeight(context) * 0.2;
      } else {
        appBarTitle = displayHeight(context) * 0.04;
        appBarHeight = 75;
        containerHeight = displayHeight(context) * 0.7;
        containerWidth = displayWidth(context) * 0.5;
        title = displayWidth(context) * 0.04;
        subTitle = displayWidth(context) * 0.03;
        buttonHeight = displayHeight(context) * 0.045;
        buttonWidth = displayWidth(context) * 0.4;
        imageHeight = displayHeight(context) * 0.2;
      }
      return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: AppBar(
            backgroundColor: Colors.deepOrange,
            title: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                AppLocalizations.of(context).translate('speciality_result'),
                style: TextStyle(fontSize: appBarTitle, fontWeight: FontWeight.bold),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: boxDecoration,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: imageHeight,
                        child: Image(
                          image: AssetImage('assets/images/speciality.png'),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      AutoSizeText(
                        AppLocalizations.of(context).translate('result_speciality'),
                        maxLines: 2,
                        style: TextStyle(fontSize: subTitle, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: ListTile(
                          leading: Icon(
                            Icons.person_add,
                            size: 40,
                            color: Colors.deepOrangeAccent,
                          ),
                          title: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              //FinalScore.speciality,
                              AppLocalizations.of(context).translate(FinalScore.speciality) +
                                  AppLocalizations.of(context).translate(FinalScore.or) +
                                  AppLocalizations.of(context).translate(FinalScore.speciality2),
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: title),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: buttonHeight,
                  width: buttonWidth,
                  child: RaisedButton.icon(
                    color: Colors.deepOrange,
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/patient_get_location');
                    },
                    label: Text(
                      AppLocalizations.of(context).translate('next'),
                      style: TextStyle(color: Colors.white, fontSize: subTitle, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
