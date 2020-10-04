import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/pages/Patientmap.dart';
import 'package:project_doctor/pages/docLocmap.dart';
import 'package:project_doctor/services/database.dart';
import 'package:provider/provider.dart';

class Result2 extends StatefulWidget {
  @override
  _Result2State createState() => _Result2State();
}

class _Result2State extends State<Result2> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().doctorDataProfileStream,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            'The Result',
            style: TextStyle(fontSize: 25.0),
          ),
          centerTitle: true,
        ),
        body: TheProfile(),
      ),
    );
  }
}

class Distance {
  static double distances = 0.0;
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
    double sum = 0.0;
    double result = 0.0;
    for (var docu in doctorListProvider.docs) {
      sum = ((docu.data()['lat'] - myvariables.lat) *
              (docu.data()['lat'] - myvariables.lat)) +
          ((docu.data()['lng'] - myvariables.long) *
              (docu.data()['lng'] - myvariables.long));
      result = sqrt(sum);

      if (result > Distance.distances &&
          docu.data()['speciality'] == myvariables.speciality) {
        Distance.distances = result;
      }
    }
    for (var docu in doctorListProvider.docs) {
      sum = ((docu.data()['lat'] - myvariables.lat) *
              (docu.data()['lat'] - myvariables.lat)) +
          ((docu.data()['lng'] - myvariables.long) *
              (docu.data()['lng'] - myvariables.long));
      result = sqrt(sum);

      if (result <= Distance.distances &&
          docu.data()['speciality'] == myvariables.speciality) {
        Distance.distances = result;
        _name = docu.data()['name'];
        _speciality = docu.data()['speciality'];
        _number = docu.data()['phoneNumber'];
        _province = docu.data()['province'];
        _lat = docu.data()['lat'];
        _lng = docu.data()['lng'];
      }
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
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
            child: Text('Show Doctor Location'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Doclocmap(
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
