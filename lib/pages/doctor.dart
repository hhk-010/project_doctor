import 'package:flutter/material.dart';
//import 'package:weekday_selector/weekday_selector.dart';

class Doctor extends StatefulWidget {
  @override
  _DoctorState createState() => _DoctorState();
}

final _formKey = GlobalKey<FormState>();

//Iraq Mobile Number Validator
String validateMobile(String value) {
  if (value.length != 11)
    return 'Mobile Number must be of 11 digit';
  else
    return null;
}

class _DoctorState extends State<Doctor> {
  String _specialityValue;
  List<String> _speciality = ['GP', 'Internist', 'Cardiologist'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'معلومات الطبيب',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        elevation: 1,
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
                    cursorColor: Colors.deepOrange,
                    decoration: InputDecoration(
                      hintText: 'قم بإدخال اسمك الثلاثي',
                    ),
                    validator: (value) =>
                        value == null ? 'رجاءً قم بإدخال الاسم الثلاثي' : null,
                  ),
                  SizedBox(height: 15.0),
                  DropdownButtonFormField<String>(
                    hint: Text(
                      'قم بادخال اختصاصك الطبي',
                    ),
                    dropdownColor: Colors.grey[200],
                    elevation: 5,
                    icon: Icon(Icons.arrow_drop_down),
                    isExpanded: true,
                    items: _speciality.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: _specialityValue,
                    onChanged: (value) {
                      setState(() {
                        _specialityValue = value;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'رجاءً قم بإدخال اختصاصك الطبي ' : null,
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                      keyboardType: TextInputType.phone,
                      cursorColor: Colors.deepOrange,
                      decoration: InputDecoration(
                        hintText: 'قم بإدخال رقم هاتف العياده لغرض الحجز',
                      ),
                      textAlign: TextAlign.right,
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
                          color: Colors.deepOrange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          onPressed: () => print('ON'),
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
                                borderRadius: BorderRadius.circular(80.0)),
                            onPressed: () {
                              print('ON');
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                              } else {
                                setState(() {});
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
  }
}
