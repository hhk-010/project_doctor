import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/constants/device_size.dart';
import 'package:project_doctor/favorite_list/favorite_list.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/data_model.dart';

class DoctorLocationmap extends StatefulWidget {
  @override
  _DoctorLocationmapState createState() => _DoctorLocationmapState();
}

class _DoctorLocationmapState extends State<DoctorLocationmap> {
  Set<Marker> _marker = HashSet<Marker>();
  // ignore: unused_field
  GoogleMapController _mapController;
  void _onmapcreated(GoogleMapController controller) {
    _mapController = controller;
    setState(() {
      _marker.add(Marker(
          markerId: MarkerId('0'),
          position: LatLng(SearchResultData.lat, SearchResultData.lng)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          getDeviceType(context, 36, 56, 56, 56),
        ),
        child: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            AppLocalizations.of(context).translate('doctor_location'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: getDeviceType(context, 1, 23, 35, 45),
            ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onmapcreated,
            initialCameraPosition: CameraPosition(
                target: LatLng(SearchResultData.lat, SearchResultData.lng),
                zoom: 10),
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: getDeviceType(context, 12, 15, 18, 21),
                ),
              ),
              onPressed: () {
                int count = 0;
                Navigator.popUntil(
                    context,
                    (route) => FavoriteTile.favoriteListSelected
                        ? SearchResultData.mapSelected
                            ? count++ == 4
                            : count++ == 3
                        : SearchResultData.mapSelected
                            ? count++ == 5
                            : count++ == 4);
              },
            ),
          ),
        ],
      ),
    );
  }
}
