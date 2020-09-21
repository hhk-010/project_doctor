import 'package:flutter/material.dart';
import 'package:project_doctor/services/constants.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/auth/loading.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/database.dart';
import 'package:provider/provider.dart';

class DoctorUpdate extends StatefulWidget {
  @override
  _DoctorUpdateState createState() => _DoctorUpdateState();
}

final _formKey = GlobalKey<FormState>();
final List<String> speciality = ['cardio', 'respiratory', 'GIT'];
String _currentName;
String _currentSpeciality;
String _currentPhoneNumber;
String _currentProvince;
String _currentLocation;

final AuthService _auth = AuthService();
void choiceAction(String choice) async {
  if (choice == PopUpMenuConstants.logOut) {
    await _auth.signOut();
  } else {
    print('settings');
  }
}

//Iraq Mobile Number Validator
String validateMobile(String value) {
  if (value.length != 11)
    return 'Mobile Number must be of 11 digit';
  else
    return null;
}

class _DoctorUpdateState extends State<DoctorUpdate> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userDate,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
              backgroundColor: Colors.grey[200],
              appBar: AppBar(
                backgroundColor: Colors.deepOrange,
                title: Text(
                  'Update ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                centerTitle: true,
                elevation: 1,
                actions: [
                  PopupMenuButton<String>(
                      onSelected: choiceAction,
                      itemBuilder: (BuildContext context) {
                        return PopUpMenuConstants.choices.map((String choice) {
                          return PopupMenuItem(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      }),
                ],
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            initialValue: userData.name,
                            cursorColor: Colors.deepOrange,
                            decoration: InputDecoration(
                              hintText: 'قم بإدخال اسمك الثلاثي',
                            ),
                            validator: (value) => value == null
                                ? 'رجاءً قم بإدخال الاسم الثلاثي'
                                : null,
                            onChanged: (val) =>
                                setState(() => _currentName = val),
                          ),
                          SizedBox(height: 15.0),
                          DropdownButtonFormField<String>(
                            value: _currentSpeciality ?? userData.speciality,
                            hint: Text(
                              'قم بادخال اختصاصك الطبي',
                            ),
                            dropdownColor: Colors.grey[200],
                            elevation: 5,
                            icon: Icon(Icons.arrow_drop_down),
                            isExpanded: true,
                            items: speciality.map((speciality) {
                              return DropdownMenuItem(
                                value: speciality,
                                child: Text('$speciality'),
                              );
                            }).toList(),
                            validator: (value) => value == null
                                ? 'رجاءً قم بإدخال اختصاصك الطبي '
                                : null,
                            onChanged: (val) =>
                                setState(() => _currentSpeciality = val),
                          ),
                          SizedBox(height: 15.0),
                          TextFormField(
                              initialValue: userData.phoneNumber,
                              onChanged: (val) =>
                                  setState(() => _currentPhoneNumber = val),
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText:
                                    'قم بإدخال رقم هاتف العياده لغرض الحجز',
                              ),
                              validator: validateMobile),
                          SizedBox(height: 15.0),
                          TextFormField(
                            cursorColor: Colors.deepOrange,
                            decoration: InputDecoration(
                              hintText: 'قم بإدخال ايام ووقت استقبال المرضى ',
                            ),
                            textAlign: TextAlign.right,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'رجاءً قم بإدخال ايام واوقات استقبال المرضى';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'قم بادخال موقع عيادتك',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 18,
                                ),
                              ),
                              ButtonTheme(
                                height: 30,
                                child: RaisedButton(
                                  onPressed: () => print('ON'),
                                  color: Colors.deepOrange,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(80.0)),
                                  child: Text(
                                    'Google Map',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Container(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ButtonTheme(
                                  minWidth: double.infinity,
                                  height: 45,
                                  child: RaisedButton(
                                    color: Colors.deepOrange,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(80.0)),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        await DatabaseService(uid: user.uid)
                                            .updateUserData(
                                          _currentName ?? userData.name,
                                          _currentSpeciality ??
                                              userData.speciality,
                                          _currentPhoneNumber ??
                                              userData.phoneNumber,
                                          _currentProvince ?? userData.province,
                                          _currentLocation ?? userData.location,
                                        );
                                        Navigator.pushNamed(
                                            context, '/doctor_info');
                                      }
                                    },
                                    child: Text(
                                      'ارسل',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
