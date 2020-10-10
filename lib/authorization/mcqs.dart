import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/database.dart';
import 'package:provider/provider.dart';

class Mcqs extends StatefulWidget {
  final Function premcq;
  final Function mcq;
  Mcqs({this.premcq, this.mcq});
  @override
  _McqsState createState() => _McqsState();
}

class _McqsState extends State<Mcqs> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().doctorDataProfileStream,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text('Questions'),
          actions: [
            FlatButton.icon(
              onPressed: () {
                widget.premcq();
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
                getscoreb();
                getscore2b();
                if (questa.score >= 2) {
                  if (questa.lenght > 2) {
                    setState(() {
                      questa.counter += 2;
                      questa.lenght -= 2;
                    });
                  } else {
                    setState(() {
                      questa.counter = 0;
                      questa.lenght = 4;
                    });
                  }
                  DatabaseService(uid: questa.uid).updateUserData(
                      questa.counter.toString(),
                      'counter',
                      '0101001101010022',
                      questa.lenght.toString(),
                      0.0000023003,
                      0.0000054003);
                  widget.mcq();
                }
                setState(() {
                  questa.score = 0;
                });
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
        body: Questions(),
      ),
    );
  }
}

class Questions extends StatefulWidget {
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  @override
  Widget build(BuildContext context) {
    final questinfo = Provider.of<QuerySnapshot>(context);
    if (questinfo != null) {
      for (var y in questinfo.docs) {
        if (y.data()['phoneNumber'] == '0101001101010022') {
          questa.uid = y.id;
          questa.counter = int.parse(y.data()['name']);
          questa.lenght = int.parse(y.data()['province']);
        }
      }
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15.0,
            ),
            Center(
              child: Text(
                'To register , answer the following :',
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              decoration: boxDecorationPatient,
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      questa.qss[questa.counter],
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  DropdownButton(
                    isExpanded: true,
                    hint: Text('Choose the right answer'),
                    items: [
                      DropdownMenuItem<String>(
                        value: '0',
                        child: Center(
                          child: Text(
                              questa.choices[questa.qss[questa.counter]][0]),
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: '1',
                        child: Center(
                          child: Text(
                              questa.choices[questa.qss[questa.counter]][1]),
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: '2',
                        child: Center(
                          child: Text(
                              questa.choices[questa.qss[questa.counter]][2]),
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: '3',
                        child: Center(
                          child: Text(
                              questa.choices[questa.qss[questa.counter]][3]),
                        ),
                      ),
                    ],
                    onChanged: (value) => selectedb(value),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              decoration: boxDecorationPatient,
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      questa.qss[questa.counter + 1],
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  DropdownButton(
                    isExpanded: true,
                    hint: Text('Choose the right answer'),
                    items: [
                      DropdownMenuItem<String>(
                        value: '0',
                        child: Center(
                          child: Text(questa
                              .choices[questa.qss[questa.counter + 1]][0]),
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: '1',
                        child: Center(
                          child: Text(questa
                              .choices[questa.qss[questa.counter + 1]][1]),
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: '2',
                        child: Center(
                          child: Text(questa
                              .choices[questa.qss[questa.counter + 1]][2]),
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: '3',
                        child: Center(
                          child: Text(questa
                              .choices[questa.qss[questa.counter + 1]][3]),
                        ),
                      ),
                    ],
                    onChanged: (value22) => selected2b(value22),
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

class questa {
  static var uid;
  static int counter = 0;
  static int lenght = 4;
  static String value;
  static String value2;
  static int score = 0;
  static List qss = [
    '60 years old male with +ve PMH for HTN and DM presented to the ER complaining of central suffocating chest pain,dyspnea and vomiting OE conscious ,looks ill ,BP 190/100,ecg shows St segment elevation in L1,aVL,V5,V6 with reciprocal changes with elevated serum troponin,what is the most likely dx?',
    'what is your age?',
    'what is your hair color?',
    'what is your favorite food?'
  ];
  static Map choices = {
    '60 years old male with +ve PMH for HTN and DM presented to the ER complaining of central suffocating chest pain,dyspnea and vomiting OE conscious ,looks ill ,BP 190/100,ecg shows St segment elevation in L1,aVL,V5,V6 with reciprocal changes with elevated serum troponin,what is the most likely dx?':
        ['a1', 'a2', 'a3', 'a4'],
    'what is your age?': ['aa1', 'aa2', 'aa3', 'aa4'],
    'what is your hair color?': ['ab1', 'ab2', 'ab3', 'ab4'],
    'what is your favorite food?': ['ac1', 'ac2', 'ac3', 'ac4'],
  };
  static Map answers = {
    '60 years old male with +ve PMH for HTN and DM presented to the ER complaining of central suffocating chest pain,dyspnea and vomiting OE conscious ,looks ill ,BP 190/100,ecg shows St segment elevation in L1,aVL,V5,V6 with reciprocal changes with elevated serum troponin,what is the most likely dx?':
        'a1',
    'what is your age?': 'aa2',
    'what is your hair color?': 'ab3',
    'what is your favorite food?': 'ac4'
  };
}

void selectedb(_value) {
  questa.value = questa.choices[questa.qss[questa.counter]][int.parse(_value)];
  print(questa.value);
}

void selected2b(_value) {
  questa.value2 =
      questa.choices[questa.qss[questa.counter + 1]][int.parse(_value)];
  print(questa.value2);
}

getscoreb() {
  if (questa.value == questa.answers[questa.qss[questa.counter]]) {
    questa.score += 1;
  }
}

getscore2b() {
  if (questa.value2 == questa.answers[questa.qss[questa.counter + 1]]) {
    questa.score += 1;
  }
}
