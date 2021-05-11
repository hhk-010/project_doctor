import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:project_doctor/services/connectivity.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/search/search_complain/patient05_result.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class PatientSearchmap extends StatefulWidget {
  @override
  _PatientSearchmapState createState() => _PatientSearchmapState();
}

class _PatientSearchmapState extends State<PatientSearchmap> {
  final RoundedLoadingButtonController _controller = RoundedLoadingButtonController();

  List<Marker> _mymarker = [];
  String patientlatlng;
  handletap(LatLng tappedpoint) {
    print(tappedpoint);
    patientlatlng = tappedpoint.toString();
    setState(() {
      _mymarker = [];
      _mymarker.add(Marker(
        markerId: MarkerId(patientlatlng),
        position: tappedpoint,
      ));
    });
  }

  geolocate(String latlng) {
    var firstindex = latlng.indexOf('(');
    var secondindex = latlng.indexOf(',');
    var thirdindex = latlng.indexOf(')');
    String lat = latlng.substring(firstindex + 1, secondindex);
    String lng = latlng.substring(secondindex + 1, thirdindex);
    SearchResultData.patientLat = double.parse(lat);
    SearchResultData.patientLng = double.parse(lng);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: LocaleKeys.view_patient_patient_map_title.tr(),
      isAppbar: true,
      action: getAppActions(context),
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: LatLng(33.312805, 44.361488), zoom: 8),
            markers: Set.from(_mymarker),
            onTap: handletap,
            zoomControlsEnabled: false,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: CustomLoadingButton(
                  title: LocaleKeys.view_buttons_submit.tr(),
                  controller: _controller,
                  onPressed: () async {
                    if (!await isInternet())
                      getFlushbar(context, LocaleKeys.error_snack_connectivity.tr(), _controller);
                    else {
                      if (patientlatlng == null)
                        getFlushbar(context, LocaleKeys.error_snack_map_patient.tr(), _controller);
                      else {
                        geolocate(patientlatlng);
                        double sum = pow(SearchResultData.geoLat - SearchResultData.patientLat, 2) +
                            pow(SearchResultData.geoLng - SearchResultData.patientLng, 2);
                        double result = sqrt(sum);
                        if (result * 100 > 150000)
                          getFlushbar(context, LocaleKeys.view_patient_invalid_location.tr(), _controller);
                        else {
                          SearchResultData.distance = await SearchResultData()
                              .getDistance(SearchResultData.patientLat, SearchResultData.patientLng, SearchResultData.lat, SearchResultData.lng);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PatientResult()));
                        }
                      }
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
