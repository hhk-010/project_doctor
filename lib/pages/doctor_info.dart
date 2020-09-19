import 'package:flutter/material.dart';
import 'package:project_doctor/services/constants.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/services/data_model.dart';

class DoctorInfo extends StatelessWidget {
  final AuthService _auth = AuthService();
  void choiceAction(String choice) async {
    if (choice == PopUpMenuConstants.logOut) {
      await _auth.signOut();
    } else {
      print('settings');
    }
  }

  final Info info;
  DoctorInfo({this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Your Information',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
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
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 02),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('info.name'),
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
                            Navigator.pop(context);
                          }),
                    ),
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
