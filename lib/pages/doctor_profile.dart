import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/pages/doctor_update_info.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/services/database.dart';
import 'package:provider/provider.dart';

class DoctorProfile extends StatelessWidget {
  final AuthService _auth = AuthService();
  void choiceAction(String choice) async {
    if (choice == PopUpMenuConstants.logOut) {
      await _auth.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().doctorDataProfileStream,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepOrange,
          title: Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          elevation: 0,
          actions: [
            PopupMenuButton<String>(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
        body: DoctorList(),
      ),
    );
  }
}

class DoctorList extends StatefulWidget {
  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = TextStyle(
        fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold);
    var uid = FirebaseAuth.instance.currentUser.uid;
    final doctorListProvider = Provider.of<QuerySnapshot>(context);
    String name = '';
    String speciality = '';
    String number = '';
    String province = '';
    double lattt = 0.0;
    double lnggg = 0.0;

    for (var doc in doctorListProvider.docs) {
      if (doc.id == uid) {
        print(doc.data()['name']);
        name = doc.data()['name'];
        speciality = doc.data()['speciality'];
        number = doc.data()['phoneNumber'];
        province = doc.data()['province'];
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: boxDecorationPatient,
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.deepOrange,
                          radius: 75,
                          backgroundImage:
                              AssetImage('assets/images/doctor.png'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          name,
                          style: _textStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          speciality,
                          style: _textStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          number,
                          style: _textStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          province,
                          style: _textStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Center(
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  child: Text(
                    'Update Your Information!',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  color: Colors.deepOrange,
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Updateinfo()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
