import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:ui';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/services/app_localizations.dart';


class LastSearchedLocation extends StatefulWidget {
  final double lat;
  final double lng;

  const LastSearchedLocation({Key key, this.lat, this.lng}) : super(key: key);
  @override
  _LastSearchedLocationState createState() =>
      _LastSearchedLocationState(lat: lat, lng: lng);
}

class _LastSearchedLocationState extends State<LastSearchedLocation> {
  double lat;
  double lng;
  _LastSearchedLocationState({this.lat, this.lng});

  Set<Marker> _marker = HashSet<Marker>();
  // ignore: unused_field
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.deepOrange,
            title: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  AppLocalizations.of(context).translate('doctor_location'),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                )),
            centerTitle: true,
            elevation: 0,
          ),
        ),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onmapcreated,
              initialCameraPosition:
                  CameraPosition(target: LatLng(lat, lng), zoom: 10),
              markers: _marker,
              zoomControlsEnabled: false,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 45.0, horizontal: 25.0),
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                backgroundColor: Colors.deepOrange,
                child: Text(
                  AppLocalizations.of(context).translate('ok'),
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                onPressed: () {
                  int count = 0;
                  Navigator.popUntil(context, (route) {
                    return count++ == 2;
                  });
                },
              ),
            ),
          ],
        ),
      );

  }
}
