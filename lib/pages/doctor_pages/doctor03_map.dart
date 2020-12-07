import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/authorization/loading.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/database.dart';
import 'package:project_doctor/services/read_write_path.dart';
import 'package:provider/provider.dart';
import '../../services/auth.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/sizing_information.dart';

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

//-------------------------------------
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

//===============================================
class FinalMap extends StatefulWidget {
  final Storage dataStorage = Storage();

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

  //--------vars to write--------------
  String _name = '';
  String _speciality = '';
  String _phoneNumber = '';
  String _province = '';
  String _address = '';
  String _writtenlat = '';
  String _writtenlng = '';
  String _workDays01s = '';
  String _workDays02s = '';
  String _workDays03s = '';
  bool isloading = false;
  //==============ended=================
  @override
  void initState() {
    super.initState();
    checkInternet();
    super.initState();
  }
  //----------------------------------

  Future<File> _writeName(value) {
    setState(() {
      _name = value;
    });
    return widget.dataStorage.writeName(_name);
  }

  Future<File> _writeSpeciality(value) {
    setState(() {
      _speciality = value;
    });
    return widget.dataStorage.writeSpeciality(_speciality);
  }

  Future<File> _writeNumber(value) {
    setState(() {
      _phoneNumber = value;
    });
    return widget.dataStorage.writeNumber(_phoneNumber);
  }

  Future<File> _writeProvince(value) {
    setState(() {
      _province = value;
    });
    return widget.dataStorage.writeProvince(_province);
  }

  Future<File> _writeAddress(value) {
    setState(() {
      _address = value;
    });
    return widget.dataStorage.writeAddress(_address);
  }

  //===================lat to list=================
  Future<File> _writelat(value) {
    setState(() {
      _writtenlat = value;
    });
    return widget.dataStorage.writeLat(_writtenlat);
  }

  Future<File> _writelng(value) {
    setState(() {
      _writtenlng = value;
    });
    return widget.dataStorage.writeLng(_writtenlng);
  }

  Future<File> _writeWorkDays01(value) {
    setState(() {
      _workDays01s = value;
    });
    return widget.dataStorage.writeWork01(_workDays01s);
  }

  Future<File> _writeWorkDays02(value) {
    setState(() {
      _workDays02s = value;
    });
    return widget.dataStorage.writeWork02(_workDays02s);
  }

  Future<File> _writeWorkDays03(value) {
    setState(() {
      _workDays03s = value;
    });
    return widget.dataStorage.writeWork03(_workDays03s);
  }

  //=================vars For testing=========
  String n = '';
  String s = '';
  double lt = 0.0;
  double lg = 0.0;
  double finalDistance = 0.0;
  double finalResult = 0.0;
  double kmDistance = 0.0;
  @override
  Widget build(BuildContext context) {
    final basicData = Provider.of<QuerySnapshot>(context);
    if (basicData != null) {
      for (var x in basicData.docs) {
        if (DataFromMaptoVerify.name == x.data()['n'] &&
            DataFromMaptoVerify.speciality == x.data()['s']) {
          lt = x.data()['lt'];
          lg = x.data()['lg'];
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
            title: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                AppLocalizations.of(context).translate('add_location'),
                style: TextStyle(
                    fontSize: appBarTitle, fontWeight: FontWeight.bold),
              ),
            ),
            centerTitle: true,
          ),
        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(33.312805, 44.361488), zoom: 10),
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
                loadercolor: Colors.white,
                isloading: isloading,
                backgroundcolor: Colors.deepOrange,
                child: Text(
                  AppLocalizations.of(context).translate('ok'),
                  style:
                      TextStyle(fontSize: title, fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  checkInternet();
                  if (_isInternet) {
                    if (latlng == null) {
                      error =
                          AppLocalizations.of(context).translate('snack_map');
                      _showSnackBar();
                    } else {
                      await geolocate(latlng: latlng);
                      setState(() => isloading = true);
                      if (lattt != null && lnggg != null) {
                        setState(() {
                          finalResult =
                              pow((lattt - lt), 2) + pow((lnggg - lg), 2);
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
                          _writeName(DataFromMaptoVerify.name);
                          _writeSpeciality(DataFromMaptoVerify.speciality);
                          _writeNumber(DataFromMaptoVerify.phoneNumber);
                          _writeProvince(DataFromMaptoVerify.province);
                          _writeAddress(DataFromMaptoVerify.address);
                          _writelat(lattt.toString());
                          _writelng(lnggg.toString());
                          _writeWorkDays01(
                              json.encode(DataFromMaptoVerify.workDays01));
                          _writeWorkDays02(
                              json.encode(DataFromMaptoVerify.workDays02));
                          _writeWorkDays03(
                              json.encode(DataFromMaptoVerify.workDays03));
                          final authResult =
                              await _auth.registerWithEmailAndPassword(
                                  DataFromMaptoVerify.email,
                                  DataFromMaptoVerify.password);
                          if (authResult != null) {
                            setState(() => isloading = false);
                            int count = 0;
                            Navigator.popUntil(context, (route) {
                              return count++ == 4;
                            });
                          } else {
                            setState(() {
                              isloading = false;
                              error = AppLocalizations.of(context)
                                  .translate('snack_register');
                            });
                            _showSnackBar();
                          }
                        } else {
                          setState(() {
                            isloading = false;
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
    });
  }
}
