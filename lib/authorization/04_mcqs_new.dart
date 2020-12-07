import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_doctor/authorization/05_register.dart';
import 'package:project_doctor/authorization/questions.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/sizing_information.dart';

class QuestionsWidget extends StatefulWidget {
  final Function registerToggleView;
  final Function questionsToogleView;

  const QuestionsWidget({Key key, this.registerToggleView, this.questionsToogleView}) : super(key: key);

  @override
  _QuestionsWidgetState createState() => _QuestionsWidgetState();
}

class _QuestionsWidgetState extends State<QuestionsWidget> {
  List<int> counterList = Iterable<int>.generate(26).toList();

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  _showSnackBar() {
    final _snackbar = new SnackBar(
      content: Text(
        QuestionsShuffle.snackerror,
        style: TextStyle(fontSize: 15, fontFamily: 'Helvetica'),
      ),
      backgroundColor: Colors.deepOrange,
    );
    _scaffoldkey.currentState.showSnackBar(_snackbar);
  }

  @override
  void initState() {
    counterList.shuffle();

    super.initState();
  }

  String value1;
  String value2;
  String value3;
  String value4;
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
      QuestionsShuffle.value2 = QuestionsShuffle.choices[QuestionsShuffle.questions[question02]][int.parse(_value)];
    }

    void selected3b(_value) {
      QuestionsShuffle.value3 = QuestionsShuffle.choices[QuestionsShuffle.questions[question03]][int.parse(_value)];
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

    return ResponsiveBuilder(builder: (context, sizingInformation) {
      double appBarHeight;
      double appBarTitle;
      double containerHeight;
      double containerWidth;
      double buttonHeight;
      double buttonWidth;
      double title;
      double subTitle;
      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
        appBarHeight = 50;
        appBarTitle = 25;
        containerHeight = 25;
        containerWidth = displayWidth(context) * 0.85;
        title = displayWidth(context) * 0.045;
        subTitle = displayWidth(context) * 0.035;
        buttonHeight = displayHeight(context) * 0.05;
        buttonWidth = displayWidth(context) * 0.7;
      } else {
        appBarHeight = 75;
        appBarTitle = 50;
        containerHeight = 50;
        containerWidth = displayWidth(context) * 0.65;
        title = displayWidth(context) * 0.04;
        subTitle = displayWidth(context) * 0.03;
        buttonHeight = displayHeight(context) * 0.04;
        buttonWidth = displayWidth(context) * 0.4;
      }
      return Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
              key: _scaffoldkey,
              backgroundColor: Colors.grey[200],
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(appBarHeight),
                child: AppBar(
                  backgroundColor: Colors.deepOrange,
                  centerTitle: true,
                  elevation: 0,
                  title: Text(
                    'Questions',
                    style: TextStyle(fontSize: appBarTitle, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              body: Center(
                child: Container(
                  width: containerWidth,
                  padding: EdgeInsets.only(top: containerHeight),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Text(
                        'To Register , Answer the following :',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: title,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        decoration: boxDecoration,
                        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                QuestionsShuffle.questions[question01],
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: subTitle,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            DropdownButton(
                              isExpanded: true,
                              hint: Text( value1 == null ?'Choose the Right answer' : value1, style: TextStyle(font),),
                              items: [
                                DropdownMenuItem<String>(
                                  value: '0',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      QuestionsShuffle.choices[QuestionsShuffle.questions[question01]][0],
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: '1',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      QuestionsShuffle.choices[QuestionsShuffle.questions[question01]][1],
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: '2',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      QuestionsShuffle.choices[QuestionsShuffle.questions[question01]][2],
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: '3',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      QuestionsShuffle.choices[QuestionsShuffle.questions[question01]][3],
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: '4',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      QuestionsShuffle.choices[QuestionsShuffle.questions[question01]][4],
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: '5',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      QuestionsShuffle.choices[QuestionsShuffle.questions[question01]][5],
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ),
                                ),
                              ],
                              onChanged: (value) => selected1b(value),
                              // value: value1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Container(
                        decoration: boxDecoration,
                        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                QuestionsShuffle.questions[question02],
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: subTitle),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            DropdownButton(
                              isExpanded: true,
                              hint: Text('Choose the Right answer'),
                              items: [
                                DropdownMenuItem<String>(
                                  value: '0',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      QuestionsShuffle.choices[QuestionsShuffle.questions[question02]][0],
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: '1',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      QuestionsShuffle.choices[QuestionsShuffle.questions[question02]][1],
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: '2',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      QuestionsShuffle.choices[QuestionsShuffle.questions[question02]][2],
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: '3',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      QuestionsShuffle.choices[QuestionsShuffle.questions[question02]][3],
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: '4',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      QuestionsShuffle.choices[QuestionsShuffle.questions[question02]][4],
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: '5',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      QuestionsShuffle.choices[QuestionsShuffle.questions[question02]][5],
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ),
                                ),
                              ],
                              onChanged: (value) => selected2b(value),
                              // value: QuestionsShuffle.value2,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Container(
                        decoration: boxDecoration,
                        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                QuestionsShuffle.questions[question03],
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: subTitle),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            DropdownButton(
                              isExpanded: true,
                              hint: Text('Choose the Right answer'),
                              items: [
                                DropdownMenuItem<String>(
                                  value: '0',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      QuestionsShuffle.choices[QuestionsShuffle.questions[question03]][0],
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: '1',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      QuestionsShuffle.choices[QuestionsShuffle.questions[question03]][1],
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: '2',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      QuestionsShuffle.choices[QuestionsShuffle.questions[question03]][2],
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: '3',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      QuestionsShuffle.choices[QuestionsShuffle.questions[question03]][3],
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: '4',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      QuestionsShuffle.choices[QuestionsShuffle.questions[question03]][4],
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: '5',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      QuestionsShuffle.choices[QuestionsShuffle.questions[question03]][5],
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ),
                                ),
                              ],
                              onChanged: (value) => selected3b(value),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: buttonHeight,
                        width: buttonWidth,
                        child: RaisedButton.icon(
                          color: Colors.deepOrange,
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
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
                            style: TextStyle(color: Colors.white, fontSize: title, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ]),
                  ),
                ),
              )));
    });
  }
}
