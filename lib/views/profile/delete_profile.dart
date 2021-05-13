import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_home.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/services/connectivity.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../services/auth.dart';

class DeleteProfileView extends StatefulWidget {
  @override
  _DeleteProfileViewState createState() => _DeleteProfileViewState();
}

class _DeleteProfileViewState extends State<DeleteProfileView> {
  final RoundedLoadingButtonController _controller = RoundedLoadingButtonController();
  String email;
  String _oldPassword;
  bool passwordvalid;
  bool _passwordVisible = true;
  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isAppbar: true,
      title: LocaleKeys.popupMenu_deleteAccount.tr(),
      action: getAppActions(context),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          HomeAlignWidgets(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: getDeviceType(context, 25, 50, 75, 100)),
            isIcon: false,
            height: getDeviceType(context, 120, 140, 160, 200),
            width: getDeviceType(context, 120, 140, 160, 200),
            asset: 'assets/images/delete.png',
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: getDeviceType(context, 175, 200, 200, 250),
              width: getDeviceType(context, 250, 300, 350, 450),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: getDeviceType(context, 40, 50, 60, 70),
                    child: TextField(
                      obscureText: !_passwordVisible,
                      decoration: CustomStyle.getInputDecoration(context).copyWith(
                        hintText: LocaleKeys.view_doctor_current_password.tr(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.deepOrange,
                          ),
                          onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
                        ),
                      ),
                      onChanged: (val) {
                        _oldPassword = val;
                      },
                    ),
                  ),
                  Container(
                    height: getDeviceType(context, 40, 50, 60, 70),
                    child: TextField(
                      decoration: CustomStyle.getInputDecoration(context).copyWith(
                        hintText: LocaleKeys.view_doctor_enter_your_email.tr(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: getDeviceType(context, 50, 100, 150, 200),
              ),
              child: CustomLoadingButton(
                title: LocaleKeys.view_doctor_delete.tr(),
                controller: _controller,
                onPressed: () async {
                  if (await isInternet()) {
                    if (_oldPassword != null && _oldPassword.length >= 8 && email != null) {
                      AuthService().passwordisvalid(_oldPassword);
                      passwordvalid = await AuthService().validatepass(_oldPassword);
                      if (passwordvalid) {
                        dynamic authResult = await AuthService().deleteUser(email, _oldPassword);
                        if (authResult != null) {
                          await getSuccess(_controller);
                          int count = 0;
                          Navigator.popUntil(context, (route) {
                            return count++ == 2;
                          });
                        } else
                          getFlushbar(context, LocaleKeys.error_can_not_delete.tr(), _controller);

                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeleteUser(oldPassword: _oldPassword)));
                      } else
                        getFlushbar(context, LocaleKeys.view_doctor_invalid_password.tr(), _controller);
                    } else
                      getFlushbar(context, LocaleKeys.error_sign_info.tr(), _controller);
                  } else
                    getFlushbar(context, LocaleKeys.error_snack_connectivity.tr(), _controller);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
