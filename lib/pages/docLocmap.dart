import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//this file is to show the location of the doctor on the map to the patient

class Doclocmap extends StatefulWidget {
  @override
  _DoclocmapState createState() => _DoclocmapState();
}

class _DoclocmapState extends State<Doclocmap> {
  double lat = 0.0;
  double lng = 0.0;
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
        title: Text('Doctor location on G.map'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onmapcreated,
            initialCameraPosition:
                CameraPosition(target: LatLng(lat, lng), zoom: 10),
            markers: _marker,
          ),
        ],
      ),
    );
  }
}
