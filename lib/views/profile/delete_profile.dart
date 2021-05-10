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
            padding: EdgeInsets.only(top: 50),
            isIcon: false,
            height: 140,
            width: 140,
            asset: 'assets/images/delete.png',
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 200,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    obscureText: !_passwordVisible,
                    decoration: CStyle.getInputDecoration(context).copyWith(
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
                  TextFormField(
                    decoration: CStyle.getInputDecoration(context).copyWith(
                      hintText: LocaleKeys.view_doctor_enter_your_email.tr(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) {
                      email = val;
                    },
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 100),
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
                          getSuccess(_controller);
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
