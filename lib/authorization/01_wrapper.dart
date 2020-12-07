import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/authorization/04_mcqs_new.dart';
import 'package:project_doctor/authorization/email_verfication.dart';
import 'package:project_doctor/services/database.dart';
import 'package:provider/provider.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/auth.dart';
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
      child: GrandWrapper(),
    );
  }
}

class GrandWrapper extends StatefulWidget {
  @override
  _GrandWrapperState createState() => _GrandWrapperState();
}

class _GrandWrapperState extends State<GrandWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().doctorDataProfileStream,
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
    final userDoc = Provider.of<QuerySnapshot>(context);
    var docID;
    if (userDoc != null && user != null) {
      for (var x in userDoc.docs) {
        if (x.id == FirebaseAuth.instance.currentUser.uid) {
          docID = FirebaseAuth.instance.currentUser.uid;
        }
      }
    }
    if (user == null) {
      return Authenticate();
    } else {
      if (!FirebaseAuth.instance.currentUser.emailVerified || docID == null) {
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
  bool showQuestions = false;
  void questionsToogleView() {
    setState(() {
      showQuestions = !showQuestions;
    });
  }

  bool showRegister = false;
  void registerToggleView() {
    setState(() {
      showRegister = !showRegister;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showQuestions) {
      return QuestionsWidget(
        questionsToogleView: questionsToogleView,
        registerToggleView: registerToggleView,
      );
    } else {
      return SignIn(questionsToogleView: questionsToogleView);
    }
    /*if (showRegister) {
      return Register(
        registerToggleView: registerToggleView,
      );
    }*/
  }
}
