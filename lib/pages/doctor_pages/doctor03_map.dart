import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/authorization/loading.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/database.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth.dart';

class DataFromMaptoVerify {
  static String email = '';
  static String password = '';
  static String name = '';
  static String speciality = '';
  static String phoneNumber = '';
  static String province = '';
  static String address = '';
  static List<String> workDays01 = [];
  static List<String> workDays02 = [];
  static List<String> workDays03 = [];
  static double lattt = 0.0;
  static double lnggg = 0.0;
}

class DocMap extends StatefulWidget {
  @override
  _DocMapState createState() => _DocMapState();
}

class _DocMapState extends State<DocMap> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : StreamProvider<QuerySnapshot>.value(
            value: DatabaseService().basicData,
            child: FinalMap(),
          );
  }
}

class FinalMap extends StatefulWidget {
  @override
  _FinalMapState createState() => _FinalMapState();
}

class _FinalMapState extends State<FinalMap> {
  final AuthService _auth = AuthService();

  var latlng;

  List<Marker> mymarker = [];

  handletap(LatLng tappedpoint) {
    print(tappedpoint);
    latlng = tappedpoint.toString();
    setState(() {
      mymarker = [];
      mymarker.add(Marker(
        markerId: MarkerId(latlng),
        position: tappedpoint,
      ));
    });
  }

  double lattt = 0.0;
  double lnggg = 0.0;

  geolocate({String latlng}) {
    var firstindex = latlng.indexOf('(');
    var secondindex = latlng.indexOf(',');
    var thirdindex = latlng.indexOf(')');
    String lat = latlng.substring(firstindex + 1, secondindex);
    String lng = latlng.substring(secondindex + 1, thirdindex);

    lattt = double.parse(lat);
    lnggg = double.parse(lng);
  }

  //function to show a snackbar if the user didn't tap on the location
  String error = '';
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  _showSnackBar() {
    var lang = Localizations.localeOf(context).languageCode;

    final _snackBar = new SnackBar(
      content: Text(
        error,
        style: TextStyle(fontSize: 15, fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
      ),
      backgroundColor: Colors.deepOrange,
    );
    _scaffoldkey.currentState.showSnackBar(_snackBar);
  }

  //==========================checking internet connection
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

  //=================vars For testing=========
  String n = '';
  String s = '';
  double lt = 0.0;
  double lg = 0.0;
  double finalDistance = 0.0;
  double finalResult = 0.0;
  double kmDistance = 0.0;
  bool isValidUser = false;
  @override
  Widget build(BuildContext context) {
    final basicData = Provider.of<QuerySnapshot>(context);
    if (basicData != null) {
      for (var x in basicData.docs) {
        if (DataFromMaptoVerify.name == x.data()['n'] && DataFromMaptoVerify.speciality == x.data()['s']) {
          isValidUser = true;
          lt = x.data()['lt'];
          lg = x.data()['lg'];
        }
      }
    }
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            AppLocalizations.of(context).translate('add_location'),
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: LatLng(33.312805, 44.361488), zoom: 10),
            markers: Set.from(mymarker),
            onTap: handletap,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context).translate("zoom_in_out"),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppLocalizations.of(context).translate("zoom_in"),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppLocalizations.of(context).translate("zoom_out"),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(vertical: 45.0, horizontal: 15.0),
            child: FloatingActionButton(
              backgroundColor: Colors.deepOrange,
              child: Text(
                AppLocalizations.of(context).translate('ok'),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                checkInternet();
                if (_isInternet) {
                  if (latlng == null) {
                    error = AppLocalizations.of(context).translate('snack_map');
                    _showSnackBar();
                  } else {
                    await geolocate(latlng: latlng);

                    if (lattt != null && lnggg != null) {
                      setState(() {
                        finalResult = pow((lattt - lt), 2) + pow((lnggg - lg), 2);
                        finalDistance = sqrt(finalResult);
                        kmDistance = finalDistance * 100;
                      });
                      //========Navigation to EmailVerification without the following
                      // condition is a bug(emails Already in use can navigate)
                      //------ direct navigation to the emailverfied widget will
                      // give a fake page (when pressing continue) it will not respond)
                      // I found put wrapper and transferred email by another method
                      //--------------at least 10 km away from bashar abbas---------------
                      if (kmDistance < 100.0) {
                        final authResult = await _auth.registerWithEmailAndPassword(DataFromMaptoVerify.email, DataFromMaptoVerify.password);
                        if (authResult != null) {
                          setState(() {
                            DataFromMaptoVerify.lattt = lattt;
                            DataFromMaptoVerify.lnggg = lnggg;
                          });
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          setState(() {
                            prefs.setString('name', DataFromMaptoVerify.name);
                            prefs.setString('speciality', DataFromMaptoVerify.speciality);
                            prefs.setString('phoneNumber', DataFromMaptoVerify.phoneNumber);
                            prefs.setString('province', DataFromMaptoVerify.province);
                            prefs.setString('address', DataFromMaptoVerify.address);
                            prefs.setDouble('lat', lattt);
                            prefs.setDouble('lng', lnggg);
                            prefs.setStringList('workDays01', DataFromMaptoVerify.workDays01);
                            prefs.setStringList('workDays02', DataFromMaptoVerify.workDays02);
                            prefs.setStringList('workDays03', DataFromMaptoVerify.workDays03);
                          });
                          int count = 0;
                          Navigator.popUntil(context, (route) {
                            return count++ == 3;
                          });
                        } else {
                          setState(() {
                            error = AppLocalizations.of(context).translate('snack_register');
                          });
                          _showSnackBar();
                        }
                      } else {
                        setState(() {
                          error = AppLocalizations.of(context).translate('snack_register');
                        });
                        _showSnackBar();
                      }
                    }
                  }
                } else {
                  setState(() {
                    error = AppLocalizations.of(context).translate('snack_connectivity');
                  });
                }
                _showSnackBar();
              },
            ),
          ),
        ],
      ),
    );
  }
}
