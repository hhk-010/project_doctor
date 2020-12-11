import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/authorization/loading.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../services/database.dart';
import 'doctor04_profile.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/sizing_information.dart';

// ----------------class for snackbar error
class SnackBarError {
  static String error = '';
}

class MainUpdateMap extends StatefulWidget {
  @override
  _MainUpdateMapState createState() => _MainUpdateMapState();
}

class _MainUpdateMapState extends State<MainUpdateMap> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().basicData,
      child: UpdateMap(),
    );
  }
}

class UpdateMap extends StatefulWidget {
  @override
  _UpdateMapState createState() => _UpdateMapState();
}

class _UpdateMapState extends State<UpdateMap> {
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
        style: TextStyle(
            fontSize: 15,
            fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
      ),

      //duration: new Duration(seconds: 3),
      backgroundColor: Colors.deepOrange,
    );
    _scaffoldkey.currentState.showSnackBar(snackBar);
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
        if (DataFromProfiletoUpdate.name == x.data()['n'] &&
            DataFromProfiletoUpdate.speciality == x.data()['s'] &&
            DataFromProfiletoUpdate.province == x.data()['c']) {
          _lt = x.data()['lt'];
          _lg = x.data()['lg'];
        }
      }
    }
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      double appBarTitle;
      double appBarHeight;
      double title;

      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
        appBarTitle = 25;
        appBarHeight = 50;
        title = displayWidth(context) * 0.05;
      } else {
        appBarTitle = displayHeight(context) * 0.045;
        appBarHeight = 75;
        title = displayWidth(context) * 0.035;
      }
      return Scaffold(
        key: _scaffoldkey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: AppBar(
            backgroundColor: Colors.deepOrange,
            title: Text(
              AppLocalizations.of(context).translate("update_location"),
              style:
                  TextStyle(fontSize: appBarTitle, fontWeight: FontWeight.bold),
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
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            //   alignment: Alignment.topCenter,
            //   child: Column(
            //     children: [
            //       Text(
            //         AppLocalizations.of(context).translate("zoom_in_out"),
            //         style: TextStyle(
            //           fontSize: 13,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       Text(
            //         AppLocalizations.of(context).translate("zoom_in"),
            //         style: TextStyle(
            //           fontSize: 13,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       Text(
            //         AppLocalizations.of(context).translate("zoom_out"),
            //         style: TextStyle(
            //           fontSize: 13,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.symmetric(vertical: 45.0, horizontal: 15.0),
              child: FloatingLoadingButton(
                  isloading: isloading,
                  loadercolor: Colors.white,
                  backgroundcolor: Colors.deepOrange,
                  child: Text(AppLocalizations.of(context).translate('ok'),
                      style: TextStyle(
                          fontSize: title, fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    checkInternet();
                    if (_isInternet) {
                      if (latlng == null) {
                        setState(() {
                          SnackBarError.error = AppLocalizations.of(context)
                              .translate('snack_map');
                        });
                        _showSnackBar();
                      } else {
                        await geolocate(latlng: latlng);
                        if (lattt != null && lnggg != null) {
                          setState(() {
                            isloading = true;
                            _result =
                                pow((lattt - _lt), 2) + pow((lnggg - _lg), 2);
                            _finalDistance = sqrt(_result);
                            _kmDistance = _finalDistance * 100;
                          });
                          print(_kmDistance);
                          if (_kmDistance < 100) {
                            setState(() {
                              Empty.isEmpty = false;
                            });
                            await DatabaseService(
                                    uid: FirebaseAuth.instance.currentUser.uid)
                                .updateUserData(
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
                            int count = 0;
                            Navigator.popUntil(context, (route) {
                              return count++ == 3;
                            });
                          } else {
                            setState(() {
                              isloading = false;
                              SnackBarError.error = AppLocalizations.of(context)
                                  .translate('snack_update');
                            });
                            _showSnackBar();
                          }
                        }
                      }
                    } else {
                      setState(() {
                        SnackBarError.error = AppLocalizations.of(context)
                            .translate('snack_connectivity');
                      });
                      _showSnackBar();
                    }
                  }),
            ),
          ],
        ),
      );
    });
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
