import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/authorization/loading.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/data_model.dart';

class PatientSearchmap extends StatefulWidget {
  @override
  _PatientSearchmapState createState() => _PatientSearchmapState();
}

class _PatientSearchmapState extends State<PatientSearchmap> {
  String _error = '';

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    var lang = Localizations.localeOf(context).languageCode;

    final _snackBar = new SnackBar(
      content: Text(
        _error,
        style: TextStyle(
            fontSize: 15,
            fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
      ),
      backgroundColor: Colors.deepOrange,
    );
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }

  //-------------------checking internet connection
  bool _isInternet = true;
  checkInternet() async {
    try {
      final response = await InternetAddress.lookup('google.com');
      if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
        _isInternet = true; // internet
      }
    } on SocketException catch (_) {
      _isInternet = false; // no internet
    }
  }

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

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          getDeviceType(context, 36, 56, 56, 56),
        ),
        child: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            AppLocalizations.of(context).translate('patient_map_title'),
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
            initialCameraPosition:
                CameraPosition(target: LatLng(33.312805, 44.361488), zoom: 8),
            markers: Set.from(_mymarker),
            onTap: handletap,
            zoomControlsEnabled: false,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(vertical: 45.0, horizontal: 25.0),
            child: FloatingLoadingButton(
              isloading: isLoading,
              backgroundcolor: Colors.deepOrange,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  AppLocalizations.of(context).translate('ok'),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getDeviceType(context, 15, 18, 21, 24)),
                ),
              ),
              onPressed: () async {
                setState(() => isLoading = true);
                await checkInternet();
                if (_isInternet) {
                  if (patientlatlng == null) {
                    _error = AppLocalizations.of(context)
                        .translate('snack_map_patient');
                    _showSnackBar();
                  } else {
                    geolocate(patientlatlng);
                    double sum = pow(
                            SearchResultData.geoLat -
                                SearchResultData.patientLat,
                            2) +
                        pow(
                            SearchResultData.geoLng -
                                SearchResultData.patientLng,
                            2);
                    double result = sqrt(sum);
                    if (result * 100 < 150000) {
                      SearchResultData.distance = await SearchResultData()
                          .getDistance(
                              SearchResultData.patientLat,
                              SearchResultData.patientLng,
                              SearchResultData.lat,
                              SearchResultData.lng);
                      Navigator.pushNamed(context, '/search resultview');
                    } else {
                      _error = AppLocalizations.of(context)
                          .translate('invalid location');
                      _showSnackBar();
                    }
                  }
                } else {
                  _error = AppLocalizations.of(context)
                      .translate('snack_connectivity');
                  _showSnackBar();
                }
                setState(() => isLoading = false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
