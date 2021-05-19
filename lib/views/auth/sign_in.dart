import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/custom_widges/custom_home.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/services/connectivity.dart';
import 'package:project_doctor/views/auth/reset_password.dart';
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
  final RoundedLoadingButtonController _controller = RoundedLoadingButtonController();

  @override
  void initState() {
    SignInData.isPasswordVisible = false;
    SignInData.email = '';
    SignInData.password = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isAppbar: true,
      action: getAppActions(context),
      title: LocaleKeys.view_doctor_sign_in.tr(),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          HomeAlignWidgets(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(0.0),
            isIcon: false,
            width: MediaQuery.of(context).size.width,
            height: getDeviceType(context, 225, 300, 500, 700),
            asset: getTheme(context) ? 'assets/images/auth/sign_in_light.png' : 'assets/images/auth/sign_in_dark.png',
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                top: getDeviceType(context, 120, 120, 300, 500),
              ),
              child: Container(
                height: getDeviceType(context, 175, 200, 250, 250),
                width: getDeviceType(context, 250, 300, 350, 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: getDeviceType(context, 40, 50, 60, 70),
                      child: TextField(
                        onChanged: (val) {
                          setState(() => SignInData.email = val);
                        },
                        cursorColor: Colors.grey,
                        keyboardType: TextInputType.emailAddress,
                        decoration: CustomStyle.getInputDecoration(context).copyWith(
                          hintText: LocaleKeys.view_doctor_enter_your_email.tr(),
                        ),
                      ),
                    ),
                    Container(
                      height: getDeviceType(context, 40, 50, 60, 70),
                      child: TextField(
                        obscureText: !SignInData.isPasswordVisible,
                        onChanged: (val) {
                          setState(() => SignInData.password = val);
                        },
                        cursorColor: Colors.grey,
                        keyboardType: TextInputType.text,
                        decoration: CustomStyle.getInputDecoration(context).copyWith(
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
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom,
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
                            style: CustomStyle.getSubtitle(context),
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
              padding: EdgeInsets.only(
                bottom: getDeviceType(context, 50, 100, 125, 150),
              ),
              child: CustomLoadingButton(
                title: LocaleKeys.view_doctor_sign_in.tr(),
                controller: _controller,
                onPressed: () async {
                  if (await isInternet()) {
                    if (SignInData.email.isNotEmpty && SignInData.password.isNotEmpty) {
                      dynamic authResult = await _auth.signInWithEmailAndPassword(SignInData.email, SignInData.password);
                      if (authResult != null) {
                        // await getSuccess(_controller);
                      } else {
                        getFlushbar(context, LocaleKeys.error_snack_sign_in.tr(), _controller);
                      }
                    } else {
                      getFlushbar(context, LocaleKeys.error_sign_info.tr(), _controller);
                    }
                  } else {
                    getFlushbar(context, LocaleKeys.error_snack_connectivity.tr(), _controller);
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
                    style: CustomStyle.getFooter(context),
                  ),
                  Text('  '),
                  Text(
                    LocaleKeys.view_doctor_register.tr(),
                    style: CustomStyle.getFooter(context).copyWith(color: Colors.red[400], fontWeight: FontWeight.bold),
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
