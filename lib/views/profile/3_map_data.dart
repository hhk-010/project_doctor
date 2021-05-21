import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/services/connectivity.dart';
import 'package:project_doctor/services/database.dart';
import 'package:project_doctor/services/read_write_path.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
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

//-------------------------------------
class MapViewStream extends StatefulWidget {
  final String addresslatlng;
  MapViewStream({this.addresslatlng});
  @override
  _MapViewStreamState createState() => _MapViewStreamState(addressLatlng: addresslatlng);
}

class _MapViewStreamState extends State<MapViewStream> {
  final String addressLatlng;
  _MapViewStreamState({this.addressLatlng});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().basicData,
      child: MapView(addressLatlng: addressLatlng),
    );
  }
}

//===============================================
class MapView extends StatefulWidget {
  final String addressLatlng;
  MapView({this.addressLatlng});
  final Storage dataStorage = Storage();

  @override
  _MapViewState createState() => _MapViewState(addressLatlng: addressLatlng);
}

class _MapViewState extends State<MapView> {
  final RoundedLoadingButtonController _controller = RoundedLoadingButtonController();
  GoogleMapController _mapController;
  final AuthService _auth = AuthService();
//==========================================
  final String addressLatlng;
  _MapViewState({this.addressLatlng});
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

//==========================================
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
  //==============ended=================

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

  double nameScoreResult = 0;
  getNameScore(String name1) {
    String name2 = DataFromMaptoVerify.name;
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
        if (x.data()['name'] != null) {
          getNameScore(x.data()['name']);
        }
        if (nameScoreResult > 40 && DataFromMaptoVerify.speciality == x.data()['speciality'] && DataFromMaptoVerify.province == x.data()['city']) {
          lt = x.data()['lat'];
          lg = x.data()['lng'];
        }
      }
    }
    return BaseScaffold(
      isAppbar: true,
      action: getAppActions(context),
      title: LocaleKeys.view_doctor_add_location.tr(),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: LatLng(33.312805, 44.361488), zoom: 10),
            markers: Set.from(mymarker),
            compassEnabled: true,
            onTap: handletap,
            zoomControlsEnabled: false,
               onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
              changeMapMode(context, _mapController);
              setState(() {});
            },

          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: CustomLoadingButton(
                title: LocaleKeys.view_buttons_submit.tr(),
                controller: _controller,
                onPressed: () async {
                  if (await isInternet()) {
                    if (latlng == null) {
                      getFlushbar(context, LocaleKeys.error_snack_map.tr(), _controller);
                    } else {
                      await geolocate(latlng: latlng);
                      if (lattt != null && lnggg != null) {
                        double resultedAddress = await analyzeAddress(lattt, lnggg);
                        print(resultedAddress);
                        if (resultedAddress < 6) {
                          setState(() {
                            finalResult = pow((lattt - lt), 2) + pow((lnggg - lg), 2);
                            finalDistance = sqrt(finalResult);
                            kmDistance = finalDistance * 100;
                          });
                          if (kmDistance < 3.0) {
                            _writeName(DataFromMaptoVerify.name);
                            _writeSpeciality(DataFromMaptoVerify.speciality);
                            _writeNumber(DataFromMaptoVerify.phoneNumber);
                            _writeProvince(DataFromMaptoVerify.province);
                            _writeAddress(DataFromMaptoVerify.address);
                            _writelat(lattt.toString());
                            _writelng(lnggg.toString());
                            _writeWorkDays01(json.encode(DataFromMaptoVerify.workDays01));
                            _writeWorkDays02(json.encode(DataFromMaptoVerify.workDays02));
                            _writeWorkDays03(json.encode(DataFromMaptoVerify.workDays03));
                            final authResult = await _auth.registerWithEmailAndPassword(DataFromMaptoVerify.email, DataFromMaptoVerify.password);
                            if (authResult != null) {
                              int count = 0;
                              await getSuccess(_controller);
                              Navigator.popUntil(context, (route) {
                                return count++ == 4;
                              });
                            } else
                              getFlushbar(context, LocaleKeys.error_snack_register.tr(), _controller);
                          } else
                            getFlushbar(context, LocaleKeys.error_snack_register.tr(), _controller);
                        } else
                          getFlushbar(context, LocaleKeys.error_invalid_address.tr(), _controller);
                      }
                    }
                  } else
                    getFlushbar(context, LocaleKeys.error_snack_connectivity.tr(), _controller);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
