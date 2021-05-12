import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/services/connectivity.dart';
import 'package:project_doctor/views/search/search_complain/get_location_wrapper.dart';
import 'package:project_doctor/views/search/search_complain/result_profile.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class GetMapView extends StatefulWidget {
  final String speciality;
  final String province;
  GetMapView({this.speciality, this.province});
  @override
  _GetMapViewState createState() => _GetMapViewState(speciality: speciality, province: province);
}

class _GetMapViewState extends State<GetMapView> {
  final RoundedLoadingButtonController _controller = RoundedLoadingButtonController();
  String speciality;
  String province;
  _GetMapViewState({this.speciality, this.province});

  var patientlatlng;
  List<Marker> _mymarker = [];

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

  double patlatt = 0.0;
  double patlngg = 0.0;

  geolocate(String latlng) {
    var firstindex = latlng.indexOf('(');
    var secondindex = latlng.indexOf(',');
    var thirdindex = latlng.indexOf(')');
    String lat = latlng.substring(firstindex + 1, secondindex);
    String lng = latlng.substring(secondindex + 1, thirdindex);
    patlatt = double.parse(lat);
    patlngg = double.parse(lng);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: LocaleKeys.view_patient_patient_map_title.tr(),
      isAppbar: true,
      action: getAppActions(context),
      child: Stack(
        alignment: Alignment.topCenter,
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
                        setState(() {
                          MyVariables.speciality = speciality;
                          MyVariables.province = province;
                          MyVariables.lat = patlatt;
                          MyVariables.lng = patlngg;
                        });
                        double sum = pow(MyVariables.geolat - MyVariables.lat, 2) + pow(MyVariables.geolng - MyVariables.lng, 2);
                        double result = sqrt(sum);
                        if (result * 100 > 150)
                          getFlushbar(context, LocaleKeys.view_patient_invalid_location.tr(), _controller);
                        else {
                          await getSuccess(_controller);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileResultView()));
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
