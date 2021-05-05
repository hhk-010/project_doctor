import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/constants/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/authorization/email_verfication.dart';
import 'package:project_doctor/views/authorization/loading.dart';
import 'package:provider/provider.dart';
import '../../services/database.dart';
import 'doctor04_profile.dart';

// ----------------class for snackbar error
class SnackBarError {
  static String error = '';
}

class MainUpdateMap extends StatefulWidget {
  final String latlng;
  MainUpdateMap({this.latlng});
  @override
  _MainUpdateMapState createState() => _MainUpdateMapState(latlng: latlng);
}

class _MainUpdateMapState extends State<MainUpdateMap> {
  final String latlng;
  _MainUpdateMapState({this.latlng});
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().basicData,
      child: UpdateMap(latlng: latlng),
    );
  }
}

class UpdateMap extends StatefulWidget {
  final String latlng;
  UpdateMap({this.latlng});
  @override
  _UpdateMapState createState() => _UpdateMapState(addressLatlng: latlng);
}

class _UpdateMapState extends State<UpdateMap> {
  final String addressLatlng;
  _UpdateMapState({this.addressLatlng});
  //function to get and analyze latlng from address
  String addressLat = '';
  String addressLng = '';
  double addressesLat = 0.0;
  double addressesLng = 0.0;
  double sum = 0.0;
  double result = 0.0;
  analyzeAddress(double lat, double lng) {
    if (addressLatlng != null || addressLatlng != '') {
      addressLat = addressLatlng.substring(1, addressLatlng.indexOf(','));
      addressLng = addressLatlng.substring(addressLatlng.indexOf(',') + 1, addressLatlng.length - 1);
      addressesLat = double.parse(addressLat);
      addressesLng = double.parse(addressLng);
      sum = (pow(addressesLat - lat, 2)) + pow(addressesLng - lng, 2);
      result = sqrt(sum) * 100;
      return result;
    }
  }

  //======================================
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

  double lattt;
  double lnggg;
  geolocate({String latlng}) {
    var firstindex = latlng.indexOf('(');
    var secondindex = latlng.indexOf(',');
    var thirdindex = latlng.indexOf(')');
    String lat = latlng.substring(firstindex + 1, secondindex);
    String lng = latlng.substring(secondindex + 1, thirdindex);

    lattt = double.parse(lat);
    lnggg = double.parse(lng);
  }

  //==============snackbar for empty latlng============
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    var lang = Localizations.localeOf(context).languageCode;

    final snackBar = new SnackBar(
      content: new Text(
        SnackBarError.error,
        style: TextStyle(fontSize: 15, fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
      ),

      //duration: new Duration(seconds: 3),
      backgroundColor: Colors.deepOrange,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  //------------the end --------------------
  //========================================
  double nameScoreResult = 0;
  getNameScore(String name1) {
    String name2 = DataFromProfiletoUpdate.name;
    List name1list = [];
    List name2list = [];

    int name1l = name1.length;
    int name2l = name2.length;
    int name1c = 0;
    int name2c = 0;
    while (name1l > 0) {
      name1list.add(name1.substring(name1c, name1c + 1));
      name1c++;
      name1l--;
    }
    while (name2l > 0) {
      name2list.add(name2.substring(name2c, name2c + 1));
      name2c++;
      name2l--;
    }
    int list1l = name1list.length;
    int list2l = name2list.length;
    int denom = list1l;
    int list1c = 0;
    int score = 0;
    while (list1l > 0 && list2l > 0) {
      if (name1list[list1c] == name2list[list1c]) {
        score++;
      }
      list1c++;
      list1l--;
      list2l--;
    }
    nameScoreResult = score / denom;
    nameScoreResult = nameScoreResult * 100;
  }

  //===================================
  double _lt = 0.0;
  double _lg = 0.0;
  double _result = 0.0;
  double _finalDistance = 0.0;
  double _kmDistance = 0.0;
  bool isloading = false;
  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final basicDatabase = Provider.of<QuerySnapshot>(context);
    if (basicDatabase != null) {
      for (var x in basicDatabase.docs) {
        if (x.data()['name'] != null) {
          getNameScore(x.data()['name']);
        }
        if (nameScoreResult > 40 &&
            DataFromProfiletoUpdate.speciality == x.data()['speciality'] &&
            DataFromProfiletoUpdate.province == x.data()['city']) {
          _lt = x.data()['lat'];
          _lg = x.data()['lng'];
        }
      }
    }

    return Scaffold(
      key: _scaffoldkey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            LocaleKeys.view_doctor_update_location.tr(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(33.312805, 44.361488),
              zoom: 10,
            ),
            markers: Set.from(mymarker),
            onTap: handletap,
            zoomControlsEnabled: false,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(vertical: 45.0, horizontal: 15.0),
            child: FloatingLoadingButton(
              isloading: isloading,
              loadercolor: Colors.white,
              backgroundcolor: Colors.deepOrange,
              child: Text(LocaleKeys.view_buttons_ok.tr(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              onPressed: () async {
                checkInternet();
                if (_isInternet) {
                  if (latlng == null) {
                    SnackBarError.error = LocaleKeys.view_snack_error_snack_map.tr();
                    _showSnackBar();
                  } else {
                    await geolocate(latlng: latlng);
                    if (lattt != null && lnggg != null) {
                      double addressResult = await analyzeAddress(lattt, lnggg);
                      if (addressResult < 6) {
                        setState(() {
                          isloading = true;
                          _result = pow((lattt - _lt), 2) + pow((lnggg - _lg), 2);
                          _finalDistance = sqrt(_result);
                          _kmDistance = _finalDistance * 100;
                        });
                        if (_kmDistance < 3) {
                          setState(() {
                            Empty.isEmpty = false;
                            EmailVerification.province = DataFromProfiletoUpdate.province;
                          });
                          await DatabaseService(uid: FirebaseAuth.instance.currentUser.uid).deleteuser();
                          await DatabaseService(uid: FirebaseAuth.instance.currentUser.uid).updateUserData(
                              DataFromProfiletoUpdate.name,
                              DataFromProfiletoUpdate.speciality,
                              DataFromProfiletoUpdate.phoneNumber,
                              DataFromProfiletoUpdate.province,
                              lattt,
                              lnggg,
                              DataFromProfiletoUpdate.address,
                              DataFromProfiletoUpdate.workDays01,
                              DataFromProfiletoUpdate.workDays02,
                              DataFromProfiletoUpdate.workDays03);
                          setState(() {
                            isloading = false;
                          });
                          DatabaseService.province = DataFromProfiletoUpdate.province;
                          int count = 0;
                          Navigator.popUntil(context, (route) {
                            return count++ == 3;
                          });
                        } else {
                          setState(() {
                            isloading = false;
                            SnackBarError.error =  LocaleKeys.view_snack_error_snack_update.tr();
                          });
                          _showSnackBar();
                        }
                      } else {
                        SnackBarError.error =  LocaleKeys.view_snack_error_invalid_address.tr();
                        _showSnackBar();
                      }
                    }
                  }
                } else {
                  setState(() {
                    SnackBarError.error = LocaleKeys.view_snack_error_snack_connectivity.tr();
                  });
                  _showSnackBar();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DataFromProfiletoUpdate {
  static String name = '';
  static String speciality = '';
  static String phoneNumber = '';
  static String province = '';
  static String address = '';
  static List workDays01 = [];
  static List workDays02 = [];
  static List workDays03 = [];
}
