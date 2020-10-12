import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/matching_algorithm/final_score.dart';
import 'package:project_doctor/pages/patient_pages/patient_result_map.dart';
import 'package:project_doctor/pages/patient_pages/patient_risk_factors.dart';
import 'package:project_doctor/services/database.dart';
import 'package:provider/provider.dart';

class PatientResult extends StatefulWidget {
  @override
  _PatientResultState createState() => _PatientResultState();
}

class _PatientResultState extends State<PatientResult> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().doctorDataProfileStream,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            'Search Result',
            style: TextStyle(fontSize: 25.0),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: TheProfile(),
      ),
    );
  }
}

class TheProfile extends StatefulWidget {
  @override
  _TheProfileState createState() => _TheProfileState();
}

class _TheProfileState extends State<TheProfile> {
  @override
  Widget build(BuildContext context) {
    final doctorListProvider = Provider.of<QuerySnapshot>(context);
    String _name = '';
    String _speciality = '';
    String _number = '';
    String _province = '';
    double _lat = 0.0;
    double _lng = 0.0;
    double distance = 0.0;
    double sum = 0.0;
    double result = 0.0;
    if (doctorListProvider != null) {
      for (var docu in doctorListProvider.docs) {
        sum = ((docu.data()['lat'] - MyVariables.lat) *
                (docu.data()['lat'] - MyVariables.lat)) +
            ((docu.data()['lng'] - MyVariables.long) *
                (docu.data()['lng'] - MyVariables.long));
        result = sqrt(sum);
        if (result > distance &&
            (FinalScore.speciality == docu.data()['speciality'] ||
                FinalScore.speciality2 == docu.data()['speciality'])) {
          setState(() {
            distance = result;
          });
        }
      }
      for (var docu in doctorListProvider.docs) {
        sum = ((docu.data()['lat'] - MyVariables.lat) *
                (docu.data()['lat'] - MyVariables.lat)) +
            ((docu.data()['lng'] - MyVariables.long) *
                (docu.data()['lng'] - MyVariables.long));
        result = sqrt(sum);

        if (result <= distance &&
            (FinalScore.speciality == docu.data()['speciality'] ||
                FinalScore.speciality2 == docu.data()['speciality'])) {
          setState(() {
            distance = result;
            _name = docu.data()['name'];
            _speciality = docu.data()['speciality'];
            _number = docu.data()['phoneNumber'];
            _province = docu.data()['province'];
            _lat = docu.data()['lat'];
            _lng = docu.data()['lng'];
          });
        }
      }

      return Container(
        decoration: boxDecorationPatient,
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
        child: Column(
          children: [
            Center(
              child: Text(_name),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(_speciality),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(_province),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(_number),
            ),
            SizedBox(
              height: 200,
            ),
            RaisedButton(
              child: Text('View Doctor Location on Google Map'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PatientResultMap(
                          lat: _lat,
                          lng: _lng,
                        )));
              },
            ),
          ],
        ),
      );
    }
  }
}
