import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/custom_widges/custom_home.dart';
import 'package:project_doctor/views/profile/1_profile_data.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignUpView extends StatefulWidget {
  final Function registerToggleView;
  final Function questionsToogleView;

  const SignUpView({Key key, this.registerToggleView, this.questionsToogleView}) : super(key: key);
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final RoundedLoadingButtonController _controller = RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
    RegisterData.isPasswordVisible = false;
    RegisterData.email = '';
    RegisterData.password = '';
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isAppbar: true,
      action: getAppActions(context),
      title: LocaleKeys.view_doctor_register.tr(),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          HomeAlignWidgets(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(0.0),
            isIcon: false,
            width: MediaQuery.of(context).size.width,
            height: 300,
            asset: getTheme(context) ? 'assets/images/auth/sign_up_light.png' : 'assets/images/auth/sign_up_dark.png',
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
                      decoration: CustomStyle.getInputDecoration(context).copyWith(
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
                      decoration: CustomStyle.getInputDecoration(context).copyWith(
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
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom,
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
                  controller: _controller,
                  onPressed: () async {
                    print(ModalRoute.of(context));
                    if (RegisterData.email.isNotEmpty && RegisterData.password.isNotEmpty) {
                      if (ModalRoute.of(context) != null) {
                        await getSuccess(_controller);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfileDataView(),
                          ),
                        );
                      }
                    } else {
                      getFlushbar(context, LocaleKeys.error_sign_info.tr(), _controller);
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
                    style: CustomStyle.getFooter(context),
                  ),
                  Text('  '),
                  Text(
                    LocaleKeys.view_doctor_sign_in.tr(),
                    style: CustomStyle.getFooter(context).copyWith(
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
