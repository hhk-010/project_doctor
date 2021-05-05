import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_auth.dart';
import 'package:project_doctor/custom_widges/custom_base.dart';
import 'package:project_doctor/views/auth/questions.dart';
import 'package:project_doctor/views/auth/sign_up.dart';

class QuestionsWidget extends StatefulWidget {
  final Function registerToggleView;
  final Function questionsToogleView;

  const QuestionsWidget({Key key, this.registerToggleView, this.questionsToogleView}) : super(key: key);

  @override
  _QuestionsWidgetState createState() => _QuestionsWidgetState();
}

class _QuestionsWidgetState extends State<QuestionsWidget> {
  List<int> counterList = Iterable<int>.generate(26).toList();

  _showSnackBar() {
    final _snackbar = new SnackBar(
      content: Text(
        QuestionsShuffle.snackerror,
        style: TextStyle(fontSize: 15, fontFamily: 'Helvetica'),
      ),
      backgroundColor: Colors.deepOrange,
    );
    ScaffoldMessenger.of(context).showSnackBar(_snackbar);
  }

  @override
  void initState() {
    counterList.shuffle();
    super.initState();
  }

  String value1;
  String value2;
  String value3;
  @override
  Widget build(BuildContext context) {
    int question01 = counterList[1];
    int question02 = counterList[2];
    int question03 = counterList[3];

    void selected1b(_value) {
      setState(() {
        QuestionsShuffle.value1 = QuestionsShuffle.choices[QuestionsShuffle.questions[question01]][int.parse(_value)];
        value1 = QuestionsShuffle.value1;
      });
    }

    void selected2b(_value) {
      setState(() {
        QuestionsShuffle.value2 = QuestionsShuffle.choices[QuestionsShuffle.questions[question02]][int.parse(_value)];
        value2 = QuestionsShuffle.value2;
      });
    }

    void selected3b(_value) {
      setState(() {
        QuestionsShuffle.value3 = QuestionsShuffle.choices[QuestionsShuffle.questions[question03]][int.parse(_value)];
        value3 = QuestionsShuffle.value3;
      });
    }

    getscore1b() {
      if (QuestionsShuffle.value1 == QuestionsShuffle.answers[QuestionsShuffle.questions[question01]]) {
        QuestionsShuffle.score += 1;
      }
    }

    getscore2b() {
      if (QuestionsShuffle.value2 == QuestionsShuffle.answers[QuestionsShuffle.questions[question02]]) {
        QuestionsShuffle.score += 1;
      }
    }

    getscore3b() {
      if (QuestionsShuffle.value3 == QuestionsShuffle.answers[QuestionsShuffle.questions[question03]]) {
        QuestionsShuffle.score += 1;
      }
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: BaseScaffold(
        isAppbar: true,
        title: "Questions",
        child: Stack(alignment: Alignment.topCenter, children: [
          Positioned(
            top: 10,
            child: Text(
              'To Register, Answer the following :',
              style: CStyle.getTitle(context),
            ),
          ),
          Positioned(
            top: 50,
            child: Container(
              width: 350,
              height: 200,
              decoration: CStyle.box,
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
              child: Column(
                children: [
                  CustomQuestion(
                    questionIndex: question01,
                    answer: value1,
                    onChanged: (value) => selected1b(value),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            width: 150,
            child: TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
              ),
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              onPressed: () {
                getscore1b();
                getscore2b();
                getscore3b();
                if (QuestionsShuffle.score >= 3) {
                  //widget.registerToggleView();
                  //widget.questionsToogleView();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Register()));
                } else {
                  setState(() {
                    QuestionsShuffle.snackerror = 'Please , answer the questions correctly';
                  });
                  _showSnackBar();
                }
                setState(() {
                  QuestionsShuffle.score = 0;
                });
              },
              label: Text(
                'Next',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
