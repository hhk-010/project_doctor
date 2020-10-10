import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/authorization/email_verfication.dart';
import '../../services/auth.dart';

class DocMap extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  final String speciality;
  final String phone;
  final String province;

  DocMap(
      {this.email,
      this.password,
      this.name,
      this.speciality,
      this.phone,
      this.province});

  @override
  _DocMapState createState() => _DocMapState(
      email: email,
      password: password,
      name: name,
      speciality: speciality,
      phoneNumber: phone,
      province: province);
}

class _DocMapState extends State<DocMap> {
  final AuthService _auth = AuthService();

  var email;
  String password;
  var name;
  var speciality;
  var phoneNumber;
  var province;

  _DocMapState(
      {this.email,
      this.password,
      this.name,
      this.speciality,
      this.phoneNumber,
      this.province});

  var latlng;

  List<Marker> mymarker = [];

  handletap(LatLng tappedpoint) {
    print(tappedpoint);

    latlng = tappedpoint.toString();

    setState(() {
      mymarker = [];
      mymarker.add(Marker(
        markerId: MarkerId(latlng),
        position: tappedpoint,
      ));
    });
  }

  double lattt;
  double lnggg;

  geolocate({String latlng}) {
    var firstindex = latlng.indexOf('(');
    var secondindex = latlng.indexOf(',');
    var thirdindex = latlng.indexOf(')');
    String lat = latlng.substring(firstindex + 1, secondindex);
    String lng = latlng.substring(secondindex + 1, thirdindex);

    lattt = double.parse(lat);
    lnggg = double.parse(lng);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Confirm Location',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(33.312805, 44.361488), zoom: 10),
            markers: Set.from(mymarker),
            onTap: handletap,
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.all(25.0),
            child: FloatingActionButton(
              backgroundColor: Colors.deepOrange,
              child: Text(
                'OK',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                await geolocate(latlng: latlng);
                if (lattt != null && lnggg != null) {
                  await _auth.registerWithEmailAndPassword(email, password,
                      name, speciality, phoneNumber, province, lattt, lnggg);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EmailVerification(email: email)));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
