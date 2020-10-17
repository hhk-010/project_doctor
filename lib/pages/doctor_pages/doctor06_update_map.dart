import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../services/database.dart';

// ----------------class for snackbar error
class snackbarerror {
  static String error = '';
}

class UpdateMap extends StatefulWidget {
  final String name;
  final String speciality;
  final String number;
  final String province;
  final String address;
  final String vacation;
  final String workinghours;
  UpdateMap(
      {this.name,
      this.speciality,
      this.province,
      this.number,
      this.address,
      this.vacation,
      this.workinghours});
  @override
  _UpdateMapState createState() => _UpdateMapState(
      name: name,
      speciality: speciality,
      number: number,
      province: province,
      address: address,
      vacation: vacation,
      workinghours: workinghours);
}

class _UpdateMapState extends State<UpdateMap> {
  String name;
  String speciality;
  String number;
  String province;
  String address = '';
  String vacation = '';
  String workinghours = '';

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

  //==============snackbar for empty latlng============
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    final snackBar = new SnackBar(
      content: new Text(
        snackbarerror.error,
        style: TextStyle(fontSize: 15),
      ),
      //duration: new Duration(seconds: 3),
      backgroundColor: Colors.deepOrange,
    );
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  //-------------------checking internet connection
  bool _isInternet = true;
  checkInternet() async {
    try {
      final response = await InternetAddress.lookup('google.com');
      if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
        _isInternet = true; // internet
        setState(() {});
      }
    } on SocketException catch (_) {
      _isInternet = false; // no internet
      setState(() {});
    }
  }
  //------------the end --------------------

  _UpdateMapState(
      {this.name,
      this.speciality,
      this.number,
      this.province,
      this.address,
      this.vacation,
      this.workinghours});

  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Update your location'),
        centerTitle: true,
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
            padding: EdgeInsets.symmetric(vertical: 45.0, horizontal: 15.0),
            child: FloatingActionButton(
              backgroundColor: Colors.deepOrange,
              child: Text('U'),
              onPressed: () async {
                checkInternet();
                if (_isInternet) {
                  if (latlng == null) {
                    setState(() {
                      snackbarerror.error = 'Please , tap on your location';
                    });
                    _showSnackBar();
                  } else {
                    await geolocate(latlng: latlng);
                    if (lattt != null && lnggg != null) {
                      await DatabaseService(
                              uid: FirebaseAuth.instance.currentUser.uid)
                          .updateUserData(name, speciality, number, province,
                              lattt, lnggg, address, vacation, workinghours);
                      Navigator.pop(context);
                    }
                  }
                } else {
                  setState(() {
                    snackbarerror.error = 'No internet connection';
                  });
                  _showSnackBar();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
