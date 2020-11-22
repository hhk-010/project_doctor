import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/authorization/email_verfication.dart';
import 'package:project_doctor/authorization/01_wrapper.dart';
import 'package:project_doctor/authorization/loading.dart';
import 'package:project_doctor/services/app_localizations.dart';
import '../../services/auth.dart';

class DocMap extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  final String speciality;
  final String phone;
  final String province;
  final String address;
  final List workDays01;
  final List workDays02;
  final List workDays03;

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
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';
  String name = '';
  String speciality = '';
  String phoneNumber = '';
  String province = '';
  String address = '';
  List workDays01 = [];
  List workDays02 = [];
  List workDays03 = [];
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
  String error = '';
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

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
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
                  initialCameraPosition: CameraPosition(
                      target: LatLng(33.312805, 44.361488), zoom: 10),
                  markers: Set.from(mymarker),
                  onTap: handletap,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
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
                  padding:
                      EdgeInsets.symmetric(vertical: 45.0, horizontal: 15.0),
                  child: FloatingActionButton(
                    backgroundColor: Colors.deepOrange,
                    child: Text(
                      AppLocalizations.of(context).translate('ok'),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      checkInternet();
                      if (_isInternet) {
                        if (latlng == null) {
                          error = AppLocalizations.of(context)
                              .translate('snack_map');
                          _showSnackBar();
                        } else {
                          await geolocate(latlng: latlng);
                          if (lattt != null && lnggg != null) {
                            dynamic authResult =
                                await _auth.registerWithEmailAndPassword(
                              email,
                              password,
                            );
                            setState(() {
                              DataFromMaptoVerify.email = email;
                                                            DataFromMaptoVerify.name = name;

                              DataFromMaptoVerify.speciality = speciality;
                              DataFromMaptoVerify.phoneNumber = phoneNumber;
                              DataFromMaptoVerify.province = province;
                              DataFromMaptoVerify.address = address;
                              DataFromMaptoVerify.workDays01 = workDays01;
                              DataFromMaptoVerify.workDays02 = workDays02;
                              DataFromMaptoVerify.workDays03 = workDays03;
                              DataFromMaptoVerify.lat = lattt;
                              DataFromMaptoVerify.lng = lnggg;
                            });
                            //========Navigation to EmailVerification without the following
                            // condition is a bug(emails Already in use can navigate)
                            //------ direct navigation to the emailverfied widget will
                            // give a fake page (when pressing continue) it will not respond)
                            // I found put wrapper and transferred email by another method
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
