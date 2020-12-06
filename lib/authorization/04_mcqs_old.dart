// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:project_doctor/authorization/questions.dart';
// import 'package:project_doctor/constants/theme.dart';
// import 'package:project_doctor/services/database.dart';
// import 'package:provider/provider.dart';
// import 'package:project_doctor/ui/device_screen_type.dart';
// import 'package:project_doctor/ui/responsive_builder.dart';
// import 'package:project_doctor/ui/sizing_information.dart';

// class MCQS extends StatefulWidget {
//   final Function premcq;
//   final Function mcq;
//   final Function toggleview;
//   MCQS({this.premcq, this.mcq, this.toggleview});
//   @override
//   _MCQSState createState() => _MCQSState();
// }

// class _MCQSState extends State<MCQS> {
//   bool _isInternet = true;
//   checkInternet() async {
//     try {
//       final response = await InternetAddress.lookup('google.com');
//       if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
//         _isInternet = true; // internet
//         setState(() {});
//       }
//     } on SocketException catch (_) {
//       _isInternet = false; // no internet
//       setState(() {});
//     }
//   }

//   //-----------------this function will return a snackbar instead of the old one
//   final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
//   _showSnackBar() {
//     final _snackbar = new SnackBar(
//       content: Text(
//         QuestionsShuffle.snackerror,
//         style: TextStyle(fontSize: 15, fontFamily: 'Helvetica'),
//       ),
//       backgroundColor: Colors.deepOrange,
//     );
//     _scaffoldkey.currentState.showSnackBar(_snackbar);
//   }

//   @override
//   void initState() {
//     checkInternet();
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
//             key: _scaffoldkey,
//             backgroundColor: Colors.grey[200],
//             appBar: PreferredSize(
//               preferredSize: Size.fromHeight(appBarHeight),
//               child: AppBar(
//                 backgroundColor: Colors.deepOrange,
//                 actions: [
//                   FlatButton.icon(
//                     onPressed: () {
//                       checkInternet();
//                       if (_isInternet) {
//                         getscore1b();
//                         getscore2b();
//                         getscore3b();
//                         //getscore4b();
//                         if (QuestionsShuffle.score >= 3) {
//                           if (QuestionsShuffle.lenght > 3) {
//                             setState(() {
//                               QuestionsShuffle.counter += 3;
//                               QuestionsShuffle.lenght -= 3;
//                             });
//                           } else {
//                             setState(() {
//                               QuestionsShuffle.counter = 0;
//                               QuestionsShuffle.lenght = QuestionsShuffle.questions.length;
//                             });
//                           }
//                           DatabaseService(uid: QuestionsShuffle.uid).updateUserData(QuestionsShuffle.counter.toString(), 'tester', '0101001101010022',
//                               QuestionsShuffle.lenght.toString(), 0.0230, 0.0320, '', [], [], []);
//                           widget.mcq();
//                         } else {
//                           setState(() {
//                             QuestionsShuffle.snackerror = 'Please , answer the questions correctly';
//                           });
//                           _showSnackBar();
//                         }
//                       } else {
//                         setState(() {
//                           QuestionsShuffle.snackerror = 'No internet connection';
//                         });
//                         _showSnackBar();
//                       }
//                       setState(() {
//                         QuestionsShuffle.score = 0;
//                       });
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
//             body: Questions(),
//           ),
//         ),
//       );
//     });
//   }
// }

// class Questions extends StatefulWidget {
//   @override
//   _QuestionsState createState() => _QuestionsState();
// }

