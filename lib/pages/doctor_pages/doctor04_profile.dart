import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_doctor/pages/doctor_pages/doctor05_update_info.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/services/database.dart';
import 'package:provider/provider.dart';

class DoctorProfile extends StatefulWidget {
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().doctorDataProfileStream,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepOrange,
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              AppLocalizations.of(context).translate('profile'),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                //i changed it because it is not defined on my device
                Icons.access_alarm,
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            )
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
  String name = '';
  String speciality = '';
  String number = '';
  String province = '';
  double lat = 0.0;
  double lng = 0.0;
  String _address = '';
  String _vacation = '';
  String _workinghours = '';

//get the user address from lat and lng
  String _doctorAddress = '';
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  _getAddressFromLatLng() async {
    List<Placemark> p = await geolocator.placemarkFromCoordinates(lat, lng);
    Placemark place = p[0];
    setState(() {
      _doctorAddress = "${place.locality}, ${place.country}";
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = TextStyle(
        fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold);
    var uid = FirebaseAuth.instance.currentUser.uid;
    final doctorListProvider = Provider.of<QuerySnapshot>(context);

    if (doctorListProvider != null) {
      for (var doc in doctorListProvider.docs) {
        if (doc.id == uid) {
          print(doc.data()['name']);
          setState(() {
            name = doc.data()['name'];
            speciality = doc.data()['speciality'];
            number = doc.data()['phoneNumber'];
            province = doc.data()['province'];
            lat = doc.data()['lat'];
            lng = doc.data()['lng'];
            _address = doc.data()['address'];
            _vacation = doc.data()['vacation'];
            _workinghours = doc.data()['workinghours'];
            _getAddressFromLatLng();
          });
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 75, horizontal: 50),
      child: Container(
        height: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                        backgroundImage: AssetImage('assets/images/doctor.png'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        name,
                        style: _textStyle,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        speciality,
                        style: _textStyle,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        number,
                        style: _textStyle,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        _doctorAddress,
                        style: _textStyle,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        _address,
                        style: _textStyle,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'clinic vacation is ' + _vacation,
                        style: _textStyle,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        _workinghours,
                        style: _textStyle,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              child: Text(
                AppLocalizations.of(context).translate('update_info'),
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
          ],
        ),
      ),
    );
  }
}
