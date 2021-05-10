import 'dart:io';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/services/data_model.dart';

class PatientLocation extends StatefulWidget {
  @override
  _PatientLocationState createState() => _PatientLocationState();
}

class _PatientLocationState extends State<PatientLocation> {
  bool isLoading01 = false;
  bool isLoading02 = false;
  @override
  void initState() {
    super.initState();
    isLoading01 = false;
    isLoading02 = false;
    SearchResultData.patientProvince = '';
  }

  String _error = '';

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

  Position _currentPosition;
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

  @override
  Widget build(BuildContext context) {
    final province = {
      "1": [
        "Erbil",
        LocaleKeys.iraq_provinces_Erbil.tr(),
      ],
      "2": [
        "Al Anbar",
        LocaleKeys.iraq_provinces_Al_Anbar.tr(),
      ],
      "3": [
        "Basra",
        LocaleKeys.iraq_provinces_Basra.tr(),
      ],
      "4": [
        "Al Qadisiyyah",
        LocaleKeys.iraq_provinces_Al_Qadisiyyah.tr(),
      ],
      "5": [
        "Muthanna",
        LocaleKeys.iraq_provinces_Muthanna.tr(),
      ],
      "6": [
        "Najaf",
        LocaleKeys.iraq_provinces_Najaf.tr(),
      ],
      "7": [
        "Babil",
        LocaleKeys.iraq_provinces_Babil.tr(),
      ],
      "8": [
        'Baghdad',
        LocaleKeys.iraq_provinces_Baghdad.tr(),
      ],
      "9": [
        "Duhok",
        LocaleKeys.iraq_provinces_Duhok.tr(),
      ],
      "10": [
        "Diyala",
        LocaleKeys.iraq_provinces_Diyala.tr(),
      ],
      "11": [
        "Dhi Qar",
        LocaleKeys.iraq_provinces_Dhi_Qar.tr(),
      ],
      "12": [
        "Sulaymaniyah",
        LocaleKeys.iraq_provinces_Sulaymaniyah.tr(),
      ],
      "13": [
        "Saladin",
        LocaleKeys.iraq_provinces_Saladin.tr(),
      ],
      "14": [
        "Karbala",
        LocaleKeys.iraq_provinces_Karbala.tr(),
      ],
      "15": [
        "Kirkuk",
        LocaleKeys.iraq_provinces_Kirkuk.tr(),
      ],
      "16": [
        "Maysan",
        LocaleKeys.iraq_provinces_Maysan.tr(),
      ],
      "17": [
        "Nineveh",
        LocaleKeys.iraq_provinces_Nineveh.tr(),
      ],
      "18": [
        "Wasit",
        LocaleKeys.iraq_provinces_Wasit.tr(),
      ],
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
        preferredSize: Size.fromHeight(
          getDeviceType(context, 36, 56, 56, 56),
        ),
        child: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            LocaleKeys.view_search_result_list_your_location.tr(),
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
      body: Center(
        child: Container(
          height: getDeviceType(context, 500, 620, 800, 800),
          width: getDeviceType(context, 200, 340, 600, 600),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: CStyle.box,
                padding: EdgeInsets.symmetric(
                  vertical: getDeviceType(context, 4, 8, 12, 16),
                  horizontal: getDeviceType(context, 12, 16, 20, 24),
                ),
                child: Column(
                  children: [
                    Text(
                      LocaleKeys.view_doctor_province.tr(),
                      style: TextStyle(fontSize: getDeviceType(context, 15, 18, 21, 24), fontWeight: FontWeight.bold),
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
                          setState(() => SearchResultData.patientProvince = value);
                        },
                        //value: SearchResultData.patientProvince,
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
                        style: TextStyle(fontSize: getDeviceType(context, 15, 18, 21, 24), fontWeight: FontWeight.bold),
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
                      height: getDeviceType(context, 30, 40, 50, 60),
                      width: isLoading01 ? getDeviceType(context, 30, 40, 50, 60) : getDeviceType(context, 130, 260, 150, 160),
                      child: CustomLoadingButton(

                        onPressed: () async {
                          setState(() => isLoading01 = true);
                          checkInternet();
                          if (!(SearchResultData.patientProvince == null || SearchResultData.patientProvince == '')) {
                            if (_isInternet) {
                              SearchResultData.geoLatlng = await getCoordinatesFromAddress(
                                  SearchResultData.patientProvince + ' , ' + district[SearchResultData.patientProvince]);
                              SearchResultData.geoLat = double.parse(SearchResultData.geoLatlng
                                  .substring(SearchResultData.geoLatlng.indexOf('{') + 1, SearchResultData.geoLatlng.indexOf(',')));
                              SearchResultData.geoLng = double.parse(SearchResultData.geoLatlng
                                  .substring(SearchResultData.geoLatlng.indexOf(',') + 1, SearchResultData.geoLatlng.indexOf('}')));
                              await _getCurrentLocation();
                              if (_currentPosition == null) {
                                setState(() {
                                  _error = LocaleKeys.error_geolocator_message.tr();
                                });
                                _showSnackBar();
                              } else {
                                setState(() {
                                  SearchResultData.patientLat = _currentPosition.latitude;
                                  SearchResultData.patientLng = _currentPosition.longitude;
                                });
                                double sum = pow(SearchResultData.geoLat - SearchResultData.patientLat, 2) +
                                    pow(SearchResultData.geoLng - SearchResultData.patientLng, 2);
                                double result = sqrt(sum);
                                if (result * 100 < 100) {
                                  // setState(() => SearchResultData.usingMap = false);
                                  SearchResultData.distance = await SearchResultData().getDistance(
                                      SearchResultData.patientLat, SearchResultData.patientLng, SearchResultData.lat, SearchResultData.lng);
                                  setState(() => SearchResultData.mapSelected = false);
                                  Navigator.pushNamed(context, '/search resultview');
                                } else {
                                  _error = LocaleKeys.view_patient_invalid_device_location.tr();
                                  _showSnackBar();
                                }
                              }
                            } else {
                              setState(() {
                                _error = LocaleKeys.error_snack_connectivity.tr();
                              });
                              _showSnackBar();
                            }
                          } else {
                            setState(
                              () => _error = LocaleKeys.view_doctor_province_validator.tr(),
                            );
                            _showSnackBar();
                          }
                          setState(() => isLoading01 = false);
                        },
                        title: LocaleKeys.view_patient_invalid_device_location.tr(),
                      
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        LocaleKeys.view_buttons_Or.tr(),
                        style: TextStyle(fontSize: getDeviceType(context, 15, 18, 21, 24), fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: getDeviceType(context, 30, 40, 50, 60),
                      width: isLoading02 ? getDeviceType(context, 30, 40, 50, 60) : getDeviceType(context, 130, 260, 150, 160),
                      child: CustomLoadingButton(
                       
                        onPressed: () async {
                          setState(() => isLoading02 = true);
                          if (!(SearchResultData.patientProvince == null || SearchResultData.patientProvince == '')) {
                            SearchResultData.geoLatlng = await getCoordinatesFromAddress(
                                SearchResultData.patientProvince + ' , ' + district[SearchResultData.patientProvince]);
                            SearchResultData.geoLat = double.parse(SearchResultData.geoLatlng
                                .substring(SearchResultData.geoLatlng.indexOf('{') + 1, SearchResultData.geoLatlng.indexOf(',')));
                            SearchResultData.geoLng = double.parse(SearchResultData.geoLatlng
                                .substring(SearchResultData.geoLatlng.indexOf(',') + 1, SearchResultData.geoLatlng.indexOf('}')));
                            setState(() => SearchResultData.mapSelected = true);
                            print(SearchResultData.geoLatlng);
                            Navigator.pushNamed(context, '/patient searchmap');
                          } else {
                            setState(
                              () => _error = LocaleKeys.view_doctor_province_validator.tr(),
                            );
                            _showSnackBar();
                          }
                          setState(() => isLoading02 = false);
                        },
                        title: LocaleKeys.view_buttons_google_map.tr(),
                      
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
}
