import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SearchHistoryLocation extends StatefulWidget {
  final double lat;
  final double lng;

  const SearchHistoryLocation({Key key, this.lat, this.lng}) : super(key: key);
  @override
  _SearchHistoryLocationState createState() => _SearchHistoryLocationState(lat: lat, lng: lng);
}

class _SearchHistoryLocationState extends State<SearchHistoryLocation> {
  final RoundedLoadingButtonController _controller = RoundedLoadingButtonController();
  GoogleMapController _mapController;

  double lat;
  double lng;
  _SearchHistoryLocationState({this.lat, this.lng});

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
        alignment: Alignment.topCenter,
        children: [
          GoogleMap(
            mapType: MapType.normal,
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
                  Navigator.popUntil(context, (route) {
                    return count++ == 2;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
