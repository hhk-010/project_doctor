import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/pages/doctor_pages/doctor06_update_map.dart';
import 'package:project_doctor/services/app_localizations.dart';

class Update2 extends StatefulWidget {
  final String name;
  final String speciality;
  final String phoneNumber;
  final String province;
  Update2({this.name, this.speciality, this.phoneNumber, this.province});
  @override
  _Update2State createState() => _Update2State(
      name: name,
      speciality: speciality,
      phoneNumber: phoneNumber,
      province: province);
}

class _Update2State extends State<Update2> {

  final String name;
  final String speciality;
  final String phoneNumber;
  final String province;
  _Update2State({this.name,this.speciality,this.phoneNumber,this.province});

  String address='';
  String vacation='';
  String workinghours='';
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            AppLocalizations.of(context).translate('update_info'),
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 75.0, horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Spacer(),
              TextFormField(
                onChanged: (val) => setState(() => address = val),
                decoration:
                    textInputdecoration.copyWith(hintText: 'detailed address'),
                validator: (val) =>
                    val.isEmpty ? 'enter a valid address' : null,
              ),
              Spacer(),
              TextFormField(
                onChanged: (val) => setState(() => vacation = val),
                decoration:
                    textInputdecoration.copyWith(hintText: 'clinic vacation'),
                validator: (val) =>
                    val.isEmpty ? 'enter a valid clinic vacation days' : null,
              ),
              Spacer(),
              TextFormField(
                onChanged: (val) => setState(() => workinghours = val),
                decoration:
                    textInputdecoration.copyWith(hintText: 'working hours'),
                validator: (val) =>
                    val.isEmpty ? 'enter valid working hours' : null,
              ),
              Spacer(
                flex: 3,
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context).translate('finish_update'),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.arrow_downward,
                    size: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ButtonTheme(
                minWidth: double.infinity,
                child: RaisedButton.icon(
                  color: Colors.deepOrange,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  onPressed: () {
                    if (_formkey.currentState.validate()) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UpdateMap(
                            name: name,
                            speciality: speciality,
                            number: phoneNumber,
                            province: province,
                            address: address,
                            vacation: vacation,
                            workinghours: workinghours,
                          ),
                        ),
                      );
                    }
                  },
                  label: Text(
                    AppLocalizations.of(context).translate('google_map'),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
