import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_home.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/services/connectivity.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ResetPasswordView extends StatefulWidget {
  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final RoundedLoadingButtonController _controller = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isAppbar: true,
      action:
        getAppActions(context),
    
      title: LocaleKeys.view_doctor_passWord_reset.tr(),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          HomeAlignWidgets(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 50),
            isIcon: false,
            height: 140,
            width: 140,
            asset: 'assets/images/reset_password.png',
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 200,
              width: 300,
              child: TextField(
                onChanged: (val) {
                  setState(() => ResetPasswordData.email = val);
                },
                cursorColor: Colors.grey,
                keyboardType: TextInputType.emailAddress,
                decoration: CStyle.getInputDecoration(context).copyWith(
                  hintText: LocaleKeys.view_doctor_enter_your_email.tr(),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: CustomLoadingButton(
                  title: LocaleKeys.view_doctor_password_reset_email.tr(),
                  controller: _controller,
                  onPressed: () async {
                    if (await isInternet()) {
                      if (ResetPasswordData.email != null && ResetPasswordData.email.isNotEmpty) {
                        await FirebaseAuth.instance.sendPasswordResetEmail(email: ResetPasswordData.email);
                        await getSuccess(_controller);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetPasswordView2()));
                      } else {
                        getFlushbar(context, LocaleKeys.error_sign_info.tr(), _controller);
                      }
                    } else {
                      getFlushbar(context, LocaleKeys.error_snack_connectivity.tr(), _controller);
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class ResetPasswordView2 extends StatefulWidget {
  @override
  _ResetPasswordView2State createState() => _ResetPasswordView2State();
}

class _ResetPasswordView2State extends State<ResetPasswordView2> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isAppbar: true,
      action: getAppActions(context),
      title: LocaleKeys.view_doctor_passWord_reset.tr(),
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
              width: 300,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    LocaleKeys.view_email_verification_email_sent.tr(),
                    style: CStyle.getTitleBlack(context),
                  ),
                  Container(
                    width: 200,
                    height: 60,
                    decoration: CStyle.box,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        ResetPasswordData.email,
                        style: CStyle.getSubtitle(context),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Text(
                    LocaleKeys.view_doctor_check_reset_email.tr(),
                    style: CStyle.getSubtitle(context),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: BaseButton(
                  title: LocaleKeys.view_email_verification_continue.tr(),
                  onPressed: () {
                    int count = 0;
                    Navigator.popUntil(context, (route) => count++ == 2);
                  },
                )),
          ),
        ],
      ),
    );
  }
}
