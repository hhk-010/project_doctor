import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/pages/Patientmap.dart';
import 'package:project_doctor/services/finalscore.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  String region = '';
  List<DropdownMenuItem<String>> regions = List();
  final regionsa = {
    '1': 'baghdad',
    '2': 'northern region',
    '3': 'southern region',
    '4': 'western region'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'The Result',
          style: TextStyle(fontSize: 25.0),
        ),
        centerTitle: true,
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
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
