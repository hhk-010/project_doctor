import 'dart:async';
import 'dart:ui';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_home.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/services/connectivity.dart';
import 'package:project_doctor/services/database.dart';
import 'package:project_doctor/services/read_write_path.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/views/auth/sign_wrapper.dart';
import 'package:project_doctor/views/profile/delete_profile.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

// class for getting the data from map to firebase through verfication.
class EmailVeriyView extends StatefulWidget {
  final Storage dataReadStorage = Storage();
  static String province = '';
  @override
  _EmailVeriyViewState createState() => _EmailVeriyViewState();
}

class _EmailVeriyViewState extends State<EmailVeriyView> {
  final RoundedLoadingButtonController _controller = RoundedLoadingButtonController();
  String _email = '';
  String _name = '';
  String _speciality = '';
  String _phoneNumber = '';
  String _province = '';
  String _address = '';
  double _lat = 0.0;
  double _lng = 0.0;
  List _workDays01 = [];
  List _workDays02 = [];
  List _workDays03 = [];

  final AuthService _auth = AuthService();
  Timer _timer;
  @override
  void initState() {
    super.initState();
    Future(() async {
      _timer = Timer.periodic(Duration(seconds: 10), (timer) async {
        FirebaseAuth.instance.currentUser..reload();
      });
    });
    //_readDoctorInfo();
    _email = FirebaseAuth.instance.currentUser.email;

    //-------reading data---------

    widget.dataReadStorage.readName().then((String value) {
      setState(() {
        _name = value;
      });
    });

    widget.dataReadStorage.readSpeciality().then((String value) {
      setState(() {
        _speciality = value;
      });
    });

    widget.dataReadStorage.readNumber().then((String value) {
      setState(() {
        _phoneNumber = value;
      });
    });

    widget.dataReadStorage.readProvince().then((String value) {
      setState(() {
        _province = value;
        EmailVeriyView.province = value;
      });
    });

    widget.dataReadStorage.readAddress().then((String value) {
      setState(() {
        _address = value;
      });
    });
//====================lat to list==========================
    widget.dataReadStorage.readLat().then((double value) {
      setState(() {
        _lat = value;
      });
    });

    widget.dataReadStorage.readLng().then((double value) {
      setState(() {
        _lng = value;
      });
    });

    widget.dataReadStorage.workDays01reader().then((List value) {
      setState(() {
        _workDays01 = value;
      });
    });

    widget.dataReadStorage.readWorkDays02().then((List value) {
      setState(() {
        _workDays02 = value;
      });
    });

    widget.dataReadStorage.readWorkDays03().then((List value) {
      setState(() {
        _workDays03 = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isAppbar: true,
      title: LocaleKeys.view_email_verification_email_v_title.tr(),
      action: PopupMenuButton<String>(
          onSelected: (action) async {
            if (action == '0') {
              if (await isInternet()) {
                await _auth.signOut();
                Navigator.pop(context);
              } else
                getFlushbar(context, LocaleKeys.error_snack_connectivity.tr(), _controller);
            }
            if (action == '1') {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeleteProfileView()));
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
              ]),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          HomeAlignWidgets(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 50),
            isIcon: false,
            height: 140,
            width: 140,
            asset: 'assets/images/password.png',
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.only(top: 50),
              height: 450,
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    LocaleKeys.view_email_verification_email_sent.tr(),
                    style: CStyle.getTitleBlack(context),
                  ),
                  Container(
                    decoration: CStyle.box,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _email,
                        style: CStyle.getSubtitle(context),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: Text(
                      'view_email_verification.confirm'.tr(),
                      style: CStyle.getSubtitle(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  CustomLoadingButton(
                    controller: _controller,
                    title: LocaleKeys.view_email_verification_continue.tr(),
                    onPressed: () async {
                      if (await isInternet()) {
                        if (FirebaseAuth.instance.currentUser.emailVerified) {
                          await DatabaseService(uid: FirebaseAuth.instance.currentUser.uid).updateUserData(
                              _name, _speciality, _phoneNumber, _province, _lat, _lng, _address, _workDays01, _workDays02, _workDays03);
                          // await getSuccess(_controller);
                          await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Intermediate()));
                        } else
                          getFlushbar(context, LocaleKeys.error_snack_verification.tr(), _controller);
                      } else
                        getFlushbar(context, LocaleKeys.error_snack_connectivity.tr(), _controller);
                    },
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Container(
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      LocaleKeys.view_email_verification_didnot_receive.tr(),
                      style: CStyle.getFooter(context),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await AuthService().resendemail();
                      },
                      child: Text(
                        LocaleKeys.view_email_verification_resend.tr(),
                        style: CStyle.getFooter(context).copyWith(color: Colors.red[400], fontWeight: FontWeight.bold),
                      ),
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

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
