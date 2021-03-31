import 'dart:collection';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/pages/patient_pages/patient03_get_location.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/sizing_information.dart';

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
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      double appBarTitle;
      double appBarHeight;
      double title;

      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
        appBarTitle = 25;
        appBarHeight = 50;
        title = displayWidth(context) * 0.05;
      } else {
        appBarTitle = displayHeight(context) * 0.03;
        appBarHeight = 80;
        title = displayWidth(context) * 0.025;
      }

      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: AppBar(
            backgroundColor: Colors.deepOrange,
            title: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  AppLocalizations.of(context).translate('doctor_location'),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: appBarTitle),
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
                      TextStyle(fontWeight: FontWeight.bold, fontSize: title),
                ),
                onPressed: () {
                  int count = 0;
                  Navigator.popUntil(
                      context,
                      (route) =>
                          MyVariables.usingMap ? count++ == 7 : count++ == 6);
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
