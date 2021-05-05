import 'dart:io';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/services/theme.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/views/authorization/loading.dart';

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
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
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
      "12": [
        "Sulaymaniyah",
        AppLocalizations.of(context).translate("Sulaymaniyah")
      ],
      "13": ["Saladin", AppLocalizations.of(context).translate("Saladin")],
      "14": ["Karbala", AppLocalizations.of(context).translate("Karbala")],
      "15": ["Kirkuk", AppLocalizations.of(context).translate("Kirkuk")],
      "16": ["Maysan", AppLocalizations.of(context).translate("Maysan")],
      "17": ["Nineveh", AppLocalizations.of(context).translate("Nineveh")],
      "18": ["Wasit", AppLocalizations.of(context).translate("Wasit")],
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
            AppLocalizations.of(context).translate('your location'),
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
                decoration: boxDecoration,
                padding: EdgeInsets.symmetric(
                  vertical: getDeviceType(context, 4, 8, 12, 16),
                  horizontal: getDeviceType(context, 12, 16, 20, 24),
                ),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context).translate('province'),
                      style: TextStyle(
                          fontSize: getDeviceType(context, 15, 18, 21, 24),
                          fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 2,
                      indent: 30,
                      endIndent: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      child: DropdownButtonFormField(
                        hint: Text(
                          AppLocalizations.of(context)
                              .translate('select_region'),
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
                          setState(
                              () => SearchResultData.patientProvince = value);
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
                decoration: boxDecoration,
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 16),
                child: Column(
                  children: [
                    Center(
                      child: AutoSizeText(
                        AppLocalizations.of(context).translate('get_location'),
                        style: TextStyle(
                            fontSize: getDeviceType(context, 15, 18, 21, 24),
                            fontWeight: FontWeight.bold),
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
                      width: isLoading01
                          ? getDeviceType(context, 30, 40, 50, 60)
                          : getDeviceType(context, 130, 260, 150, 160),
                      child: LoadingButton(
                        isloading: isLoading01,
                        backgroundcolor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        onpressed: () async {
                          setState(() => isLoading01 = true);
                          checkInternet();
                          if (!(SearchResultData.patientProvince == null ||
                              SearchResultData.patientProvince == '')) {
                            if (_isInternet) {
                              SearchResultData.geoLatlng =
                                  await getCoordinatesFromAddress(
                                      SearchResultData.patientProvince +
                                          ' , ' +
                                          district[SearchResultData
                                              .patientProvince]);
                              SearchResultData.geoLat = double.parse(
                                  SearchResultData.geoLatlng.substring(
                                      SearchResultData.geoLatlng.indexOf('{') +
                                          1,
                                      SearchResultData.geoLatlng.indexOf(',')));
                              SearchResultData.geoLng = double.parse(
                                  SearchResultData.geoLatlng.substring(
                                      SearchResultData.geoLatlng.indexOf(',') +
                                          1,
                                      SearchResultData.geoLatlng.indexOf('}')));
                              await _getCurrentLocation();
                              if (_currentPosition == null) {
                                setState(() {
                                  _error = AppLocalizations.of(context)
                                      .translate("geolocator_message");
                                });
                                _showSnackBar();
                              } else {
                                setState(() {
                                  SearchResultData.patientLat =
                                      _currentPosition.latitude;
                                  SearchResultData.patientLng =
                                      _currentPosition.longitude;
                                });
                                double sum = pow(
                                        SearchResultData.geoLat -
                                            SearchResultData.patientLat,
                                        2) +
                                    pow(
                                        SearchResultData.geoLng -
                                            SearchResultData.patientLng,
                                        2);
                                double result = sqrt(sum);
                                if (result * 100 < 100) {
                                  // setState(() => SearchResultData.usingMap = false);
                                  SearchResultData.distance =
                                      await SearchResultData().getDistance(
                                          SearchResultData.patientLat,
                                          SearchResultData.patientLng,
                                          SearchResultData.lat,
                                          SearchResultData.lng);
                                  setState(() =>
                                      SearchResultData.mapSelected = false);
                                  Navigator.pushNamed(
                                      context, '/search resultview');
                                } else {
                                  _error = AppLocalizations.of(context)
                                      .translate('invalid device location');
                                  _showSnackBar();
                                }
                              }
                            } else {
                              setState(() {
                                _error = AppLocalizations.of(context)
                                    .translate('snack_connectivity');
                              });
                              _showSnackBar();
                            }
                          } else {
                            setState(() => _error = AppLocalizations.of(context)
                                .translate('province_validator'));
                            _showSnackBar();
                          }
                          setState(() => isLoading01 = false);
                        },
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('auto_location'),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    getDeviceType(context, 15, 18, 21, 24),
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
                            fontSize: getDeviceType(context, 15, 18, 21, 24),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: getDeviceType(context, 30, 40, 50, 60),
                      width: isLoading02
                          ? getDeviceType(context, 30, 40, 50, 60)
                          : getDeviceType(context, 130, 260, 150, 160),
                      child: LoadingButtonIcon(
                        isloading: isLoading02,
                        backgroundcolor: Colors.deepOrange,
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        onpressed: () async {
                          setState(() => isLoading02 = true);
                          if (!(SearchResultData.patientProvince == null ||
                              SearchResultData.patientProvince == '')) {
                            SearchResultData.geoLatlng =
                                await getCoordinatesFromAddress(SearchResultData
                                        .patientProvince +
                                    ' , ' +
                                    district[SearchResultData.patientProvince]);
                            SearchResultData.geoLat = double.parse(
                                SearchResultData.geoLatlng.substring(
                                    SearchResultData.geoLatlng.indexOf('{') + 1,
                                    SearchResultData.geoLatlng.indexOf(',')));
                            SearchResultData.geoLng = double.parse(
                                SearchResultData.geoLatlng.substring(
                                    SearchResultData.geoLatlng.indexOf(',') + 1,
                                    SearchResultData.geoLatlng.indexOf('}')));
                            setState(() => SearchResultData.mapSelected = true);
                            print(SearchResultData.geoLatlng);
                            Navigator.pushNamed(context, '/patient searchmap');
                          } else {
                            setState(() => _error = AppLocalizations.of(context)
                                .translate('province_validator'));
                            _showSnackBar();
                          }
                          setState(() => isLoading02 = false);
                        },
                        label: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('google_map'),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    getDeviceType(context, 15, 18, 21, 24),
                                fontWeight: FontWeight.bold),
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
}
