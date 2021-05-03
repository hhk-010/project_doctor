import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/pages/patient_pages/patient03_get_location.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/sizing_information.dart';

class PatientMap extends StatefulWidget {
  final String speciality;
  final String province;
  PatientMap({this.speciality, this.province});
  @override
  _PatientMapState createState() =>
      _PatientMapState(speciality: speciality, province: province);
}

class _PatientMapState extends State<PatientMap> {
  String speciality;
  String province;
  _PatientMapState({this.speciality, this.province});
  String _error = '';

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

  //------------------function to show snackbar if the patient didn't
  // tap on the location-------------------------------------------
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

  //---------------------the end ----------------------
  //-------------------checking internet connection
  bool _isInternet = true;
  checkInternet() async {
    try {
      final response = await InternetAddress.lookup('google.com');
      if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
        _isInternet = true; // internet
        setState(() {});
      }
    } on SocketException catch (_) {
      _isInternet = false; // no internet
      setState(() {});
    }
  }

  //------------the end --------------------
  @override
  void initState() {
    //checkInternet();
    super.initState();
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
        title = displayWidth(context) * 0.03;
      }

      return Scaffold(
        key: _scaffoldkey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: AppBar(
            backgroundColor: Colors.deepOrange,
            title: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                AppLocalizations.of(context).translate('patient_map_title'),
                style: TextStyle(
                    fontSize: appBarTitle, fontWeight: FontWeight.bold),
              ),
            ),
            elevation: 0,
            centerTitle: true,
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
              child: FloatingActionButton(
                backgroundColor: Colors.deepOrange,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    AppLocalizations.of(context).translate('ok'),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: title),
                  ),
                ),
                onPressed: () async {
                  // there is a bug in this snackbar => to be seen-----
                  await checkInternet();
                  if (_isInternet) {
                    if (patientlatlng == null) {
                      _error = AppLocalizations.of(context)
                          .translate('snack_map_patient');
                      _showSnackBar();
                    } else {
                      geolocate(patientlatlng);
                      setState(() {
                        MyVariables.speciality = speciality;
                        MyVariables.province = province;
                        MyVariables.lat = patlatt;
                        MyVariables.lng = patlngg;
                      });
                      double sum =
                          pow(MyVariables.geolat - MyVariables.lat, 2) +
                              pow(MyVariables.geolng - MyVariables.lng, 2);
                      double result = sqrt(sum);
                      if (result * 100 < 150) {
                        //setState(() => ShowFloatingActionButton.show = true);
                        Navigator.pushNamed(context, '/patient_result');
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
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
