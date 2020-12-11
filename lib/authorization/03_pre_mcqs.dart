// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:project_doctor/authorization/04_mcqs_new.dart';
// import 'package:project_doctor/authorization/questions.dart';
// import 'package:project_doctor/constants/theme.dart';
// import 'package:project_doctor/services/database.dart';
// import 'package:project_doctor/ui/device_screen_type.dart';
// import 'package:project_doctor/ui/responsive_builder.dart';
// import 'package:project_doctor/ui/sizing_information.dart';
// import 'package:provider/provider.dart';

// class MCQss {
//   static var uid;
//   static int counter = 0;
//   static int length = QuestionsShuffle.questions.length;
//   static String error = '';
// }

// class PreMCQs extends StatefulWidget {
//   final Function signInToogleView;
//   final Function preMCQToogleView;
//   PreMCQs({this.signInToogleView, this.preMCQToogleView});

//   @override
//   _PreMCQsState createState() => _PreMCQsState();
// }

// class _PreMCQsState extends State<PreMCQs> {
//   //-------------------checking internet connection
//   // bool _isInternet = true;
//   // checkInternet() async {
//   //   try {
//   //     final response = await InternetAddress.lookup('google.com');
//   //     if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
//   //       _isInternet = true; // internet
//   //       setState(() {});
//   //     }
//   //   } on SocketException catch (_) {
//   //     _isInternet = false; // no internet
//   //     setState(() {});
//   //   }
//   // }

//   //this function will return a snackbar instead of the old one
//   final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
//   // _showSnackBar() {
//   //   final _snackbar = new SnackBar(
//   //     content: Text(
//   //       MCQss.error,
//   //       style: TextStyle(fontSize: 15, fontFamily: 'Helvetica'),
//   //     ),
//   //     backgroundColor: Colors.deepOrange,
//   //   );
//   //   _scaffoldkey.currentState.showSnackBar(_snackbar);
//   // }

//   //-------------------the end ----------------------
//   @override
//   void initState() {
//     // checkInternet();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveBuilder(builder: (context, sizingInformation) {
//       double appBarHeight;
//       double appBarAction;
//       if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
//         appBarHeight = 50;
//         appBarAction = 16;
//       } else {
//         appBarHeight = 75;
//         appBarAction = 25;
//       }
//       return StreamProvider<QuerySnapshot>.value(
//         value: DatabaseService().doctorDataProfileStream,
//         child: Directionality(
//           textDirection: TextDirection.ltr,
//           child: Scaffold(
//             resizeToAvoidBottomInset: false,
//             key: _scaffoldkey,
//             backgroundColor: Colors.grey[200],
//             appBar: PreferredSize(
//               preferredSize: Size.fromHeight(appBarHeight),
//               child: AppBar(
//                 backgroundColor: Colors.deepOrange,
//                 elevation: 0,
//                 title: Text(''),
//                 actions: [
//                   FlatButton.icon(
//                     onPressed: () {
//                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuestionsWidget())); // checkInternet();
//                       // if (_isInternet) {
//                       //   if (MCQss.length > 3) {
//                       //     setState(() {
//                       //       MCQss.length -= 3;
//                       //       MCQss.counter += 3;
//                       //     });
//                       //   } else {
//                       //     setState(() {
//                       //       MCQss.length = QuestionsShuffle.questions.length;
//                       //       MCQss.counter = 0;
//                       //     });
//                       //   }
//                       //   DatabaseService(uid: MCQss.uid).updateUserData(
//                       //       MCQss.counter.toString(),
//                       //       'tester',
//                       //       '0101001101010022',
//                       //       MCQss.length.toString(),
//                       //       0.0230,
//                       //       0.0320,
//                       //       '', [], [], []);
//                       //   widget.preMCQToogleView();
//                       // } else {
//                       //   setState(() {
//                       //     MCQss.error = 'No internet connection';
//                       //   });
//                       //   _showSnackBar();
//                       // }
//                     },
//                     icon: Icon(
//                       Icons.arrow_forward,
//                       color: Colors.white,
//                     ),
//                     label: Text(
//                       'Next',
//                       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: appBarAction),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             body: Postpremcq(),
//           ),
//         ),
//       );
//     });
//   }
// }

