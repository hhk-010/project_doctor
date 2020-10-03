import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/finalscore.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {

  var regions=['baghdad','northern region','south region','western region'];
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
                    finalscore.speciality,
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
                    child: Column(children: [
                      SizedBox(height: 15,),
                      DropdownButtonFormField(),
                    ],),
                  ),
                ),
                SizedBox(height: 150,),
                RaisedButton(child: Text('Next'),onPressed: (){
                  Navigator.pushNamed(context, '/result2');
                },),
              ],
            ),
          ),
        ));
  }
}
