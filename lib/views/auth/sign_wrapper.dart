import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/services/database.dart';
import 'package:project_doctor/views/auth/email_verfication.dart';
import 'package:project_doctor/views/auth/mcq_view.dart';
import 'package:project_doctor/views/auth/sign_in_view.dart';
import 'package:project_doctor/views/profile/doctor04_profile.dart';
import 'package:provider/provider.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/auth.dart';

class Intermediate extends StatefulWidget {
  @override
  _IntermediateState createState() => _IntermediateState();
}

class _IntermediateState extends State<Intermediate> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserID>.value(
      initialData: null,
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
      initialData: null,
      value: DatabaseService().baghdadDoctorDataProfileStream,
      child: Wrapper(),
    );
  }
}

class Wrapper01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    final userDoc = Provider.of<QuerySnapshot>(context);
    if (userDoc != null && user != null) {
      for (var x in userDoc.docs) {
        if (x.id == FirebaseAuth.instance.currentUser.uid) {
          Wrapper.docId = FirebaseAuth.instance.currentUser.uid;
          DatabaseService.province = x.data()['province'];
        }
      }
    }
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().babilDoctorDataProfileStream,
      child: Wrapper02(),
    );
  }
}

class Wrapper02 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    final userDoc = Provider.of<QuerySnapshot>(context);
    if (userDoc != null && user != null) {
      for (var x in userDoc.docs) {
        if (x.id == FirebaseAuth.instance.currentUser.uid) {
          Wrapper.docId = FirebaseAuth.instance.currentUser.uid;
          DatabaseService.province = x.data()['province'];
        }
      }
    }
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().basrahDoctorDataProfileStream,
      child: Wrapper03(),
    );
  }
}

class Wrapper03 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    final userDoc = Provider.of<QuerySnapshot>(context);
    if (userDoc != null && user != null) {
      for (var x in userDoc.docs) {
        if (x.id == FirebaseAuth.instance.currentUser.uid) {
          Wrapper.docId = FirebaseAuth.instance.currentUser.uid;
          DatabaseService.province = x.data()['province'];
        }
      }
    }

    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().erbilDoctorDataProfileStream,
      child: Wrapper04(),
    );
  }
}

class Wrapper04 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    final userDoc = Provider.of<QuerySnapshot>(context);
    if (userDoc != null && user != null) {
      for (var x in userDoc.docs) {
        if (x.id == FirebaseAuth.instance.currentUser.uid) {
          Wrapper.docId = FirebaseAuth.instance.currentUser.uid;
          DatabaseService.province = x.data()['province'];
        }
      }
    }
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().sulaymaniahDoctorDataProfileStream,
      child: Wrapper05(),
    );
  }
}

class Wrapper05 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    final userDoc = Provider.of<QuerySnapshot>(context);
    if (userDoc != null && user != null) {
      for (var x in userDoc.docs) {
        if (x.id == FirebaseAuth.instance.currentUser.uid) {
          Wrapper.docId = FirebaseAuth.instance.currentUser.uid;
          DatabaseService.province = x.data()['province'];
        }
      }
    }
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().duhokDoctorDataProfileStream,
      child: Wrapper06(),
    );
  }
}

class Wrapper06 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    final userDoc = Provider.of<QuerySnapshot>(context);
    if (userDoc != null && user != null) {
      for (var x in userDoc.docs) {
        if (x.id == FirebaseAuth.instance.currentUser.uid) {
          Wrapper.docId = FirebaseAuth.instance.currentUser.uid;
          DatabaseService.province = x.data()['province'];
        }
      }
    }
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().kirkokDoctorDataProfileStream,
      child: Wrapper07(),
    );
  }
}

class Wrapper07 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    final userDoc = Provider.of<QuerySnapshot>(context);
    if (userDoc != null && user != null) {
      for (var x in userDoc.docs) {
        if (x.id == FirebaseAuth.instance.currentUser.uid) {
          Wrapper.docId = FirebaseAuth.instance.currentUser.uid;
          DatabaseService.province = x.data()['province'];
        }
      }
    }
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().diyalaDoctorDataProfileStream,
      child: Wrapper08(),
    );
  }
}

class Wrapper08 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    final userDoc = Provider.of<QuerySnapshot>(context);
    if (userDoc != null && user != null) {
      for (var x in userDoc.docs) {
        if (x.id == FirebaseAuth.instance.currentUser.uid) {
          Wrapper.docId = FirebaseAuth.instance.currentUser.uid;
          DatabaseService.province = x.data()['province'];
        }
      }
    }
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().saladinDoctorDataProfileStream,
      child: Wrapper09(),
    );
  }
}

class Wrapper09 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    final userDoc = Provider.of<QuerySnapshot>(context);
    if (userDoc != null && user != null) {
      for (var x in userDoc.docs) {
        if (x.id == FirebaseAuth.instance.currentUser.uid) {
          Wrapper.docId = FirebaseAuth.instance.currentUser.uid;
          DatabaseService.province = x.data()['province'];
        }
      }
    }
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().ninevehDoctorDataProfileStream,
      child: Wrapper10(),
    );
  }
}

