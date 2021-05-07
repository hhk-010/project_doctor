import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/constants/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/custom_widges/custom_button.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/data_model/auth_data.dart';
import 'package:project_doctor/views/profile/doctor01_form.dart';
import 'package:project_doctor/custom_widges/custom_home.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignUpView extends StatefulWidget {
  final Function registerToggleView;
  final Function questionsToogleView;

  const SignUpView({Key key, this.registerToggleView, this.questionsToogleView}) : super(key: key);
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
    RegisterData.isPasswordVisible = false;
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
                        setState(() => RegisterData.email = val);
                      },
                      cursorColor: Colors.grey,
                      keyboardType: TextInputType.emailAddress,
                      decoration: CStyle.getInputDecoration(context).copyWith(
                        hintText: LocaleKeys.view_doctor_enter_your_email.tr(),
                      ),
                    ),
                    TextField(
                      obscureText: !RegisterData.isPasswordVisible,
                      onChanged: (val) {
                        setState(() => RegisterData.password = val);
                      },
                      cursorColor: Colors.grey,
                      keyboardType: TextInputType.text,
                      decoration: CStyle.getInputDecoration(context).copyWith(
                        hintText: LocaleKeys.view_doctor_enter_your_password.tr(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            RegisterData.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.deepOrange,
                          ),
                          onPressed: () {
                            setState(() {
                              RegisterData.isPasswordVisible = !RegisterData.isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
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
                  title: LocaleKeys.view_doctor_register.tr(),
                  controller: _btnController,
                  onPressed: () async {
                    print(ModalRoute.of(context));
                    if (RegisterData.email != null &&
                        RegisterData.email.isNotEmpty &&
                        RegisterData.password != null &&
                        RegisterData.password.isNotEmpty) {
                      if (ModalRoute.of(context) != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DoctorForm(
                              email: RegisterData.email,
                              password: RegisterData.password,
                            ),
                          ),
                        );
                      }
                    } else {
                      getFlushbar(context, LocaleKeys.view_snack_error_sign_info.tr())..show(context);
                      _btnController.error();
                      Timer(Duration(seconds: 2), () {
                        _btnController.reset();
                      });
                    }
                  }),
            ),
          ),
          CustomFooter(
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                // widget.registerToggleView();
                // widget.questionsToogleView();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.view_doctor_does_have_account.tr(),
                    style: CStyle.getFooter(context),
                  ),
                  Text('  '),
                  Text(
                    LocaleKeys.view_doctor_sign_in.tr(),
                    style: CStyle.getFooter(context).copyWith(
                      color: Colors.red[400],
                      fontWeight: FontWeight.bold,
                    ),
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