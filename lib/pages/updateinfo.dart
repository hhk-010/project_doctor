import 'package:flutter/material.dart';
import 'package:project_doctor/pages/updatemap.dart';
import 'package:project_doctor/pages/updatepass1.dart';

class Updateinfo extends StatefulWidget {
  @override
  _UpdateinfoState createState() => _UpdateinfoState();
}

class _UpdateinfoState extends State<Updateinfo> {
  String name;
  String speciality;
  String phonenumber;
  String province;

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Update your Info'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'name'),
                  onChanged: (val) {
                    name = val;
                  },
                  validator: (val) => val.isEmpty ? 'enter a valid name' : null,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'speciality'),
                  onChanged: (val) {
                    speciality = val;
                  },
                  validator: (val) =>
                      val.isEmpty ? 'enter a valid speciality' : null,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'phonenumber'),
                  onChanged: (val) {
                    phonenumber = val;
                  },
                  validator: (val) =>
                      val.isEmpty ? 'enter a valid phone number' : null,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'province'),
                  onChanged: (val) {
                    province = val;
                  },
                  validator: (val) =>
                      val.isEmpty ? 'enter a valid province' : null,
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  child: Text('go to google map'),
                  onPressed: () {
                    if (_formkey.currentState.validate()) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Updatemap(
                                name: name,
                                speciality: speciality,
                                number: phonenumber,
                                province: province,
                              )));
                    }
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  child: Text('change your password'),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Updatepass1()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
