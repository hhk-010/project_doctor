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

  //checkbox varialbles
  bool _checkDM = false;
  bool _checkHTN = false;
  bool _checkCVA = false;
  bool _checkSmoking = false;
  bool _checkAlcohol = false;

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
                  Center(
                    child: Text(
                      'المعلومات الشخصيه',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'قد بإدخال عمرك',
                    ),
                    validator: (value) =>
                        value == null ? 'رجاءً قم بإدخال عمرك' : null,
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField(
                    items: null,
                    onChanged: null,
                    hint: Text(
                      'ذكر ام انثى',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                      'الاعراض التي تعاني منها',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
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
                      'involved system 01',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField(
                    items: null,
                    onChanged: null,
                    hint: Text(
                      'symptom 01',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField(
                    items: null,
                    onChanged: null,
                    hint: Text(
                      'involved system 02',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField(
                    items: null,
                    onChanged: null,
                    hint: Text(
                      'symptom 02',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField(
                    items: null,
                    onChanged: null,
                    hint: Text(
                      'involved system 03',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField(
                    items: null,
                    onChanged: null,
                    hint: Text(
                      'symptom 03',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField(
                    items: null,
                    onChanged: null,
                    hint: Text(
                      'involved system 04',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField(
                    items: null,
                    onChanged: null,
                    hint: Text(
                      'symptom 04',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField(
                    items: null,
                    onChanged: null,
                    hint: Text(
                      'involved system 05',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField(
                    items: null,
                    onChanged: null,
                    hint: Text(
                      'symptom 05',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField(
                    items: null,
                    onChanged: null,
                    hint: Text(
                      'involved system 06',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField(
                    items: null,
                    onChanged: null,
                    hint: Text(
                      'symptom 06',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField(
                    items: null,
                    onChanged: null,
                    hint: Text(
                      'involved system 07',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField(
                    items: null,
                    onChanged: null,
                    hint: Text(
                      'symptom 07',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                      'الامراض المزمنه',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 15),
                  CheckboxListTile(
                      title: Text('مرض السكري'),
                      value: _checkDM,
                      onChanged: (bool value) {
                        setState(() {
                          _checkDM = value;
                        });
                      }),
                  CheckboxListTile(
                      title: Text('ارتفاع الضغط'),
                      value: _checkHTN,
                      onChanged: (bool value) {
                        setState(() {
                          _checkHTN = value;
                        });
                      }),
                  CheckboxListTile(
                      title: Text('جلطات سابقه'),
                      value: _checkCVA,
                      onChanged: (bool value) {
                        setState(() {
                          _checkCVA = value;
                        });
                      }),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                      'اسلوب الحياه ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 15),
                  CheckboxListTile(
                      title: Text('التدخين'),
                      value: _checkSmoking,
                      onChanged: (bool value) {
                        setState(() {
                          _checkSmoking = value;
                        });
                      }),
                  CheckboxListTile(
                      title: Text('الكحول'),
                      value: _checkAlcohol,
                      onChanged: (bool value) {
                        setState(() {
                          _checkAlcohol = value;
                        });
                      }),
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
