import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_button.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/services/connectivity.dart';
import 'package:project_doctor/services/database.dart';
import 'package:project_doctor/views/profile/5_profile_update_view.dart';
import 'package:project_doctor/views/profile/validate_user.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Empty {
  static bool isEmpty = false;
}

class ProfileViewHeader extends StatefulWidget {
  @override
  _ProfileViewHeaderState createState() => _ProfileViewHeaderState();
}

class _ProfileViewHeaderState extends State<ProfileViewHeader> {
  final AuthService _auth = AuthService();
  final RoundedLoadingButtonController _controller = RoundedLoadingButtonController();

//=================================================
  @override
  void initState() {
    super.initState();
    Empty.isEmpty = false;
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().usersDataStream,
      child: BaseScaffold(
        isAppbar: true,
       
        title: LocaleKeys.view_doctor_profile.tr(),
        action:
          PopupMenuButton<String>(
              onSelected: (action) async {
                if (action == '0') {
                  if (await isInternet()) {
                    await _auth.signOut();
                    Navigator.pop(context);
                  } else
                    getFlushbar(context, LocaleKeys.error_snack_connectivity.tr(), _controller);
                }
                if (action == '1') {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PreDeleteUser()));
                }
                if (action == '2') {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdateProfileDataView()));
                }
              },
              itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      value: '0',
                      child: ListTile(
                        leading: Icon(Icons.logout),
                        title: Text(
                          'popupMenu.logout'.tr(),
                          style: CStyle.getSubtitle(context),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: '1',
                      child: ListTile(
                        leading: Icon(Icons.person_remove),
                        title: Text(
                          'popupMenu.deleteAccount'.tr(),
                          style: CStyle.getSubtitle(context),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: '2',
                      child: ListTile(
                        leading: Icon(Icons.update),
                        title: Text(
                          'popupMenu.UpdateProfile'.tr(),
                          style: CStyle.getSubtitle(context),
                        ),
                      ),
                    ),
                  ]),
      
        child: ProfileViewBody(),
      ),
    );
  }
}