class Wrapper10 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    final userDoc = Provider.of<QuerySnapshot>(context);
    if (userDoc != null && user != null) {
      for (var x in userDoc.docs) {
        if (x.id == FirebaseAuth.instance.currentUser.uid) {
          Wrapper.docId = FirebaseAuth.instance.currentUser.uid;
          DatabaseService.province = x.data()['province'];
        }
      }
    }
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().anbarDoctorDataProfileStream,
      child: Wrapper11(),
    );
  }
}

class Wrapper11 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    final userDoc = Provider.of<QuerySnapshot>(context);
    if (userDoc != null && user != null) {
      for (var x in userDoc.docs) {
        if (x.id == FirebaseAuth.instance.currentUser.uid) {
          Wrapper.docId = FirebaseAuth.instance.currentUser.uid;
          DatabaseService.province = x.data()['province'];
        }
      }
    }
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().karbalaDoctorDataProfileStream,
      child: Wrapper12(),
    );
  }
}

class Wrapper12 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    final userDoc = Provider.of<QuerySnapshot>(context);
    if (userDoc != null && user != null) {
      for (var x in userDoc.docs) {
        if (x.id == FirebaseAuth.instance.currentUser.uid) {
          Wrapper.docId = FirebaseAuth.instance.currentUser.uid;
          DatabaseService.province = x.data()['province'];
        }
      }
    }
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().wasitDoctorDataProfileStream,
      child: Wrapper13(),
    );
  }
}

class Wrapper13 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    final userDoc = Provider.of<QuerySnapshot>(context);
    if (userDoc != null && user != null) {
      for (var x in userDoc.docs) {
        if (x.id == FirebaseAuth.instance.currentUser.uid) {
          Wrapper.docId = FirebaseAuth.instance.currentUser.uid;
          DatabaseService.province = x.data()['province'];
        }
      }
    }
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().najafDoctorDataProfileStream,
      child: Wrapper14(),
    );
  }
}

class Wrapper14 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    final userDoc = Provider.of<QuerySnapshot>(context);
    if (userDoc != null && user != null) {
      for (var x in userDoc.docs) {
        if (x.id == FirebaseAuth.instance.currentUser.uid) {
          Wrapper.docId = FirebaseAuth.instance.currentUser.uid;
          DatabaseService.province = x.data()['province'];
        }
      }
    }
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().maysanDoctorDataProfileStream,
      child: Wrapper15(),
    );
  }
}

class Wrapper15 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    final userDoc = Provider.of<QuerySnapshot>(context);
    if (userDoc != null && user != null) {
      for (var x in userDoc.docs) {
        if (x.id == FirebaseAuth.instance.currentUser.uid) {
          Wrapper.docId = FirebaseAuth.instance.currentUser.uid;
          DatabaseService.province = x.data()['province'];
        }
      }
    }
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().dhiqarDoctorDataProfileStream,
      child: Wrapper16(),
    );
  }
}

class Wrapper16 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    final userDoc = Provider.of<QuerySnapshot>(context);

    if (userDoc != null && user != null) {
      for (var x in userDoc.docs) {
        if (x.id == FirebaseAuth.instance.currentUser.uid) {
          Wrapper.docId = FirebaseAuth.instance.currentUser.uid;
          DatabaseService.province = x.data()['province'];
        }
      }
    }
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().muthanaDoctorDataProfileStream,
      child: Wrapper17(),
    );
  }
}

class Wrapper17 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    final userDoc = Provider.of<QuerySnapshot>(context);

    if (userDoc != null && user != null) {
      for (var x in userDoc.docs) {
        if (x.id == FirebaseAuth.instance.currentUser.uid) {
          Wrapper.docId = FirebaseAuth.instance.currentUser.uid;
          DatabaseService.province = x.data()['province'];
        }
      }
    }
    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: DatabaseService().qadiseyahoctorDataProfileStream,
      child: Wrapper(),
    );
  }
}

class Wrapper extends StatefulWidget {
  static var docId;
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
    if (userDoc != null && user != null) {
      for (var x in userDoc.docs) {
        if (x.id == FirebaseAuth.instance.currentUser.uid) {
          Wrapper.docId = FirebaseAuth.instance.currentUser.uid;
          DatabaseService.province = x.data()['province'];
        }
      }
    }
    if (user == null) {
      return Authenticate();
    } else {
      if (!FirebaseAuth.instance.currentUser.emailVerified || Wrapper.docId == null) {
        return EmailVerification();
      } else {
        return Profile();
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
      return QuestionView(
        questionsToogleView: questionsToogleView,
        registerToggleView: registerToggleView,
      );
    } else {
      return SignInViewM(questionsToogleView: questionsToogleView);
    }
    /*if (showRegister) {
      return Register(
        registerToggleView: registerToggleView,
      );
    }*/
  }
}
