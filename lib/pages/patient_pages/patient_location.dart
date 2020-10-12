import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/pages/patient_pages/patient_map.dart';
import 'package:project_doctor/matching_algorithm/final_score.dart';
import 'package:geolocator/geolocator.dart';

class PatientLocation extends StatefulWidget {
  @override
  _PatientLocationState createState() => _PatientLocationState();
}

class _PatientLocationState extends State<PatientLocation> {
  String region = '';
  List<DropdownMenuItem<String>> regions = List();
  final regionsa = {
    '1': 'baghdad',
    '2': 'northern region',
    '3': 'southern region',
    '4': 'western region'
  };

  void _getCurrentLocation() async {
    final Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Search',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  FinalScore.speciality,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  FinalScore.speciality2,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                decoration: boxDecorationPatient,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      DropdownButton(
                        hint: Text('select the province'),
                        isExpanded: true,
                        items: [
                          DropdownMenuItem<String>(
                            value: "baghdad",
                            child: Center(
                              child: Text("baghdad"),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: "northern region",
                            child: Center(
                              child: Text("northern region"),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: "southern region",
                            child: Center(
                              child: Text("southern region"),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: "western region",
                            child: Center(
                              child: Text("western region"),
                            ),
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
              ),
              SizedBox(
                height: 150,
              ),
              RaisedButton(
                child: Text('Use Google Map'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PatientMap(
                            speciality: FinalScore.speciality,
                            province: region,
                          )));
                },
              ),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                child: Text('Use Geolocator'),
                onPressed: () {
                  _getCurrentLocation();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyVariables {
  static String speciality = '';
  static String speciality2 = '';
  static String province = '';
  static double lat = 0.0;
  static double long = 0.0;
}
