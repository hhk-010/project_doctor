import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/pages/patient_pages/result.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Select your location',
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
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.all(25.0),
            child: FloatingActionButton(
              backgroundColor: Colors.deepOrange,
              child: Text('S'),
              onPressed: () {
                geolocate(patientlatlng);
                setState(() {
                  MyVariables.speciality = speciality;
                  MyVariables.province = province;
                  MyVariables.lat = patlatt;
                  MyVariables.long = patlngg;
                  Navigator.pushNamed(context, '/result2');
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}