// class _QuestionsState extends State<Questions> {
//   @override
//   Widget build(BuildContext context) {
//     final questInfo = Provider.of<QuerySnapshot>(context);
//     if (questInfo != null) {
//       for (var y in questInfo.docs) {
//         if (y.data()['phoneNumber'] == '0101001101010022') {
//           QuestionsShuffle.uid = y.id;
//           QuestionsShuffle.counter = int.parse(y.data()['name']);
//           QuestionsShuffle.lenght = int.parse(y.data()['province']);
//         }
//       }
//     }
//     return ResponsiveBuilder(builder: (context, sizingInformation) {
//       double containerHeight;
//       double containerWidth;
//       double title;
//       double subTitle;
//       if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
//         containerHeight = displayHeight(context) * 0.75;
//         containerWidth = displayWidth(context) * 0.85;
//         title = displayWidth(context) * 0.045;
//         subTitle = displayWidth(context) * 0.035;
//       } else {
//         containerHeight = displayHeight(context) * 0.8;
//         containerWidth = displayWidth(context) * 0.65;
//         title = displayWidth(context) * 0.04;
//         subTitle = displayWidth(context) * 0.03;
//       }
//       return Directionality(
//         textDirection: TextDirection.ltr,
//         child: Center(
//           child: Container(
//             width: containerWidth,
//             height: containerHeight,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Text(
//                     'To register , answer the following :',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: title,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15.0,
//                   ),
//                   Container(
//                     decoration: boxDecoration,
//                     padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
//                     child: Column(
//                       children: [
//                         Center(
//                           child: Text(
//                             QuestionsShuffle.questions[QuestionsShuffle.counter],
//                             textAlign: TextAlign.justify,
//                             style: TextStyle(
//                               fontSize: subTitle,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         DropdownButton(
//                           // value: QuestionsShuffle.value1,
//                           isExpanded: true,
//                           hint: Text('Choose the Right answer'),

