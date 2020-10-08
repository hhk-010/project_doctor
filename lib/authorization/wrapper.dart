import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/authorization/verify.dart';
import 'package:provider/provider.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/authorization/register.dart';
import 'package:project_doctor/authorization/sign_in.dart';
import '../pages/doctor_pages/doctor_profile.dart';

class Intermediate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserID>.value(
      value: AuthService().user,
      child: Wrapper(),
    );
  }
}

class IsVerified {
  static bool verification = false;
}

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
 

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);

    if (user == null) {
      return Authenticate();
    } else {
      if (!FirebaseAuth.instance.currentUser.emailVerified) {
        return Verify();
      } else {
        return DoctorProfile();
      }
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
      return Register(toogleView: toogleView);
    } else {
      return SignIn(toogleView: toogleView);
    }
  }
}
