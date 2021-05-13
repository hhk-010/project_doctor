import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/search/search_complain/get_location_wrapper.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

//this file is to show the location of the doctor on the map to the patient

class MapResultView extends StatefulWidget {
  final double lat;
  final double lng;
  MapResultView({this.lat, this.lng});
  @override
  _MapResultViewState createState() => _MapResultViewState(lat: lat, lng: lng);
}

class _MapResultViewState extends State<MapResultView> {
  final RoundedLoadingButtonController _controller = RoundedLoadingButtonController();
  GoogleMapController _mapController;

  double lat;
  double lng;
  _MapResultViewState({this.lat, this.lng});
  Set<Marker> _marker = HashSet<Marker>();
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    changeMapMode(context, _mapController);
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
            onMapCreated: _onMapCreated,
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
                onPressed: () async {
                  await getSuccess(_controller);
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