//                           items: [
//                             DropdownMenuItem<String>(
//                               value: '0',
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   QuestionsShuffle.choices[QuestionsShuffle.questions[QuestionsShuffle.counter]][0],
//                                   textDirection: TextDirection.ltr,
//                                 ),
//                               ),
//                             ),
//                             DropdownMenuItem<String>(
//                               value: '1',
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   QuestionsShuffle.choices[QuestionsShuffle.questions[QuestionsShuffle.counter]][1],
//                                   textDirection: TextDirection.ltr,
//                                 ),
//                               ),
//                             ),
//                             DropdownMenuItem<String>(
//                               value: '2',
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   QuestionsShuffle.choices[QuestionsShuffle.questions[QuestionsShuffle.counter]][2],
//                                   textDirection: TextDirection.ltr,
//                                 ),
//                               ),
//                             ),
//                             DropdownMenuItem<String>(
//                               value: '3',
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   QuestionsShuffle.choices[QuestionsShuffle.questions[QuestionsShuffle.counter]][3],
//                                   textDirection: TextDirection.ltr,
//                                 ),
//                               ),
//                             ),
//                             DropdownMenuItem<String>(
//                               value: '4',
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   QuestionsShuffle.choices[QuestionsShuffle.questions[QuestionsShuffle.counter]][4],
//                                   textDirection: TextDirection.ltr,
//                                 ),
//                               ),
//                             ),
//                             DropdownMenuItem<String>(
//                               value: '5',
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   QuestionsShuffle.choices[QuestionsShuffle.questions[QuestionsShuffle.counter]][5],
//                                   textDirection: TextDirection.ltr,
//                                 ),
//                               ),
//                             ),
//                           ],
//                           onChanged: (value) => selected1b(value),
//                           // value: QuestionsShuffle.value1,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15.0,
//                   ),
//                   Container(
//                     decoration: boxDecoration,
//                     padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
//                     child: Column(
//                       children: [
//                         Center(
//                           child: Text(
//                             QuestionsShuffle.questions[QuestionsShuffle.counter + 1],
//                             textAlign: TextAlign.justify,
//                             style: TextStyle(fontSize: subTitle),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         DropdownButton(
//                           isExpanded: true,
//                           hint: Text('Choose the Right answer'),
//                           items: [
//                             DropdownMenuItem<String>(
//                               value: '0',
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   QuestionsShuffle.choices[QuestionsShuffle.questions[QuestionsShuffle.counter + 1]][0],
//                                   textDirection: TextDirection.ltr,
//                                 ),
//                               ),
//                             ),
//                             DropdownMenuItem<String>(
//                               value: '1',
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   QuestionsShuffle.choices[QuestionsShuffle.questions[QuestionsShuffle.counter + 1]][1],
//                                   textDirection: TextDirection.ltr,
//                                 ),
//                               ),
//                             ),
//                             DropdownMenuItem<String>(
//                               value: '2',
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   QuestionsShuffle.choices[QuestionsShuffle.questions[QuestionsShuffle.counter + 1]][2],
//                                   textDirection: TextDirection.ltr,
//                                 ),
//                               ),
//                             ),
//                             DropdownMenuItem<String>(
//                               value: '3',
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   QuestionsShuffle.choices[QuestionsShuffle.questions[QuestionsShuffle.counter + 1]][3],
//                                   textDirection: TextDirection.ltr,
//                                 ),
//                               ),
//                             ),
//                             DropdownMenuItem<String>(
//                               value: '4',
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   QuestionsShuffle.choices[QuestionsShuffle.questions[QuestionsShuffle.counter + 1]][4],
//                                   textDirection: TextDirection.ltr,
//                                 ),
//                               ),
//                             ),
//                             DropdownMenuItem<String>(
//                               value: '5',
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   QuestionsShuffle.choices[QuestionsShuffle.questions[QuestionsShuffle.counter + 1]][5],
//                                   textDirection: TextDirection.ltr,
//                                 ),
//                               ),
//                             ),
//                           ],
//                           onChanged: (value) => selected2b(value),
//                           // value: QuestionsShuffle.value2,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15.0,
//                   ),
//                   Container(
//                     decoration: boxDecoration,
//                     padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
//                     child: Column(
//                       children: [
//                         Center(
//                           child: Text(
//                             QuestionsShuffle.questions[QuestionsShuffle.counter + 2],
//                             textAlign: TextAlign.justify,
//                             style: TextStyle(fontSize: subTitle),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         DropdownButton(
//                           isExpanded: true,
//                           hint: Text('Choose the Right answer'),
//                           items: [
//                             DropdownMenuItem<String>(
//                               value: '0',
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   QuestionsShuffle.choices[QuestionsShuffle.questions[QuestionsShuffle.counter + 2]][0],
//                                   textDirection: TextDirection.ltr,
//                                 ),
//                               ),
//                             ),
//                             DropdownMenuItem<String>(
//                               value: '1',
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   QuestionsShuffle.choices[QuestionsShuffle.questions[QuestionsShuffle.counter + 2]][1],
//                                   textDirection: TextDirection.ltr,
//                                 ),
//                               ),
//                             ),
//                             DropdownMenuItem<String>(
//                               value: '2',
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   QuestionsShuffle.choices[QuestionsShuffle.questions[QuestionsShuffle.counter + 2]][2],
//                                   textDirection: TextDirection.ltr,
//                                 ),
//                               ),
//                             ),
//                             DropdownMenuItem<String>(
//                               value: '3',
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   QuestionsShuffle.choices[QuestionsShuffle.questions[QuestionsShuffle.counter + 2]][3],
//                                   textDirection: TextDirection.ltr,
//                                 ),
//                               ),
//                             ),
//                             DropdownMenuItem<String>(
//                               value: '4',
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   QuestionsShuffle.choices[QuestionsShuffle.questions[QuestionsShuffle.counter + 2]][4],
//                                   textDirection: TextDirection.ltr,
//                                 ),
//                               ),
//                             ),
//                             DropdownMenuItem<String>(
//                               value: '5',
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   QuestionsShuffle.choices[QuestionsShuffle.questions[QuestionsShuffle.counter + 2]][5],
//                                   textDirection: TextDirection.ltr,
//                                 ),
//                               ),
//                             ),
//                           ],
//                           onChanged: (value) => selected3b(value),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
