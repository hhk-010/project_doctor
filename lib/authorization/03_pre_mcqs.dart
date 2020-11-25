import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/authorization/04_mcqs.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/database.dart';
import 'package:provider/provider.dart';

class MCQss {
  static var uid;
  static int counter = 0;
  static int length = QuestionsShuffle.questions.length;
  static String error = '';
}

class PreMCQs extends StatefulWidget {
  final Function signInToogleView;
  final Function preMCQToogleView;
  PreMCQs({this.signInToogleView, this.preMCQToogleView});

  @override
  _PreMCQsState createState() => _PreMCQsState();
}

class _PreMCQsState extends State<PreMCQs> {
  //-------------------checking internet connection
  bool _isInternet = true;
  checkInternet() async {
    try {
      final response = await InternetAddress.lookup('google.com');
      if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
        _isInternet = true; // internet
        setState(() {});
      }
    } on SocketException catch (_) {
      _isInternet = false; // no internet
      setState(() {});
    }
  }

  //this function will return a snackbar instead of the old one
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    final _snackbar = new SnackBar(
      content: Text(
        MCQss.error,
        style: TextStyle(fontSize: 15, fontFamily: 'Helvetica'),
      ),
      backgroundColor: Colors.deepOrange,
    );
    _scaffoldkey.currentState.showSnackBar(_snackbar);
  }

  //-------------------the end ----------------------
  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().doctorDataProfileStream,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          key: _scaffoldkey,
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            title: Text(''),
            actions: [
              // FlatButton.icon(
              //   onPressed: () {
              //     widget.signInToogleView();
              //   },
              //   icon: Icon(
              //     Icons.arrow_back,
              //     color: Colors.white,
              //   ),
              //   label: Text(
              //     'Sign in',
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ),
              FlatButton.icon(
                onPressed: () {
                  checkInternet();
                  if (_isInternet) {
                    if (MCQss.length > 3) {
                      setState(() {
                        MCQss.length -= 3;
                        MCQss.counter += 3;
                      });
                    } else {
                      setState(() {
                        MCQss.length = QuestionsShuffle.questions.length;
                        MCQss.counter = 0;
                      });
                    }
                    DatabaseService(uid: MCQss.uid).updateUserData(MCQss.counter.toString(), 'tester', '0101001101010022', MCQss.length.toString(),
                        0.000000230033, 0.000000032044, '', [], [], []);
                    widget.preMCQToogleView();
                  } else {
                    setState(() {
                      MCQss.error = 'No internet connection';
                    });
                    _showSnackBar();
                  }
                },
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                label: Text(
                  'Next',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          body: Postpremcq(),
        ),
      ),
    );
  }
}

class Postpremcq extends StatefulWidget {
  @override
  _PostpremcqState createState() => _PostpremcqState();
}

class _PostpremcqState extends State<Postpremcq> {
  @override
  Widget build(BuildContext context) {
    final preMcqSnap = Provider.of<QuerySnapshot>(context);
    if (preMcqSnap != null) {
      for (var x in preMcqSnap.docs) {
        if (x.data()['phoneNumber'] == '0101001101010022') {
          MCQss.uid = x.id;
          MCQss.counter = int.parse(x.data()['name']);
          MCQss.length = int.parse(x.data()['province']);
        }
      }
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
              width: double.infinity,
              decoration: boxDecoration,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 25),
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      child: Image(
                        image: AssetImage('assets/images/mcq.png'),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'Welcome to Cura',
                        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(
                      color: Colors.deepOrange,
                      thickness: 3,
                      indent: 30,
                      endIndent: 30,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'To Create a new account you must answer a few Medical Questions to Verify your Identity',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'If you already have an account return to the sign in page',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
