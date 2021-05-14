import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_dropdownbutton.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/matching_algorithm/final_score.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:project_doctor/services/connectivity.dart';
import 'package:project_doctor/services/database.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/services/geolocation.dart';
import 'package:project_doctor/views/search/search_complain/get_map.dart';
import 'package:project_doctor/views/search/search_complain/result_profile.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class MyVariables {
  static String speciality = '';
  static String speciality2 = '';
  static String province = '';
  static double lat = 0.0;
  static double lng = 0.0;
  static bool usingMap = false;
  static String geoLatlng = '';
  static double geolat = 0.0;
  static double geolng = 0.0;
}

class LocationWrapper extends StatefulWidget {
  @override
  _LocationWrapperState createState() => _LocationWrapperState();
}

class _LocationWrapperState extends State<LocationWrapper> {
  final RoundedLoadingButtonController _controller1 = RoundedLoadingButtonController();
  final RoundedLoadingButtonController _controller2 = RoundedLoadingButtonController();

  String region;
  Position _currentPosition;

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

  @override
  void initState() {
    super.initState();
    MyVariables.usingMap = false;
  }

  @override
  Widget build(BuildContext context) {
    final province = {
      "1": [
        "Erbil",
        ("Erbil").tr(),
      ],
      "2": [
        "Al Anbar",
        ("Al Anbar").tr(),
      ],
      "3": [
        "Basra",
        ("Basra").tr(),
      ],
      "4": [
        "Al Qadisiyyah",
        ("Al Qadisiyyah").tr(),
      ],
      "5": [
        "Muthanna",
        ("Muthanna").tr(),
      ],
      "6": [
        "Najaf",
        ("Najaf").tr(),
      ],
      "7": [
        "Babil",
        ("Babil").tr(),
      ],
      "8": [
        'Baghdad',
        ('Baghdad').tr(),
      ],
      "9": [
        "Duhok",
        ("Duhok").tr(),
      ],
      "10": [
        "Diyala",
        ("Diyala").tr(),
      ],
      "11": [
        "Dhi Qar",
        ("Dhi Qar").tr(),
      ],
      "12": [
        "Sulaymaniyah",
        ("Sulaymaniyah").tr(),
      ],
      "13": [
        "Saladin",
        ("Saladin").tr(),
      ],
      "14": [
        "Karbala",
        ("Karbala").tr(),
      ],
      "15": [
        "Kirkuk",
        ("Kirkuk").tr(),
      ],
      "16": [
        "Maysan",
        ("Maysan").tr(),
      ],
      "17": [
        "Nineveh",
        ("Nineveh").tr(),
      ],
      "18": [
        "Wasit",
        ("Wasit").tr(),
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
    return BaseScaffold(
      title: LocaleKeys.view_patient_region.tr(),
      isAppbar: true,
      action: getAppActions(context),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: getDeviceType(context, 25, 50, 75, 100),
            ),
            child: Container(
              width: getDeviceType(context, 250, 350, 450, 550),
              height: getDeviceType(context, 125, 150, 250, 300),
              decoration: CustomStyle.box,
              padding: EdgeInsets.all(getDeviceType(context, 16, 16, 24, 32)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    LocaleKeys.view_doctor_province.tr(),
                    style: CustomStyle.getTitleBlack(context),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 2,
                    indent: 75,
                    endIndent: 75,
                  ),
                  CustomDropDownButton(
                    hint: LocaleKeys.view_patient_select_region.tr(),
                    value: region,
                    items: [
                      DropdownMenuItem(
                        value: province["1"][0],
                        child: Text(
                          province["1"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["2"][0],
                        child: Text(
                          province["2"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["3"][0],
                        child: Text(
                          province["3"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["4"][0],
                        child: Text(
                          province["4"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["5"][0],
                        child: Text(
                          province["5"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["6"][0],
                        child: Text(
                          province["6"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["7"][0],
                        child: Text(
                          province["7"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["8"][0],
                        child: Text(
                          province["8"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["9"][0],
                        child: Text(
                          province["9"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["10"][0],
                        child: Text(
                          province["10"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["11"][0],
                        child: Text(
                          province["11"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["12"][0],
                        child: Text(
                          province["12"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["13"][0],
                        child: Text(
                          province["13"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["14"][0],
                        child: Text(
                          province["14"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["15"][0],
                        child: Text(
                          province["15"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["16"][0],
                        child: Text(
                          province["16"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["17"][0],
                        child: Text(
                          province["17"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                      DropdownMenuItem(
                        value: province["18"][0],
                        child: Text(
                          province["18"][1],
                          style: CustomStyle.getSubtitle(context),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() => region = value);
                    },
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: getDeviceType(context, 50, 25, 200, 200)),
              child: Container(
                decoration: CustomStyle.box,
                height: getDeviceType(context, 200, 300, 350, 400),
                width: getDeviceType(context, 250, 350, 450, 550),
                padding: EdgeInsets.all(getDeviceType(context, 16, 16, 24, 32)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Text(
                        LocaleKeys.view_patient_get_location.tr(),
                        style: CustomStyle.getSubtitle(context),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    CustomLoadingButton(
                      title: 'view_patient.auto_location'.tr(),
                      controller: _controller1,
                      onPressed: () async {
                        if (!(region == null || region == '')) {
                          if (await isInternet()) {
                            MyVariables.geoLatlng = await getCoordinatesFromAddress(region + ',' + district[region]);
                            MyVariables.geolat = double.parse(
                                MyVariables.geoLatlng.substring(MyVariables.geoLatlng.indexOf('{') + 1, MyVariables.geoLatlng.indexOf(',')));
                            MyVariables.geolng = double.parse(
                                MyVariables.geoLatlng.substring(MyVariables.geoLatlng.indexOf(',') + 1, MyVariables.geoLatlng.indexOf('}')));
                            _currentPosition = await determinePosition();
                            if (_currentPosition == null) {
                              getFlushbar(context, LocaleKeys.error_geolocator_message.tr(), _controller1);
                            } else {
                              setState(() {
                                MyVariables.speciality = FinalScore.speciality;
                                MyVariables.province = region;
                                DatabaseService.province = region;
                                MyVariables.lat = _currentPosition.latitude;
                                MyVariables.lng = _currentPosition.longitude;
                              });
                              double sum = pow(MyVariables.geolat - MyVariables.lat, 2) + pow(MyVariables.geolng - MyVariables.lng, 2);
                              double result = sqrt(sum);
                              if (result * 100 < 100) {
                                setState(() => MyVariables.usingMap = false);
                                await getSuccess(_controller1);
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileResultView()));
                              } else {
                                getFlushbar(context, LocaleKeys.view_patient_invalid_device_location.tr(), _controller1);
                              }
                            }
                          } else
                            getFlushbar(context, LocaleKeys.error_snack_connectivity.tr(), _controller1);
                        } else
                          getFlushbar(context, LocaleKeys.view_doctor_province_validator.tr(), _controller1);
                      },
                    ),
                    Text(
                      'Or'.tr(),
                      style: CustomStyle.getTitleBlack(context),
                    ),
                    CustomLoadingButton(
                      title: LocaleKeys.view_buttons_google_map.tr(),
                      controller: _controller2,
                      onPressed: () async {
                        if (!(region == null || region == '')) {
                          setState(() {
                            MyVariables.usingMap = true;
                            DatabaseService.province = region;
                          });
                          MyVariables.geoLatlng = await getCoordinatesFromAddress(region + ',' + district[region]);
                          MyVariables.geolat = double.parse(
                              MyVariables.geoLatlng.substring(MyVariables.geoLatlng.indexOf('{') + 1, MyVariables.geoLatlng.indexOf(',')));
                          MyVariables.geolng = double.parse(
                              MyVariables.geoLatlng.substring(MyVariables.geoLatlng.indexOf(',') + 1, MyVariables.geoLatlng.indexOf('}')));
                          await getSuccess(_controller2);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => GetMapView(
                                speciality: FinalScore.speciality,
                                province: region,
                              ),
                            ),
                          );
                        } else
                          getFlushbar(context, LocaleKeys.view_doctor_province_validator.tr(), _controller2);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
