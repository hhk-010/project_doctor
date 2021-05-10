import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/services/connectivity.dart';
import 'package:project_doctor/views/auth/email_verify.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../services/database.dart';
import '4_profile.dart';

class UpdateaMapViewStream extends StatefulWidget {
  final String latlng;
  UpdateaMapViewStream({this.latlng});
  @override
  _UpdateaMapViewStreamState createState() => _UpdateaMapViewStreamState(latlng: latlng);
}

class _UpdateaMapViewStreamState extends State<UpdateaMapViewStream> {
  final String latlng;
  _UpdateaMapViewStreamState({this.latlng});
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().basicData,
      child: UpdateMapView(latlng: latlng),
    );
  }
}

class UpdateMapView extends StatefulWidget {
  final String latlng;
  UpdateMapView({this.latlng});
  @override
  _UpdateMapViewState createState() => _UpdateMapViewState(addressLatlng: latlng);
}

class _UpdateMapViewState extends State<UpdateMapView> {
  final RoundedLoadingButtonController _controller = RoundedLoadingButtonController();

  final String addressLatlng;
  _UpdateMapViewState({this.addressLatlng});
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
    return BaseScaffold(
      isAppbar: true,
            action: getAppActions(context),

      title: LocaleKeys.view_doctor_update_location.tr(),
      child: Stack(
        alignment: Alignment.topCenter,
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
                        double addressResult = await analyzeAddress(lattt, lnggg);
                        if (addressResult < 6) {
                          setState(() {
                            _result = pow((lattt - _lt), 2) + pow((lnggg - _lg), 2);
                            _finalDistance = sqrt(_result);
                            _kmDistance = _finalDistance * 100;
                          });
                          if (_kmDistance < 3) {
                            setState(() {
                              Empty.isEmpty = false;
                              EmailVeriyView.province = DataFromProfiletoUpdate.province;
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
                            DatabaseService.province = DataFromProfiletoUpdate.province;
                            int count = 0;
                            getSuccess(_controller);
                            Navigator.popUntil(context, (route) {
                              return count++ == 3;
                            });
                          } else 
                            getFlushbar(context, LocaleKeys.error_snack_update.tr(), _controller);
                          
                        } else 
                          getFlushbar(context, LocaleKeys.error_invalid_address.tr(), _controller);
                        
                      }else
                      getFlushbar(context, LocaleKeys.error_invalid_address.tr(), _controller);
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
