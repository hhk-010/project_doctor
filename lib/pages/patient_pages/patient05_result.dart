import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/matching_algorithm/final_score.dart';
import 'package:project_doctor/pages/patient_pages/patient03_get_location.dart';
import 'package:project_doctor/pages/patient_pages/patient06_result_map.dart';
import 'package:project_doctor/services/database.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

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
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: ResultDoctorProfile(),
      ),
    );
  }
}

class ResultDoctorProfile extends StatefulWidget {
  @override
  _ResultDoctorProfileState createState() => _ResultDoctorProfileState();
}

class _ResultDoctorProfileState extends State<ResultDoctorProfile> {
  String _name = '';
  String _speciality = '';
  String _number = '';
  String _province = '';
  double _lat = 0.0;
  double _lng = 0.0;
  double distance = 0.0;
  double sum = 0.0;
  double result = 0.0;
  double realdistance = 0.0;
  String realdist = '';
  int dotindex = 0;
  String realnearby = '';

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  String _currentAddress = '';
  _getAddressFromLatLng() async {
    List<Placemark> p = await geolocator.placemarkFromCoordinates(_lat, _lng);
    Placemark place = p[0];
    setState(() {
      _currentAddress = "${place.locality}, ${place.country}";
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = TextStyle(
        fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold);
    final doctorListProvider = Provider.of<QuerySnapshot>(context);
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
            realdistance = distance * 100;
            realdist = realdistance.toString();
            dotindex = realdist.indexOf('.') + 3;
            realnearby = realdist.substring(0, dotindex);
            _getAddressFromLatLng();
          });
        }
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 75, horizontal: 40),
      child: Container(
        height: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: boxDecorationPatient,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.deepOrange,
                        radius: 75,
                        backgroundImage: AssetImage('assets/images/doctor.png'),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        _name,
                        style: _textStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        _speciality,
                        style: _textStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        _number,
                        style: _textStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        _currentAddress,
                        style: _textStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child:
                  Text('Distance to the Doctor is about ' + realnearby + ' Km'),
            ),
            Spacer(
              flex: 5,
            ),
            RaisedButton.icon(
              color: Colors.deepOrange,
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PatientResultMap(
                          lat: _lat,
                          lng: _lng,
                        )));
              },
              label: Text(
                'View Doctor Location',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
