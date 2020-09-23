import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/pages/doctor_info.dart';
import 'package:project_doctor/authorization/register.dart';
import 'package:project_doctor/authorization/sign_in.dart';

class Intermediate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserIDModel>.value(
      value: AuthService().user,
      child: Wrapper(),
    );
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserIDModel>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return DoctorInfo();
    }
  }
}

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = false;
  void toogleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toogleView: toogleView);
    } else {
      return Register(toogleView: toogleView);
    }
  }
}
