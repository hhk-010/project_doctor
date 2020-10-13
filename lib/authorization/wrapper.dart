import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/authorization/email_verfication.dart';
import 'package:project_doctor/authorization/mcqs.dart';
import 'package:project_doctor/authorization/premcqs.dart';
import 'package:provider/provider.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/authorization/register.dart';
import 'package:project_doctor/authorization/sign_in.dart';
import '../pages/doctor_pages/doctor_profile.dart';

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

  //---------------bools and functions  to toggle bt sign in / premcqs
  // mcqs and register------------------------------------------------
  bool showPrMCQ = true;
  void premcqtoggle() {
    setState(() {
      showPrMCQ = !showPrMCQ;
    });
  }

  bool showMCQ = true;
  void mcqtoggle() {
    setState(() {
      showMCQ = !showMCQ;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      if (showPrMCQ) {
        return Premcqs(
          premcq: premcqtoggle,
          toogleView: toogleView,
        );
      } else {
        if (showMCQ) {
          return Mcqs(
            mcq: mcqtoggle,
            premcq: premcqtoggle,
          );
        }
        return Register(
          mcq: mcqtoggle,
        );
      }
    } else {
      return SignIn(toogleView: toogleView);
    }
  }
}