// class Postpremcq extends StatefulWidget {
//   @override
//   _PostpremcqState createState() => _PostpremcqState();
// }

// class _PostpremcqState extends State<Postpremcq> {
//   @override
//   Widget build(BuildContext context) {
//     final preMcqSnap = Provider.of<QuerySnapshot>(context);
//     if (preMcqSnap != null) {
//       for (var x in preMcqSnap.docs) {
//         if (x.data()['phoneNumber'] == '0101001101010022') {
//           MCQss.uid = x.id;
//           MCQss.counter = int.parse(x.data()['name']);
//           MCQss.length = int.parse(x.data()['province']);
//         }
//       }
//     }
//     return ResponsiveBuilder(builder: (context, sizingInformation) {
//       double containerHeight;
//       double containerWidth;
//       double title;
//       double subTitle;
//       double footer;
//       double imageSize;

//       if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
//         containerHeight = displayHeight(context) * 0.75;
//         containerWidth = displayWidth(context) * 0.85;
//         title = displayWidth(context) * 0.05;
//         subTitle = displayWidth(context) * 0.04;
//         footer = displayWidth(context) * 0.03;
//         imageSize = 150;
//       } else {
//         containerHeight = displayHeight(context) * 0.8;
//         containerWidth = displayWidth(context) * 0.65;
//         title = displayWidth(context) * 0.05;
//         subTitle = displayWidth(context) * 0.035;
//         footer = displayWidth(context) * 0.03;
//         imageSize = 200;
//       }
//       return Center(
//         child: Container(
//           height: containerHeight,
//           width: containerWidth,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Directionality(
//                 textDirection: TextDirection.ltr,
//                 child: Container(
//                   decoration: boxDecoration,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 25),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: imageSize,
//                           child: Image(
//                             image: AssetImage('assets/images/mcq.png'),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 25,
//                         ),
//                         FittedBox(
//                           fit: BoxFit.fitWidth,
//                           child: Text(
//                             'Welcome to Cura',
//                             style: TextStyle(fontSize: title, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Divider(
//                           color: Colors.deepOrange,
//                           thickness: 3,
//                           indent: 30,
//                           endIndent: 30,
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Text(
//                           'To Create a new account you must answer a few Medical Questions to Verify your Identity',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: subTitle, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(
//                           height: 50,
//                         ),
//                         Text(
//                           'If you already have an account return to the sign in page',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: footer, fontWeight: FontWeight.bold, color: Colors.red),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  String phoneNumber = '';
  String code = '';
  String verificationId = '';


  /*PhoneAuthOptions options = PhoneAuthOptions.newBuilder(mAuth).setPhoneNumber(phoneNumber).setTimeout(60L, TimeUnit.SECONDS).setActivity(this).setCallbacks(mCallbacks).build();
  PhoneAuthProvider.verifyPhoneNumber(options);  */


  Future<bool> verifyNumber(String phoneNumber, BuildContext context) async {

       
    /*final PhoneCodeAutoRetrievalTimeout autoRetrieval = (String verId) {
      this.verificationId = verId;
    };

    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credentials) {
          Navigator.pop(context);
          print('yes its mine');
        },
        verificationFailed: (FirebaseAuthException exception) {
          print('no its not');
        },
        codeSent: (String verificationId, [int forceResendToken]) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text('enter code'),
                content: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: 'enter code here'),
                      onChanged: (val) => code = val,
                    ),
                  ],
                ),
                actions: [
                  RaisedButton(
                    onPressed: () {
                      AuthCredential credentials = PhoneAuthProvider.credential(
                          verificationId: verificationId, smsCode: code);
                      if (code == verificationId) {
                        print('number==credentials');
                      } else {
                        print('no its not equal');
                      }
                      print('hello' + credentials.toString());
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
        codeAutoRetrievalTimeout: autoRetrieval);*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Number'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          SizedBox(height: 20.0),
          TextFormField(
            decoration: InputDecoration(hintText: 'Enter Number'),
            onChanged: (val) => phoneNumber = val,
          ),
          SizedBox(height: 20.0),
          RaisedButton(
            onPressed: () {
              verifyNumber(phoneNumber, context);
            },
            child: Text('verified'),
          ),
        ],
      ),
    );
  }
}*/
