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

class PasswordUpdateView extends StatefulWidget {
  @override
  _PasswordUpdateViewState createState() => _PasswordUpdateViewState();
}

class _PasswordUpdateViewState extends State<PasswordUpdateView> {
  static bool _isPasswordVisible;
  static bool _isPasswordValid;
  static String _oldPassword;
  static String _newPassword;
  final RoundedLoadingButtonController _controller = RoundedLoadingButtonController();
  @override
  void initState() {
    _isPasswordVisible = false;
    _isPasswordValid = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isAppbar: true,
      action: getAppActions(context),
      title: LocaleKeys.view_doctor_update_password.tr(),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          HomeAlignWidgets(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(
              top: getDeviceType(context, 25, 50, 75, 100),
            ),
            isIcon: false,
            height: getDeviceType(context, 120, 140, 160, 200),
            width: getDeviceType(context, 120, 140, 160, 200),
            asset: 'assets/images/update_password.png',
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: getDeviceType(context, 150, 150, 200, 250),
              width: getDeviceType(context, 250, 300, 350, 450),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: getDeviceType(context, 40, 50, 60, 70),
                    child: TextField(
                      decoration: CustomStyle.getInputDecoration(context).copyWith(
                        hintText: LocaleKeys.view_doctor_current_password.tr(),
                      ),
                      onChanged: (val) {
                        _oldPassword = val;
                      },
                    ),
                  ),
                  Container(
                    height: getDeviceType(context, 40, 50, 60, 70),
                    child: TextField(
                      obscureText: !_isPasswordVisible,
                      onChanged: (val) {
                        setState(() => _newPassword = val);
                      },
                      decoration: CustomStyle.getInputDecoration(context).copyWith(
                        hintText: LocaleKeys.view_doctor_new_password_hint.tr(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.deepOrange,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
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
                title: LocaleKeys.view_buttons_update.tr(),
                controller: _controller,
                onPressed: () async {
                  if (await isInternet()) {
                    if (_oldPassword != null && _oldPassword.isNotEmpty && _newPassword != null && _newPassword.isNotEmpty) {
                      AuthService().passwordisvalid(_oldPassword);
                      _isPasswordValid = await AuthService().validatepass(_oldPassword);
                      if (_isPasswordValid) {
                        AuthService().updatepass(_newPassword);
                        await getSuccess(_controller);
                        int count = 0;
                        Navigator.popUntil(context, (route) {
                          return count++ == 2;
                        });
                      } else {
                        getFlushbar(context, LocaleKeys.view_doctor_invalid_password.tr(), _controller);
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
        ],
      ),
    );
  }
}

// class PasswordUpdate extends StatefulWidget {
//   @override
//   _PasswordUpdateState createState() => _PasswordUpdateState();
// }

// class _PasswordUpdateState extends State<PasswordUpdate> {
//   String _oldPassword;
//   String _newPassword;
//   bool passwordvalid;
//   bool _passwordVisible;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldkey,
//       backgroundColor: Colors.grey[200],
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(50),
//         child: AppBar(
//           backgroundColor: Colors.deepOrange,
//           centerTitle: true,
//           title: FittedBox(
//             fit: BoxFit.fitWidth,
//             child: Text(
//               LocaleKeys.view_doctor_update_password.tr(),
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Center(
//         child: Container(
//           height: 100,
//           width: 100,
//           child: Form(
//             key: _formkey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ListView(
//                   shrinkWrap: true,
//                   children: [
//                     SizedBox(
//                       height: 100,
//                       child: Image(
//                         image: AssetImage(
//                           'assets/images/update_password.png',
//                         ),
//                       ),
//                     ),
//                     TextFormField(
//                       decoration: CStyle.getInputDecoration(context).copyWith(
//                         hintText: LocaleKeys.view_doctor_current_password.tr(),
//                       ),
//                       onChanged: (val) {
//                         _oldPassword = val;
//                       },
//                     ),
//                     TextFormField(
//                       obscureText: !_passwordVisible,
//                       onChanged: (val) {
//                         setState(() => _newPassword = val);
//                       },
//                       decoration: CStyle.getInputDecoration(context).copyWith(
//                         hintText: LocaleKeys.view_doctor_new_password_hint.tr(),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _passwordVisible ? Icons.visibility : Icons.visibility_off,
//                             color: Colors.deepOrange,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _passwordVisible = !_passwordVisible;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   height: 50,
//                   width: !isloading ? 150 : 50,
//                   child: LoadingButtonIcon(
//                     isloading: isloading,
//                     loadercolor: Colors.white,
//                     backgroundcolor: Colors.deepOrange,
//                     icon: Icon(
//                       Icons.arrow_forward,
//                       color: Colors.white,
//                     ),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
//                     onpressed: () async {
//                       checkInternet();
//                       if (_isInternet) {
//                         if (_formkey.currentState.validate()) {
//                           setState(() => isloading = true);
//                           AuthService().passwordisvalid(_oldPassword);
//                           passwordvalid = await AuthService().validatepass(_oldPassword);
//                           if (passwordvalid) {
//                             AuthService().updatepass(_newPassword);
//                             setState(() => isloading = false);
//                             int count = 0;
//                             Navigator.popUntil(context, (route) {
//                               return count++ == 2;
//                             });
//                           } else {
//                             setState(() {
//                               isloading = false;
//                               error = LocaleKeys.view_doctor_invalid_password.tr();
//                             });
//                             //--------snackbar problem
//                             _showSnackBar();
//                           }
//                         }
//                       } else {
//                         setState(() {
//                           error = LocaleKeys.error_snack_connectivity.tr();
//                         });
//                         _showSnackBar();
//                       }
//                     },
//                     label: Text(
//                       LocaleKeys.view_buttons_update.tr(),
//                       style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
