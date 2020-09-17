import 'package:flutter/material.dart';
import 'package:project_doctor/auth/loading.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/database.dart';
import 'package:provider/provider.dart';
import 'package:project_doctor/services/constants.dart';

class DoctorForm extends StatefulWidget {
  @override
  _DoctorFormState createState() => _DoctorFormState();
}

final _formKey = GlobalKey<FormState>();
final List<String> speciality = ['cardio', 'respiratory', 'GIT'];
String _currentName;
String _currentSpeciality;
String _currentPhoneNumber;
String _currentProvince;
String _currentLocation;

class _DoctorFormState extends State<DoctorForm> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userDate,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'update your information',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputdecoration.copyWith(hintText: 'Name'),
                    validator: (val) =>
                        val.isEmpty ? 'please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  DropdownButtonFormField(
                    //value: _currentSpeciality ?? userData.speciality,
                    decoration: textInputdecoration,
                    items: speciality.map((speciality) {
                      return DropdownMenuItem(
                        value: speciality,
                        child: Text('$speciality'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _currentSpeciality = val),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentName ?? userData.name,
                          _currentSpeciality ?? userData.speciality,
                          _currentPhoneNumber ?? userData.phoneNumber,
                          _currentProvince ?? userData.province,
                          _currentLocation ?? userData.location,
                        );
                        Navigator.pop(context);
                      }
                    },
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
