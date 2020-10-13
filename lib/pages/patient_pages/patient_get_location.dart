import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/pages/patient_pages/patient_map.dart';
import 'package:project_doctor/matching_algorithm/final_score.dart';
import 'package:geolocator/geolocator.dart';

class PatientGetLocation extends StatefulWidget {
  @override
  _PatientGetLocationState createState() => _PatientGetLocationState();
}

class _PatientGetLocationState extends State<PatientGetLocation> {
  String region = '';
  List<DropdownMenuItem<String>> regions = List();
  final regionsa = {
    '1': 'Baghdad',
    '2': 'Northern Region',
    '3': 'Southern Region',
    '4': 'Western Region'
  };

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Your Location',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 40),
        child: Column(
          children: [
            Container(
              decoration: boxDecorationPatient,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  Text(
                    'Province',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 2,
                    indent: 30,
                    endIndent: 30,
                  ),
                  DropdownButton(
                    hint: Text('Select your Province'),
                    isExpanded: true,
                    items: [
                      DropdownMenuItem<String>(
                        value: "Baghdad",
                        child: Text("Baghdad"),
                      ),
                      DropdownMenuItem<String>(
                        value: "Northern Region",
                        child: Text("Northern Region"),
                      ),
                      DropdownMenuItem<String>(
                        value: "Southern Region",
                        child: Text("Southern Region"),
                      ),
                      DropdownMenuItem<String>(
                        value: "Western Region",
                        child: Text("Western Region"),
                      ),
                    ],
                    onChanged: (_value) {
                      setState(() {
                        region = _value;
                      });
                      print(region);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              decoration: boxDecorationPatient,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'To Continue, You Must Specify your current location through either:',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
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
                  Container(
                    width: double.maxFinite,
                    child: RaisedButton.icon(
                      color: Colors.deepOrange,
                      icon: Icon(
                        Icons.map,
                        color: Colors.white,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      onPressed: () async {
                        _getCurrentLocation();
                        setState(() {
                          MyVariables.speciality = FinalScore.speciality;
                          MyVariables.province = region;
                          MyVariables.lat = _currentPosition.latitude;
                          MyVariables.long = _currentPosition.longitude;
                        });
                        Navigator.pushNamed(context, '/patient_result');
                      },
                      label: Text(
                        'Auto Device Location',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'or',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    child: RaisedButton.icon(
                      color: Colors.deepOrange,
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      onPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PatientMap(
                                  speciality: FinalScore.speciality,
                                  province: region,
                                )));
                      },
                      label: Text(
                        'Google Map',
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
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}

class MyVariables {
  static String speciality = '';
  static String speciality2 = '';
  static String province = '';
  static double lat = 0.0;
  static double long = 0.0;
}
