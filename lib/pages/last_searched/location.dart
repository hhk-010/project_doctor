import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:ui';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/sizing_information.dart';

class LastSearchedLocation extends StatefulWidget {
  final double lat;
  final double lng;

  const LastSearchedLocation({Key key, this.lat, this.lng}) : super(key: key);
  @override
  _LastSearchedLocationState createState() => _LastSearchedLocationState(lat: lat, lng: lng);
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
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      double appBarTitle;
      double appBarHeight;
      double title;

      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
        appBarTitle = 25;
        appBarHeight = 50;
        title = displayWidth(context) * 0.05;
      } else {
        appBarTitle = displayHeight(context) * 0.045;
        appBarHeight = 75;
        title = displayWidth(context) * 0.035;
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: appBarTitle),
                )),
            centerTitle: true,
            elevation: 0,
          ),
        ),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onmapcreated,
              initialCameraPosition: CameraPosition(target: LatLng(lat, lng), zoom: 10),
              markers: _marker,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context).translate("zoom_in_out"),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).translate("zoom_in"),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).translate("zoom_out"),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 45.0, horizontal: 25.0),
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                backgroundColor: Colors.deepOrange,
                child: Text(
                  AppLocalizations.of(context).translate('ok'),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: title),
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
    });
  }
}
