import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/authorization/01_wrapper.dart';
import 'package:project_doctor/authorization/loading.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/database.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth.dart';

class DocMap extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  final String speciality;
  final String phone;
  final String province;
  final String address;
  final List<String> workDays01;
  final List<String> workDays02;
  final List<String> workDays03;

  DocMap(
      {this.email,
      this.password,
      this.name,
      this.speciality,
      this.phone,
      this.province,
      this.address,
      this.workDays01,
      this.workDays02,
      this.workDays03});
  @override
  _DocMapState createState() => _DocMapState(
      email: email,
      password: password,
      name: name,
      speciality: speciality,
      phoneNumber: phone,
      province: province,
      address: address,
      workDays01: workDays01,
      workDays02: workDays02,
      workDays03: workDays03);
}

class _DocMapState extends State<DocMap> {
  String email = '';
  String password = '';
  String name = '';
  String speciality = '';
  String phoneNumber = '';
  String province = '';
  String address = '';
  List<String> workDays01 = [];
  List<String> workDays02 = [];
  List<String> workDays03 = [];
  bool loading = false;

  _DocMapState(
      {this.email,
      this.password,
      this.name,
      this.speciality,
      this.phoneNumber,
      this.province,
      this.address,
      this.workDays01,
      this.workDays02,
      this.workDays03});
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
  String email = DataFromMaptoVerify.email;
  String password = DataFromMaptoVerify.password;
  String name = DataFromMaptoVerify.name;
  String speciality = DataFromMaptoVerify.speciality;
  String phoneNumber = DataFromMaptoVerify.phoneNumber;
  String province = DataFromMaptoVerify.province;
  String address = DataFromMaptoVerify.address;
  List workDays01 = DataFromMaptoVerify.workDays01;
  List workDays02 = DataFromMaptoVerify.workDays02;
  List workDays03 = DataFromMaptoVerify.workDays03;

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
        style: TextStyle(
            fontSize: 15,
            fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
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
        print(x.data()['n']);
        print(x.data()['s']);
        print(x.data()['lt']);
        print(x.data()['lg']);
        n = x.data()['n'];
        s = x.data()['s'];

        if (DataFromMaptoVerify.name == x.data()['n'] &&
            DataFromMaptoVerify.speciality == x.data()['s']) {
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
            initialCameraPosition:
                CameraPosition(target: LatLng(33.312805, 44.361488), zoom: 10),
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
                print([n, s, lt, lg]);

                checkInternet();
                if (_isInternet) {
                  if (latlng == null) {
                    error = AppLocalizations.of(context).translate('snack_map');
                    _showSnackBar();
                  } else {
                    await geolocate(latlng: latlng);

                    if (lattt != null && lnggg != null) {
                      setState(() {
                        finalResult = ((lattt - lt) * (lattt - lt)) +
                            ((lnggg - lg) * (lg - lnggg));
                        finalDistance = sqrt(finalResult);
                        kmDistance = finalDistance * 0.01;
                      });

                      //if (kmDistance < 5000000.0) {
                      /*setState(() {
                          /*DataFromMaptoVerify.email = email;
                          DataFromMaptoVerify.name = name;
                          DataFromMaptoVerify.speciality = speciality;
                          DataFromMaptoVerify.phoneNumber = phoneNumber;
                          DataFromMaptoVerify.province = province;
                          DataFromMaptoVerify.address = address;
                          DataFromMaptoVerify.workDays01 = workDays01;
                          DataFromMaptoVerify.workDays02 = workDays02;
                          DataFromMaptoVerify.workDays03 = workDays03;*/
                          DataFromMaptoVerify.lat = lattt;
                          DataFromMaptoVerify.lng = lnggg;
                        });*/
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      setState(() {
                        prefs.setString('email', email);
                        prefs.setString('name', name);
                        prefs.setString('speciality', speciality);
                        prefs.setString('phoneNumber', phoneNumber);
                        prefs.setString('province', province);
                        prefs.setString('address', address);
                        prefs.setDouble('lat', lattt);
                        prefs.setDouble('lng', lnggg);
                        prefs.setStringList('workDays01', workDays01);
                        prefs.setStringList('workDays02', workDays02);
                        prefs.setStringList('workDays03', workDays03);
                      });
                      //========Navigation to EmailVerification without the following
                      // condition is a bug(emails Already in use can navigate)
                      //------ direct navigation to the emailverfied widget will
                      // give a fake page (when pressing continue) it will not respond)
                      // I found put wrapper and transferred email by another method
                      dynamic authResult = await _auth
                          .registerWithEmailAndPassword(email, password);
                      if (authResult != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Intermediate(),
                          ),
                        );
                      } else {
                        setState(() {
                          error = AppLocalizations.of(context)
                              .translate('snack_register');
                        });
                        _showSnackBar();
                      }
                      /*} else {
                        setState(() {
                          error = 'Try again later';
                        });
                        _showSnackBar();
                      }*/
                    }
                  }
                } else {
                  setState(() {
                    error = AppLocalizations.of(context)
                        .translate('snack_connectivity');
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

class DataFromMaptoVerify {
  static String email = '';
  static String password = '';
  static String name = '';
  static String speciality = '';
  static String phoneNumber = '';
  static String province = '';
  static String address = '';
  static List workDays01 = [];
  static List workDays02 = [];
  static List workDays03 = [];
  static double lat = 0.0;
  static double lng = 0.0;
}
