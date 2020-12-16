import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/pages/patient_pages/patient04_map.dart';
import 'package:project_doctor/matching_algorithm/final_score.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/sizing_information.dart';

class MyVariables {
  static String speciality = '';
  static String speciality2 = '';
  static String province = '';
  static double lat = 0.0;
  static double lng = 0.0;
}

class PatientGetLocation extends StatefulWidget {
  @override
  _PatientGetLocationState createState() => _PatientGetLocationState();
}

class _PatientGetLocationState extends State<PatientGetLocation> {
  String region;
  String _error = '';
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  // ignore: unused_field
  String _currentAddress;

  //function to show snackbar if the patient didn't
  // tap on the location
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    var lang = Localizations.localeOf(context).languageCode;

    final _snackBar = new SnackBar(
      content: Text(
        _error,
        style: TextStyle(fontSize: 15, fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
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
    // final iraqRegions = {
    //   "1": [AppLocalizations.of(context).translate('Baghdad'), "Baghdad"],
    //   "2": [AppLocalizations.of(context).translate('northen_region'), "Northern Region"],
    //   "3": [AppLocalizations.of(context).translate('southern_region'), "Southern Region"],
    //   "4": [AppLocalizations.of(context).translate('western_region'), "Eastern Region"],
    //   "5": [AppLocalizations.of(context).translate('Middle Region'), "Middle Region"],
    // };
    final province = {

      "1": [
        "Erbil",
        AppLocalizations.of(context).translate("Erbil"),
      ],
      "2": [
        "Al Anbar",
        AppLocalizations.of(context).translate("Al Anbar"),
      ],
      "3": [
        "Basra",
        AppLocalizations.of(context).translate("Basra"),
      ],
      "4": [
        "Al Qadisiyyah",
        AppLocalizations.of(context).translate("Al Qadisiyyah"),
      ],
      "5": [
        "Muthanna",
        AppLocalizations.of(context).translate("Muthanna"),
      ],
      "6": [
        "Najaf",
        AppLocalizations.of(context).translate("Najaf"),
      ],
      "7": [
        "Babil",
        AppLocalizations.of(context).translate("Babil"),
      ],
      "8": [
        'Baghdad',
        AppLocalizations.of(context).translate('Baghdad'),
      ],
      "9": ["Duhok", AppLocalizations.of(context).translate("Duhok")],
      "10": ["Diyala", AppLocalizations.of(context).translate("Diyala")],
      "11": ["Dhi Qar", AppLocalizations.of(context).translate("Dhi Qar")],
      "12": ["Sulaymaniyah", AppLocalizations.of(context).translate("Sulaymaniyah")],
      "13": ["Saladin", AppLocalizations.of(context).translate("Saladin")],
      "14": ["Karbala", AppLocalizations.of(context).translate("Karbala")],
      "15": ["Kirkuk", AppLocalizations.of(context).translate("Kirkuk")],
      "16": ["Maysan", AppLocalizations.of(context).translate("Maysan")],
      "17": ["Nineveh", AppLocalizations.of(context).translate("Nineveh")],
      "18": ["Wasit", AppLocalizations.of(context).translate("Wasit")],
    };
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      double appBarTitle;
      double appBarHeight;
      double containerHeight;
      double containerWidth;
      double buttonHeight;
      double buttonWidth;
      double title;

      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
        appBarTitle = 25;
        appBarHeight = 50;
        containerHeight = displayHeight(context) * 0.75;
        containerWidth = displayWidth(context) * 0.85;
        title = displayWidth(context) * 0.045;
        buttonHeight = displayHeight(context) * 0.05;
        buttonWidth = displayWidth(context) * 0.7;
      } else {
        appBarTitle = displayHeight(context) * 0.045;
        appBarHeight = 75;
        containerHeight = displayHeight(context) * 0.7;
        containerWidth = displayWidth(context) * 0.5;
        title = displayWidth(context) * 0.035;
        buttonHeight = displayHeight(context) * 0.04;
        buttonWidth = displayWidth(context) * 0.4;
      }
      return Scaffold(
        key: _scaffoldkey,
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: AppBar(
            backgroundColor: Colors.deepOrange,
            title: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                AppLocalizations.of(context).translate('region'),
                style: TextStyle(fontSize: appBarTitle, fontWeight: FontWeight.bold),
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
        ),
        body: Center(
          child: Container(
            height: containerHeight,
            width: containerWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: boxDecoration,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context).translate('province'),
                        style: TextStyle(fontSize: title, fontWeight: FontWeight.bold),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 2,
                        indent: 30,
                        endIndent: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        child: DropdownButton(
                          hint: Text(
                            AppLocalizations.of(context).translate('select_region'),
                          ),
                          isExpanded: true,
                         items: [
                        DropdownMenuItem(
                          value: province["1"][0],
                          child: Text(province["1"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["2"][0],
                          child: Text(province["2"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["3"][0],
                          child: Text(province["3"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["4"][0],
                          child: Text(province["4"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["5"][0],
                          child: Text(province["5"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["6"][0],
                          child: Text(province["6"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["7"][0],
                          child: Text(province["7"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["8"][0],
                          child: Text(province["8"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["9"][0],
                          child: Text(province["9"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["10"][0],
                          child: Text(province["10"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["11"][0],
                          child: Text(province["11"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["12"][0],
                          child: Text(province["12"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["13"][0],
                          child: Text(province["13"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["14"][0],
                          child: Text(province["14"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["15"][0],
                          child: Text(province["15"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["16"][0],
                          child: Text(province["16"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["17"][0],
                          child: Text(province["17"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["18"][0],
                          child: Text(province["18"][1]),
                        ),
                      ],
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
                  decoration: boxDecoration,
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 16),
                  child: Column(
                    children: [
                      Center(
                        child: AutoSizeText(
                          AppLocalizations.of(context).translate('get_location'),
                          style: TextStyle(fontSize: title, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
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
                        height: buttonHeight,
                        width: buttonWidth,
                        child: RaisedButton(
                          color: Colors.deepOrange,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                          onPressed: () {
                            checkInternet();
                            if (_isInternet) {
                              _getCurrentLocation();
                              if (_currentPosition == null) {
                                setState(() {
                                  _error = AppLocalizations.of(context).translate("geolocator_message");
                                });
                                _showSnackBar();
                              } else {
                                setState(() {
                                  MyVariables.speciality = FinalScore.speciality;
                                  MyVariables.province = region;
                                  //MyVariables.lat = double.parse(_currentPosition.latitude.toString() );
                                  //MyVariables.long = double.parse(_currentPosition.longitude.toString() );
                                  MyVariables.lat = _currentPosition.latitude;
                                  MyVariables.lng = _currentPosition.longitude;
                                });
                                Navigator.pushNamed(context, '/patient_result');
                              }
                            } else {
                              setState(() {
                                _error = AppLocalizations.of(context).translate('snack_connectivity');
                              });
                              _showSnackBar();
                            }
                          },
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              AppLocalizations.of(context).translate('auto_location'),
                              style: TextStyle(color: Colors.white, fontSize: title, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          AppLocalizations.of(context).translate('Or'),
                          style: TextStyle(fontSize: title, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: buttonHeight,
                        width: buttonWidth,
                        child: RaisedButton.icon(
                          color: Colors.deepOrange,
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                          onPressed: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PatientMap(
                                      speciality: FinalScore.speciality,
                                      province: region,
                                    )));
                          },
                          label: Text(
                            AppLocalizations.of(context).translate('google_map'),
                            style: TextStyle(color: Colors.white, fontSize: title, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  _getCurrentLocation() {
    geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position position) {
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
      List<Placemark> p = await geolocator.placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        _currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}