class ProfileViewBody extends StatefulWidget {
  @override
  _ProfileViewBodyState createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  String name = '';
  String speciality = '';
  String number = '';
  String province = '';
  double lat = 0.0;
  double lng = 0.0;
  String _address = '';
  List<String> _workDays01 = [];
  List<String> _workDays02 = [];
  List<String> _workDays03 = [];
  String _mainDaysTranslation = '';
  String _mainDays = '';
  String _finalMainDays = '';
  String _firstEDay = '';
  String _secondEDay = '';
  String _mainfrom = '';
  String _mainfromTime = '';
  String _mainfromAmPm = '';
  String _mainTo = '';
  String _mainToTime = '';
  String _mainToAmPm = '';
  String _firstfrom = '';
  String _firstfromTime = '';
  String _firstfromAmPm = '';
  String _firstTo = '';
  String _firstToTime = '';
  String _firstToAmPm = '';
  String _secondfrom = '';
  String _secondfromTime = '';
  String _secondfromAmPm = '';
  String _secondTo = '';
  String _secondToTime = '';
  String _secondToAmPm = '';
  String _mainTime = '';
  String _secondTime = '';
  String _firstTime = '';
  String x = '';
  int _z = 0;
  int _y = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _mainDays = '';
      _y = 0;
      _workDays01 = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    var uid = FirebaseAuth.instance.currentUser.uid;
    final doctorListProvider = Provider.of<QuerySnapshot>(context);
    if (doctorListProvider != null) {
      for (var doc in doctorListProvider.docs) {
        if (doc.id == uid) {
          setState(() {
            name = doc.data()['name'];
            speciality = doc.data()['speciality'];
            number = doc.data()['phoneNumber'];
            province = doc.data()['province'];
            DatabaseService.preDeleteProvince = doc.data()['province'];
            lat = doc.data()['lat'];
            lng = doc.data()['lng'];
            _address = doc.data()['address'];
            _workDays01 = List<String>.from(doc.data()['workDays01']);
            _workDays02 = List<String>.from(doc.data()['workDays02']);
            _workDays03 = List<String>.from(doc.data()['workDays03']);
          });
          _y = _workDays01.length - 1;
          while (_y >= 0) {
            //for (String x in _workDays01)
            x = _workDays01[_z];
            if (x.length < 11) {
              _mainDaysTranslation = (x).tr();
              if (_mainDays == '') {
                _mainDays = _mainDaysTranslation;
                print(_mainDays);
              } else {
                _mainDays = _mainDays + ', ' + _mainDaysTranslation;
                _finalMainDays = _mainDays;
              }
            } else {
              _mainfrom = x.substring(x.indexOf('m') + 2, x.indexOf('t') - 1);
              _mainTo = x.substring(x.indexOf('t') + 3, x.length);
              _mainfromTime = _mainfrom.substring(0, _mainfrom.indexOf(' '));
              _mainfromAmPm = (_mainfrom.substring(_mainfrom.indexOf(' ') + 1, _mainfrom.indexOf('M') + 1)).tr();
              _mainToTime = _mainTo.substring(0, _mainTo.indexOf(' '));
              _mainToAmPm = (_mainTo.substring(_mainTo.indexOf(' ') + 1, _mainTo.length)).tr();
              _mainTime = LocaleKeys.view_time_day_from.tr() +
                  _mainfromTime +
                  ' ' +
                  _mainfromAmPm +
                  ' ' +
                  LocaleKeys.view_time_day_to.tr() +
                  _mainToTime +
                  ' ' +
                  _mainToAmPm;
            }
            _y -= 1;
            _z += 1;
          }
          _y = 0;
          _z = 0;
          _workDays01 = [];
          _mainDays = '';
          if (_workDays02.isNotEmpty && _workDays02.length == 2) {
            _firstEDay = (_workDays02[0]).tr();
            _firstfrom = _workDays02[1].substring(_workDays02[1].indexOf('m') + 2, _workDays02[1].indexOf('t') - 1);
            _firstTo = _workDays02[1].substring(_workDays02[1].indexOf('t') + 3, _workDays02[1].length);
            _firstfromTime = _firstfrom.substring(0, _firstfrom.indexOf(' '));
            _firstfromAmPm = (_firstfrom.substring(_firstfrom.indexOf(' ') + 1, _firstfrom.length)).tr();
            _firstToTime = _firstTo.substring(0, _firstTo.indexOf(' '));
            _firstToAmPm = (_firstTo.substring(_firstTo.indexOf(' ') + 1, _firstTo.length)).tr();
            _firstTime = LocaleKeys.view_time_day_from.tr() +
                _firstfromTime +
                ' ' +
                _firstfromAmPm +
                ' ' +
                LocaleKeys.view_time_day_to.tr() +
                _firstToTime +
                ' ' +
                _firstToAmPm;
          }
          if (_workDays03.isNotEmpty && _workDays03.length == 2) {
            _secondEDay = (_workDays03[0]).tr();
            _secondfrom = _workDays03[1].substring(_workDays03[1].indexOf('m') + 2, _workDays03[1].indexOf('t') - 1);
            _secondTo = _workDays03[1].substring(_workDays03[1].indexOf('t') + 3, _workDays03[1].length);
            _secondfromTime = _secondfrom.substring(0, _secondfrom.indexOf(' '));
            _secondfromAmPm = (_secondfrom.substring(_firstfrom.indexOf(' ') + 1, _firstfrom.length)).tr();
            _secondToTime = _secondTo.substring(0, _secondTo.indexOf(' '));
            _secondToAmPm = (_secondTo.substring(_secondTo.indexOf(' ') + 1, _secondTo.length)).tr();
            _secondTime = LocaleKeys.view_time_day_from.tr() +
                _secondfromTime +
                ' ' +
                _secondfromAmPm +
                ' ' +
                LocaleKeys.view_time_day_to.tr() +
                _secondToTime +
                ' ' +
                _secondToAmPm;
          }
          if ((doc.data()['name'] == '' || doc.data()['name'] == null) &&
              (doc.data()['speciality'] == '' || doc.data()['speciality'] == null) &&
              (doc.data()['phoneNumber'] == '' || doc.data()['phoneNumber'] == null) &&
              (doc.data()['address'] == '' || doc.data()['address'] == null)) {
            setState(() {
              Empty.isEmpty = true;
            });
          }
        }
      }
    }
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: EdgeInsets.only(top: 50),
            height: 500,
            width: 350,
            child: Container(
              decoration: CStyle.box,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Empty.isEmpty
                    ? Column(
                        children: [
                          Text(
                            LocaleKeys.view_buttons_prof_error.tr(),
                            style: CStyle.getHeading(context),
                          ),
                          Text(
                            LocaleKeys.view_buttons_data_error.tr(),
                            style: CStyle.getTitleBlack(context),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.deepOrange,
                              radius: 50,
                              backgroundImage: AssetImage('assets/images/doctor.png'),
                            ),
                          ),
                          Center(
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                name,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              // _doctorAddress,
                              (province).tr(),
                            ),
                          ),
                          Divider(
                            color: Colors.grey[600],
                            thickness: 3,
                            indent: 25,
                            endIndent: 25,
                          ),
                          Text(
                            LocaleKeys.view_doctor_speciality.tr(),
                            style: TextStyle(fontSize: 12, color: Colors.indigo, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            (speciality).tr(),
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                          ),
                          Text(
                            LocaleKeys.view_doctor_phoneNumber.tr(),
                            style: TextStyle(fontSize: 12, color: Colors.indigo, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            number,
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                          ),
                          Text(
                            LocaleKeys.view_doctor_clinic_address.tr(),
                            style: TextStyle(fontSize: 12, color: Colors.indigo, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _address,
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                          ),
                          Text(
                            LocaleKeys.view_doctor_clinic_work.tr(),
                            style: TextStyle(fontSize: 12, color: Colors.indigo, fontWeight: FontWeight.bold),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              _finalMainDays + '\n' + _mainTime,
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                          ),
                          _workDays02.isEmpty
                              ? SizedBox(
                                  height: 5,
                                )
                              : Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        LocaleKeys.view_doctor_another_clinic_work.tr(),
                                        style: TextStyle(fontSize: 12, color: Colors.indigo, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          _firstEDay + " " + _firstTime + '\n' + _secondEDay + " " + _secondTime,
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                        indent: 0,
                                        endIndent: 0,
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: BaseButton(
              title: LocaleKeys.view_doctor_update_info.tr(),
              onPressed: null,
            ),
          ),
        )
      ],
    );
  }
}
