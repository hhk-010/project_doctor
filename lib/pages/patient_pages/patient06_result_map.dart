import 'dart:collection';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/services/app_localizations.dart';

//this file is to show the location of the doctor on the map to the patient

class PatientResultMap extends StatefulWidget {
  final double lat;
  final double lng;
  PatientResultMap({this.lat, this.lng});
  @override
  _PatientResultMapState createState() =>
      _PatientResultMapState(lat: lat, lng: lng);
}

class _PatientResultMapState extends State<PatientResultMap> {
  double lat;
  double lng;
  _PatientResultMapState({this.lat, this.lng});
  Set<Marker> _marker = HashSet<Marker>();
  GoogleMapController _mapController;
  void _onmapcreated(GoogleMapController controller) {
    _mapController = controller;
    setState(() {
      _marker.add(Marker(markerId: MarkerId('0'), position: LatLng(lat, lng)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: FittedBox( 
          fit: BoxFit.fitWidth,
          child: Text(AppLocalizations.of(context).translate('doctor_location'),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onmapcreated,
            initialCameraPosition:
                CameraPosition(target: LatLng(lat, lng), zoom: 10),
            markers: _marker,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 45.0, horizontal: 25.0),
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              backgroundColor: Colors.deepOrange,
              child: Text(AppLocalizations.of(context).translate('ok'),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
          ),
        ],
      ),
    );
  }
}
