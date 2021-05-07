import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_button.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_home.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/data_model/auth_data.dart';
import 'package:project_doctor/services/connectivity.dart';
import 'package:project_doctor/constants/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ResetPasswordView extends StatefulWidget {
  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isAppbar: true,
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
                  controller: _btnController,
                  onPressed: () async {
                    print(ResetPasswordData.email);
                    if (await isInternet()) {
                      if (ResetPasswordData.email != null && ResetPasswordData.email.isNotEmpty) {
                        await FirebaseAuth.instance.sendPasswordResetEmail(email: ResetPasswordData.email);
                        _btnController.success();
                        Timer(Duration(seconds: 2), () {
                          _btnController.reset();
                        });
                        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetPasswordView2()));
                      } else {
                        getFlushbar(context, LocaleKeys.view_snack_error_sign_info.tr())..show(context);
                        _btnController.error();
                        Timer(Duration(seconds: 2), () {
                          _btnController.reset();
                        });
                      }
                    } else {
                      getFlushbar(context, LocaleKeys.view_snack_error_snack_connectivity.tr())..show(context);
                      _btnController.error();
                      Timer(Duration(seconds: 2), () {
                        _btnController.reset();
                      });
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

// class PasswordResetContinue extends StatelessWidget {
//   final String email;
//   PasswordResetContinue({this.email});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(50),
//         child: AppBar(
//           backgroundColor: Colors.deepOrange,
//           title: Text(
//             LocaleKeys.view_doctor_passWord_reset.tr(),
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//         ),
//       ),
//       body: Center(
//         child: Container(
//           height: 100,
//           width: 100,
//           child: Column(children: [
//             SizedBox(
//               height: 120,
//               child: Image(
//                 image: AssetImage(
//                   'assets/images/password.png',
//                 ),
//               ),
//             ),
//             Spacer(
//               flex: 3,
//             ),
//             Text(
//               LocaleKeys.view_email_verification_email_sent.tr(),
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             Divider(
//               color: Colors.grey,
//               thickness: 2,
//               indent: 60,
//               endIndent: 60,
//             ),
//             Spacer(
//               flex: 1,
//             ),
//             Container(
//               decoration: CStyle.box,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   '$email',
//                   style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//             Spacer(
//               flex: 1,
//             ),
//             Divider(
//               color: Colors.grey,
//               thickness: 2,
//               indent: 40,
//               endIndent: 40,
//             ),
//             SizedBox(
//               width: 20,
//               child: Text(
//                 LocaleKeys.view_doctor_check_reset_email.tr(),
//                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Spacer(
//               flex: 3,
//             ),
//             Container(
//               height: 50,
//               width: 150,
//               child: TextButton.icon(
//                   style: TextButton.styleFrom(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
//                     backgroundColor: Colors.deepOrange,
//                   ),
//                   icon: Icon(
//                     Icons.arrow_forward,
//                     color: Colors.white,
//                   ),
//                   label: Text(LocaleKeys.view_email_verification_continue.tr(),
//                       style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
//                   onPressed: () {
//                     int count = 0;
//                     Navigator.popUntil(context, (route) => count++ == 2);
//                   }),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
