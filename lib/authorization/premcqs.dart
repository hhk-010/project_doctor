import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/database.dart';
import 'package:provider/provider.dart';

class MCQss {
  static var uid;
  static int counter = 0;
  static int length = 28;
}

class Premcqs extends StatefulWidget {
  final Function toogleView;
  final Function premcq;
  Premcqs({this.toogleView, this.premcq});

  @override
  _PremcqsState createState() => _PremcqsState();
}

class _PremcqsState extends State<Premcqs> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().doctorDataProfileStream,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text('Welcome'),
          actions: [
            FlatButton.icon(
              onPressed: () {
                widget.toogleView();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              label: Text(
                'Sign in',
                style: TextStyle(color: Colors.white),
              ),
            ),
            FlatButton.icon(
              onPressed: () {
                if (MCQss.length > 4) {
                  setState(() {
                    MCQss.length -= 4;
                    MCQss.counter += 4;
                  });
                } else {
                  setState(() {
                    MCQss.length = 28;
                    MCQss.counter = 0;
                  });
                }
                DatabaseService(uid: MCQss.uid).updateUserData(
                    MCQss.counter.toString(),
                    'tester',
                    '0101001101010022',
                    MCQss.length.toString(),
                    0.000000230033,
                    0.000000032044);
                widget.premcq();
              },
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              label: Text(
                'Register',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: Postpremcq(),
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
    final premcqsnap = Provider.of<QuerySnapshot>(context);
    if (premcqsnap != null) {
      for (var x in premcqsnap.docs) {
        if (x.data()['phoneNumber'] == '0101001101010022') {
          MCQss.uid = x.id;
          MCQss.counter = int.parse(x.data()['name']);
          MCQss.length = int.parse(x.data()['province']);
        }
      }
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30.0,
            ),
            Container(
              decoration: boxDecorationPatient,
              child: Column(
                children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  Center(
                    child: Text(
                      ' Welcome to you in Cura , to',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                  ),
                  Center(
                    child: Text(
                      'create a new account click',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Register',
                      style:
                          TextStyle(fontSize: 20.0, color: Colors.deepOrange),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              decoration: boxDecorationPatient,
              child: Column(
                children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  Center(
                    child: Text(
                      'If you have an account click',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Sign in',
                      style:
                          TextStyle(fontSize: 20.0, color: Colors.deepOrange),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
