import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../services/auth.dart';
import '../services/auth.dart';
import '../services/database.dart';

class Updatemap extends StatefulWidget {
  String name;
  String speciality;
  String number;
  String province;
  Updatemap({this.name, this.speciality, this.province, this.number});
  @override
  _UpdatemapState createState() => _UpdatemapState(
      name: name, speciality: speciality, number: number, province: province);
}

class _UpdatemapState extends State<Updatemap> {
  String name;
  String speciality;
  String number;
  String province;

  var latlng;

  final AuthService _auth = AuthService();

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

  _UpdatemapState({this.name, this.speciality, this.number, this.province});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('update your location'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(33.312805, 44.361488),
              zoom: 10,
            ),
            markers: Set.from(mymarker),
            onTap: handletap,
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.all(25.0),
            child: FloatingActionButton(
              backgroundColor: Colors.deepOrange,
              child: Text('U'),
              onPressed: () async {
                dynamic result = await DatabaseService(
                        uid: FirebaseAuth.instance.currentUser.uid)
                    .updateUserData(
                        name, speciality, number, province, lattt, lnggg);
                await Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
