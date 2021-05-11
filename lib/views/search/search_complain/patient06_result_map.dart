import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/search/search_complain/patient03_get_location.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

//this file is to show the location of the doctor on the map to the patient

class PatientResultMap extends StatefulWidget {
  final double lat;
  final double lng;
  PatientResultMap({this.lat, this.lng});
  @override
  _PatientResultMapState createState() => _PatientResultMapState(lat: lat, lng: lng);
}

class _PatientResultMapState extends State<PatientResultMap> {
  final RoundedLoadingButtonController _controller = RoundedLoadingButtonController();
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
    return BaseScaffold(
      title: LocaleKeys.view_patient_doctor_location.tr(),
      isAppbar: true,
      action: getAppActions(context),
      child: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onmapcreated,
            initialCameraPosition: CameraPosition(target: LatLng(lat, lng), zoom: 10),
            markers: _marker,
            zoomControlsEnabled: false,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: CustomLoadingButton(
                title: LocaleKeys.view_buttons_ok.tr(),
                controller: _controller,
                onPressed: () {
                  int count = 0;
                  Navigator.popUntil(context, (route) => MyVariables.usingMap ? count++ == 7 : count++ == 6);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
