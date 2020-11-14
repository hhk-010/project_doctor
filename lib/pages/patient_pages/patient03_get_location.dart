import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/pages/patient_pages/patient04_map.dart';
import 'package:project_doctor/matching_algorithm/final_score.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_doctor/services/app_localizations.dart';

class PatientGetLocation extends StatefulWidget {
  @override
  _PatientGetLocationState createState() => _PatientGetLocationState();
}

class _PatientGetLocationState extends State<PatientGetLocation> {
  String region;

  String _error = '';
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;

  //function to show snackbar if the patient didn't
  // tap on the location
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
    _scaffoldkey.currentState.showSnackBar(_snackBar);
  }

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

  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final iraqRegions = {
      "1": [AppLocalizations.of(context).translate('Baghdad'), "Baghdad"],
      "2": [
        AppLocalizations.of(context).translate('northen_region'),
        "Northern Region"
      ],
      "3": [
        AppLocalizations.of(context).translate('southern_region'),
        "Southern Region"
      ],
      "4": [
        AppLocalizations.of(context).translate('western_region'),
        "Eastern Region"
      ],
      "5": [
        AppLocalizations.of(context).translate('Middle Region'),
        "Middle Region"
      ],
    };

    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            AppLocalizations.of(context).translate('region'),
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: boxDecorationPatient,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context).translate('province'),
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 2,
                    indent: 30,
                    endIndent: 30,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: DropdownButton(
                      hint: Text(
                        AppLocalizations.of(context).translate('select_region'),
                      ),
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(
                          value: iraqRegions["1"][1],
                          child: Text(iraqRegions["1"][0]),
                        ),
                        DropdownMenuItem(
                          value: iraqRegions["2"][1],
                          child: Text(iraqRegions["2"][0]),
                        ),
                        DropdownMenuItem(
                          value: iraqRegions["3"][1],
                          child: Text(iraqRegions["3"][0]),
                        ),
                        DropdownMenuItem(
                          value: iraqRegions["4"][1],
                          child: Text(iraqRegions["4"][0]),
                        ),
                        DropdownMenuItem(
                          value: iraqRegions["5"][1],
                          child: Text(iraqRegions["5"][0]),
                        ),
                      ],
                      /*items: iraqRegions
                          .map((String item) => DropdownMenuItem<String>(
                              child: Text(item), value: item))
                          .toList(),*/
                      onChanged: (value) {
                        setState(() {
                          region = value;
                        });
                        print(region);
                      },
                      value: region,
                      dropdownColor: Colors.grey[300],
                      elevation: 5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: boxDecorationPatient,
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 16),
              child: Column(
                children: [
                  Center(
                    child: AutoSizeText(
                      AppLocalizations.of(context).translate('get_location'),
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.justify,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 2,
                    indent: 30,
                    endIndent: 30,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    width: double.maxFinite,
                    child: RaisedButton(
                      color: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      onPressed: () {
                        checkInternet();
                        if (_isInternet) {
                          _getCurrentLocation();
                          if (_currentPosition == null) {
                            setState(() {
                              _error = AppLocalizations.of(context)
                                  .translate("geolocator_message");
                            });
                            _showSnackBar();
                          } else {
                            setState(() {
                              MyVariables.speciality = FinalScore.speciality;
                              MyVariables.province = region;
                              //MyVariables.lat = double.parse(_currentPosition.latitude.toString() );
                              //MyVariables.long = double.parse(_currentPosition.longitude.toString() );
                              MyVariables.lat = _currentPosition.latitude;
                              MyVariables.long = _currentPosition.longitude;
                            });
                            Navigator.pushNamed(context, '/patient_result');
                          }
                        } else {
                          setState(() {
                            _error = AppLocalizations.of(context)
                                .translate('snack_connectivity');
                            ;
                          });
                          _showSnackBar();
                        }
                      },
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('auto_location'),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      AppLocalizations.of(context).translate('Or'),
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.maxFinite,
                    child: RaisedButton.icon(
                      color: Colors.deepOrange,
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      onPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PatientMap(
                                  speciality: FinalScore.speciality,
                                  province: region,
                                )));
                      },
                      label: Text(
                        AppLocalizations.of(context).translate('google_map'),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}

class MyVariables {
  static String speciality = '';
  static String speciality2 = '';
  static String province = '';
  static double lat = 0.0;
  static double long = 0.0;
}
