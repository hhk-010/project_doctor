import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/pages/patient_pages/patient03_get_location.dart';

class PatientMap extends StatefulWidget {
  final String speciality;
  final String province;
  PatientMap({this.speciality, this.province});
  @override
  _PatientMapState createState() =>
      _PatientMapState(speciality: speciality, province: province);
}

class _PatientMapState extends State<PatientMap> {
  String speciality;
  String province;
  _PatientMapState({this.speciality, this.province});
  String _error='';

  var patientlatlng;
  List<Marker> _mymarker = [];

  handletap(LatLng tappedpoint) {
    print(tappedpoint);

    patientlatlng = tappedpoint.toString();

    setState(() {
      _mymarker = [];
      _mymarker.add(Marker(
        markerId: MarkerId(patientlatlng),
        position: tappedpoint,
      ));
    });
  }

  double patlatt = 0.0;
  double patlngg = 0.0;

  geolocate(String latlng) {
    var firstindex = latlng.indexOf('(');
    var secondindex = latlng.indexOf(',');
    var thirdindex = latlng.indexOf(')');
    String lat = latlng.substring(firstindex + 1, secondindex);
    String lng = latlng.substring(secondindex + 1, thirdindex);
    patlatt = double.parse(lat);
    patlngg = double.parse(lng);
  }

  //------------------function to show snackbar if the patient didn't
  // tap on the location-------------------------------------------
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    final _snackBar = new SnackBar(
      content: Text(
        'Please , tap on your location',
        style: TextStyle(fontSize: 15),
      ),
      backgroundColor: Colors.deepOrange,
    );
    _scaffoldkey.currentState.showSnackBar(_snackBar);
  }
  //---------------------the end ----------------------
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
        title: Text(
          _error,
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(33.312805, 44.361488), zoom: 8),
            markers: Set.from(_mymarker),
            onTap: handletap,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(vertical: 45.0, horizontal: 25.0),
            child: FloatingActionButton(
              backgroundColor: Colors.deepOrange,
              child: Text('OK'),
              onPressed: () async{
                // there is a bug in this snackbar => to be seen-----
                await checkInternet();
                if(_isInternet){
                  if (patientlatlng == null) {
                    setState(() {
                      _error='Please , tap on your location';
                    });
                    _showSnackBar();
                  } else {
                    geolocate(patientlatlng);
                    setState(() {
                      MyVariables.speciality = speciality;
                      MyVariables.province = province;
                      MyVariables.lat = patlatt;
                      MyVariables.long = patlngg;
                      Navigator.pushNamed(context, '/patient_result');
                    });
                  }
                }else{
                  setState(() {
                    _error='No internet connection';
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
