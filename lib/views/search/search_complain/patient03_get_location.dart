import 'dart:io';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/constants/loading_delete.dart';
import 'package:project_doctor/matching_algorithm/final_score.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:project_doctor/services/database.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/search/search_complain/patient04_map.dart';

class MyVariables {
  static String speciality = '';
  static String speciality2 = '';
  static String province = '';
  static double lat = 0.0;
  static double lng = 0.0;
  static bool usingMap = false;
  static String geoLatlng = '';
  static double geolat = 0.0;
  static double geolng = 0.0;
}

class PatientGetLocation extends StatefulWidget {
  @override
  _PatientGetLocationState createState() => _PatientGetLocationState();
}

class _PatientGetLocationState extends State<PatientGetLocation> {
  String region;
  String _error = '';
  //final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  //ignore unused feild
  //String _currentAddress;

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

  getCoordinatesFromAddress(String address) async {
    try {
      String latlng;
      final query = address;
      var addresses = await Geocoder.local.findAddressesFromQuery(query);
      var first = addresses.first;
      latlng = "${first.coordinates}";
      return latlng;
    } catch (e) {
      print(e);
      return '{0.0,0.0}';
    }
  }

  bool isLoading01 = false;
  bool isLoading02 = false;
  @override
  void initState() {
    checkInternet();
    super.initState();
    MyVariables.usingMap = false;
    isLoading01 = false;
    isLoading02 = false;
  }

  @override
  Widget build(BuildContext context) {
    final province = {
      "1": [
        "Erbil",
        ("Erbil").tr(),
      ],
      "2": [
        "Al Anbar",
        ("Al Anbar").tr(),
      ],
      "3": [
        "Basra",
        ("Basra").tr(),
      ],
      "4": [
        "Al Qadisiyyah",
        ("Al Qadisiyyah").tr(),
      ],
      "5": [
        "Muthanna",
        ("Muthanna").tr(),
      ],
      "6": [
        "Najaf",
        ("Najaf").tr(),
      ],
      "7": [
        "Babil",
        ("Babil").tr(),
      ],
      "8": [
        'Baghdad',
        ('Baghdad').tr(),
      ],
      "9": ["Duhok", ("Duhok").tr(),],
      "10": ["Diyala", ("Diyala").tr(),],
      "11": ["Dhi Qar", ("Dhi Qar").tr(),],
      "12": ["Sulaymaniyah", ("Sulaymaniyah").tr(),],
      "13": ["Saladin", ("Saladin").tr(),],
      "14": ["Karbala", ("Karbala").tr(),],
      "15": ["Kirkuk", ("Kirkuk").tr(),],
      "16": ["Maysan", ("Maysan").tr(),],
      "17": ["Nineveh", ("Nineveh").tr(),],
      "18": ["Wasit", ("Wasit").tr(),],
    };
    final district = {
      "Erbil": "ازادي",
      "Al Anbar": "الرمادي",
      "Basra": "الزبير",
      "Al Qadisiyyah": "الديوانية",
      "Muthanna": "السماوة",
      "Najaf": "حي السلام",
      "Babil": "الحلة",
      "Baghdad": "الحارثية",
      "Duhok": "زاخو",
      "Diyala": "بعقوبة",
      "Dhi Qar": "الشطرة",
      "Sulaymaniyah": "شورش",
      "Saladin": "سامراء",
      "Karbala": "التحدي",
      "Kirkuk": "بنجة علي",
      "Maysan": "العمارة",
      "Nineveh": "الموصل",
      "Wasit": "الكوت"
    };
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.deepOrange,
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
                      LocaleKeys.view_patient_region.tr(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
      ),
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: CStyle.box,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  children: [
                    Text(
                      LocaleKeys.view_doctor_province.tr(),
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 2,
                      indent: 30,
                      endIndent: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: DropdownButtonFormField(
                        hint: Text(
                                                LocaleKeys.view_patient_select_region.tr(),

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
                          setState(() => region = value);
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
                decoration: CStyle.box,
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 16),
                child: Column(
                  children: [
                    Center(
                      child: AutoSizeText(
                                              LocaleKeys.view_patient_get_location.tr(),

                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                      height: 50,
                      width: isLoading01 ? 50 : 150,
                      child: LoadingButton(
                        isloading: isLoading01,
                        backgroundcolor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        onpressed: () async {
                          setState(() => isLoading01 = true);
                          checkInternet();
                          if (!(region == null || region == '')) {
                            if (_isInternet) {
                              MyVariables.geoLatlng = await getCoordinatesFromAddress(region + ',' + district[region]);
                              MyVariables.geolat = double.parse(
                                  MyVariables.geoLatlng.substring(MyVariables.geoLatlng.indexOf('{') + 1, MyVariables.geoLatlng.indexOf(',')));
                              MyVariables.geolng = double.parse(
                                  MyVariables.geoLatlng.substring(MyVariables.geoLatlng.indexOf(',') + 1, MyVariables.geoLatlng.indexOf('}')));
                              await _getCurrentLocation();
                              if (_currentPosition == null) {
                                setState(() {
                                  _error = ("geolocator_message");
                                });
                                _showSnackBar();
                              } else {
                                setState(() {
                                  MyVariables.speciality = FinalScore.speciality;
                                  MyVariables.province = region;
                                  DatabaseService.province = region;
                                  MyVariables.lat = _currentPosition.latitude;
                                  MyVariables.lng = _currentPosition.longitude;
                                });
                                double sum = pow(MyVariables.geolat - MyVariables.lat, 2) + pow(MyVariables.geolng - MyVariables.lng, 2);
                                double result = sqrt(sum);
                                if (result * 100 < 100) {
                                  setState(() => MyVariables.usingMap = false);
                                  Navigator.pushNamed(context, '/patient_result');
                                } else {
                                  _error = ('invalid device location');
                                  _showSnackBar();
                                }
                              }
                            } else {
                              setState(() {
                                // _error = LocaleKeys.view_snack_error_snack_connectivity.tr();
                              });
                              _showSnackBar();
                            }
                          } else {
                            setState(() => _error = ('province_validator'));
                            _showSnackBar();
                          }
                          setState(() => isLoading01 = false);
                        },
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            ('auto_location'),
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        ('Or'),
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: isLoading02 ? 50 : 150,
                      child: LoadingButtonIcon(
                        isloading: isLoading02,
                        backgroundcolor: Colors.deepOrange,
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        onpressed: () async {
                          setState(() => isLoading02 = true);
                          if (!(region == null || region == '')) {
                            setState(() {
                              MyVariables.usingMap = true;
                              DatabaseService.province = region;
                            });
                            MyVariables.geoLatlng = await getCoordinatesFromAddress(region + ',' + district[region]);
                            MyVariables.geolat = double.parse(
                                MyVariables.geoLatlng.substring(MyVariables.geoLatlng.indexOf('{') + 1, MyVariables.geoLatlng.indexOf(',')));
                            MyVariables.geolng = double.parse(
                                MyVariables.geoLatlng.substring(MyVariables.geoLatlng.indexOf(',') + 1, MyVariables.geoLatlng.indexOf('}')));
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PatientMap(
                                  speciality: FinalScore.speciality,
                                  province: region,
                                ),
                              ),
                            );
                          } else {
                            setState(() => _error = ('province_validator'));
                            _showSnackBar();
                          }
                          setState(() => isLoading02 = false);
                        },
                        label: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            LocaleKeys.view_buttons_google_map.tr(),
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
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
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      //_getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  /*_getAddressFromLatLng() async {
    try {
      List<PlaceMark> p = await geolocator.placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        _currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }*/
}
