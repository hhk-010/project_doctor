import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/authorization/email_verfication.dart';
import 'package:project_doctor/authorization/04_mcqs.dart';
import 'package:project_doctor/authorization/03_pre_mcqs.dart';
import 'package:provider/provider.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/authorization/05_register.dart';
import 'package:project_doctor/authorization/02_sign_in.dart';
import '../pages/doctor_pages/doctor04_profile.dart';

class Intermediate extends StatefulWidget {
  @override
  _IntermediateState createState() => _IntermediateState();
}

class _IntermediateState extends State<Intermediate> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserID>.value(
      value: AuthService().user,
      child: Wrapper(),
    );
  }
}

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Timer _timer;
  @override
  void initState() {
    super.initState();
    Future(() async {
      _timer = Timer.periodic(Duration(seconds: 10), (timer) async {
        FirebaseAuth.instance.currentUser..reload();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);

    if (user == null) {
      return Authenticate();
    } else {
      if (!FirebaseAuth.instance.currentUser.emailVerified) {
        return EmailVerification();
      } else {
        return DoctorProfile();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }
}

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
//=================================toogle_functions
  bool showSignIn = false;
  void signInToogleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  bool showPreMCQ = true;
  void preMCQToogleView() {
    setState(() {
      showPreMCQ = !showPreMCQ;
    });
  }

  bool showMCQ = true;
  void mcqToogleView() {
    setState(() {
      showMCQ = !showMCQ;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      if (showPreMCQ) {
        return PreMCQs(
          preMCQToogleView: preMCQToogleView,
          signInToogleView: signInToogleView,
        );
      } else {
        if (showMCQ) {
          return MCQS(
            mcq: mcqToogleView,
            premcq: preMCQToogleView,
          );
        }
        return Register(
          mcq: mcqToogleView,
        );
      }
    } else {
      return SignIn(toogleView: signInToogleView);
    }
  }
}
