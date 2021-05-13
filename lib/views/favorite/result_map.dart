import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/views/favorite/favorite_list.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class FavoriteMapResultView extends StatefulWidget {
  @override
  _FavoriteMapResultViewState createState() => _FavoriteMapResultViewState();
}

class _FavoriteMapResultViewState extends State<FavoriteMapResultView> {
  final RoundedLoadingButtonController _controller = RoundedLoadingButtonController();
  GoogleMapController _mapController;

  Set<Marker> _marker = HashSet<Marker>();
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    changeMapMode(context, _mapController);
    setState(() {
      _marker.add(Marker(markerId: MarkerId('0'), position: LatLng(SearchResultData.lat, SearchResultData.lng)));
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
            initialCameraPosition: CameraPosition(target: LatLng(SearchResultData.lat, SearchResultData.lng), zoom: 10),
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
          ),
        ],
      ),
    );
  }
}
