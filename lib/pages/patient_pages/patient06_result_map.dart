import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//this file is to show the location of the doctor on the map to the patient

class PatientResultMap extends StatefulWidget {
  double lat;
  double lng;
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
        title: Text('Doctor location on G.P.S'),
        centerTitle: true,
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
            padding: EdgeInsets.all(25.0),
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton(
              backgroundColor: Colors.deepOrange,
              child: Text('N'),
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
