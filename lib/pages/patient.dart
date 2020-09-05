import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class Patient extends StatefulWidget {
  @override
  _PatientState createState() => _PatientState();
}

class _PatientState extends State<Patient> {
  final _formKey = GlobalKey<FormState>();

  // a Function that return the user location in LatLong.
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
          'معلومات المريض',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    cursorColor: Colors.orange,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'قد بإدخال عمرك',
                    ),
                    validator: (value) =>
                        value == null ? 'رجاءً قم بإدخال الاسم الثلاثي' : null,
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField(
                    items: null,
                    onChanged: null,
                    hint: Text(
                      'اختر علامه المرض الاوليه الذي تعاني منه',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField(
                    items: null,
                    onChanged: null,
                    hint: Text(
                      'اختر علامه المرض الثانويه الذي تعاني منه',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 60),
                  Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ButtonTheme(
                          minWidth: double.infinity,
                          height: 45,
                          child: RaisedButton(
                            color: Colors.deepOrange,
                            onPressed: () {
                              _getCurrentLocation();

                              Navigator.pushNamed(context, '/result');
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0)),
                            child: Text(
                              'بحث',
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
  }
}
