import 'package:flutter/material.dart';
import 'package:project_doctor/services/finalscore.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
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
          child: Column(
            children: [
              Center(
                child: Text(
                  finalscore.speciality,
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ));
  }
}
