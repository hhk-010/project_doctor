import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/services/database.dart';

class DocMap extends StatefulWidget {
  final String name;
  final String speciality;
  final String phone;
  final String province;

  DocMap({this.name, this.speciality, this.phone, this.province});

  @override
  _DocMapState createState() => _DocMapState(
      nameM: name,
      specialityM: speciality,
      phoneNumberM: phone,
      provinceM: province);
}

class _DocMapState extends State<DocMap> {
  var nameM;
  var specialityM;
  var phoneNumberM;
  var provinceM;

  _DocMapState(
      {this.nameM, this.specialityM, this.phoneNumberM, this.provinceM});

  var uid = FirebaseAuth.instance.currentUser.uid;

  var latLng;
  List<Marker> mymarker = [];

  handletap(LatLng tappedpoint) {
    print(tappedpoint);
    latLng = tappedpoint.toString();
    setState(() {
      mymarker = [];
      mymarker.add(Marker(
        markerId: MarkerId(latLng),
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
        title: Text('confirm location'),
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
                'Submit',
              ),
              onPressed: () async {
                await geolocate(latlng: latLng);
                DatabaseService(uid: uid).updateUserData(
                  nameM,
                  specialityM,
                  phoneNumberM,
                  provinceM,
                  lattt,
                  lnggg,
                );
                await Navigator.pushNamed(context, '/doctor_profile');
              },
            ),
          ),
        ],
      ),
    );
  }
}
