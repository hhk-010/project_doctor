import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/matching_algorithm/final_score.dart';
import 'package:project_doctor/services/app_localizations.dart';

class SpecialityResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            AppLocalizations.of(context).translate('speciality_result'),
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 75, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: boxDecorationPatient,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 8),
              child: Column(
                children: [
                  AutoSizeText(
                    AppLocalizations.of(context).translate('result_speciality'),
                    maxLines: 2,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 2,
                    indent: 30,
                    endIndent: 30,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepOrange,
                      radius: 30,
                      backgroundImage:
                          AssetImage('assets/images/speciality.png'),
                    ),
                    title: Text(
                      //FinalScore.speciality,
                      AppLocalizations.of(context)
                              .translate(FinalScore.speciality) +
                          AppLocalizations.of(context)
                              .translate(FinalScore.Or) +
                          AppLocalizations.of(context)
                              .translate(FinalScore.speciality2),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 45,
              width: double.maxFinite,
              child: RaisedButton.icon(
                color: Colors.deepOrange,
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                onPressed: () {
                  Navigator.pushNamed(context, '/patient_get_location');
                },
                label: Text(
                  AppLocalizations.of(context).translate('next'),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
