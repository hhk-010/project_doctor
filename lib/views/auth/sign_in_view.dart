import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_button.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/custom_widges/custom_home.dart';
import 'package:project_doctor/data_model/auth_data.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/services/connectivity.dart';
import 'package:project_doctor/views/auth/forget_pass_view.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignInView extends StatefulWidget {
  // method for toggling mcq view
  final Function questionsToogleView;
  const SignInView({Key key, this.questionsToogleView}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  // object for firebase auth
  final AuthService _auth = AuthService();
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  void initState() {
    SignInData.isPasswordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isAppbar: true,
      title: LocaleKeys.view_doctor_sign_in.tr(),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          HomeAlignWidgets(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(0.0),
            isIcon: false,
            width: MediaQuery.of(context).size.width,
            height: 300,
            asset: getTheme(context) ? 'assets/images/auth/header_light.png' : 'assets/images/auth/header_dark.png',
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Container(
                height: 200,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      onChanged: (val) {
                        setState(() => SignInData.email = val);
                      },
                      cursorColor: Colors.grey,
                      keyboardType: TextInputType.emailAddress,
                      decoration: CStyle.getInputDecoration(context).copyWith(
                        hintText: LocaleKeys.view_doctor_enter_your_email.tr(),
                      ),
                    ),
                    TextField(
                      obscureText: !SignInData.isPasswordVisible,
                      onChanged: (val) {
                        setState(() => SignInData.password = val);
                      },
                      cursorColor: Colors.grey,
                      keyboardType: TextInputType.text,
                      decoration: CStyle.getInputDecoration(context).copyWith(
                        hintText: LocaleKeys.view_doctor_enter_your_password.tr(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            SignInData.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.deepOrange,
                          ),
                          onPressed: () {
                            setState(() {
                              SignInData.isPasswordVisible = !SignInData.isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ResetPasswordView(),
                            ),
                          ),
                          child: Text(
                            LocaleKeys.view_doctor_forget_password.tr(),
                            style: CStyle.getSubtitle(context),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: CustomLoadingButton(
                title: LocaleKeys.view_doctor_sign_in.tr(),
                controller: _btnController,
                onPressed: () async {
                  if (await isInternet()) {
                    if (SignInData.email != null && SignInData.email.isNotEmpty && SignInData.password != null && SignInData.password.isNotEmpty) {
                      dynamic authResult = await _auth.signInWithEmailAndPassword(SignInData.email, SignInData.password);
                      if (authResult != null) {
                        _btnController.success();
                        Timer(Duration(seconds: 2), () {});
                      } else {
                        getFlushbar(context, LocaleKeys.view_snack_error_snack_sign_in.tr())..show(context);
                        _btnController.error();
                        Timer(Duration(seconds: 2), () {
                          _btnController.reset();
                        });
                      }
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
                },
              ),
            ),
          ),
          CustomFooter(
            child: InkWell(
              onTap: () {
                widget.questionsToogleView();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.view_doctor_does_not_have_account.tr(),
                    style: CStyle.getFooter(context),
                  ),
                  Text('  '),
                  Text(
                    LocaleKeys.view_doctor_register.tr(),
                    style: CStyle.getFooter(context).copyWith(color: Colors.red[400], fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
