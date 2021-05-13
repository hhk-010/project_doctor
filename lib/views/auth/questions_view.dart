import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_flushbar.dart';
import 'package:project_doctor/custom_widges/custom_mcq.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/views/auth/questions.dart';
import 'package:project_doctor/views/auth/sign_up.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class QuestionView extends StatefulWidget {
  final Function registerToggleView;
  final Function questionsToogleView;

  const QuestionView({Key key, this.registerToggleView, this.questionsToogleView}) : super(key: key);

  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  final RoundedLoadingButtonController _controller = RoundedLoadingButtonController();

  List<int> counterList = Iterable<int>.generate(26).toList();

  @override
  void initState() {
    counterList.shuffle();
    super.initState();
  }

  String currentValue1;
  String currentValue2;
  String currentValue3;
  @override
  Widget build(BuildContext context) {
    int questionIndex1 = counterList[1];
    int questionIndex2 = counterList[2];
    int questionIndex3 = counterList[3];

    return Directionality(
      textDirection: TextDirection.ltr,
      child: BaseScaffold(
        isAppbar: true,
        action: getAppActions(context),
        title: "Questions",
        child: Stack(alignment: Alignment.topCenter, children: [
          Positioned(
            top: getDeviceType(context, 10, 15, 25, 35),
            child: Text(
              'To Register, Answer the Questions:',
              style: CustomStyle.getTitleBlack(context),
            ),
          ),
          Positioned(
            top: getDeviceType(context, 35, 50, 75, 100),
            height: getDeviceType(context, 425, 620, 750, 900),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomQuestion(
                    questionIndex: questionIndex1,
                    answer: currentValue1,
                    onChanged: (val) {
                      setState(() {
                        QuestionsShuffle.value1 = QuestionsShuffle.choices[QuestionsShuffle.questions[questionIndex1]][int.parse(val)];
                        currentValue1 = QuestionsShuffle.value1;
                      });
                    },
                  ),
                  SizedBox(
                    height: getDeviceType(context, 10, 15, 30, 35),
                  ),
                  CustomQuestion(
                    questionIndex: questionIndex2,
                    answer: currentValue2,
                    onChanged: (val) {
                      setState(() {
                        QuestionsShuffle.value2 = QuestionsShuffle.choices[QuestionsShuffle.questions[questionIndex2]][int.parse(val)];
                        currentValue2 = QuestionsShuffle.value2;
                      });
                    },
                  ),
                  SizedBox(
                    height: getDeviceType(context, 10, 15, 30, 35),
                  ),
                  CustomQuestion(
                    questionIndex: questionIndex3,
                    answer: currentValue3,
                    onChanged: (val) {
                      setState(() {
                        QuestionsShuffle.value3 = QuestionsShuffle.choices[QuestionsShuffle.questions[questionIndex3]][int.parse(val)];
                        currentValue3 = QuestionsShuffle.value3;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: getDeviceType(context, 15, 25, 65, 100),
            child: CustomLoadingButton(
                controller: _controller,
                title: 'Next',
                onPressed: () async {
                  if (QuestionsShuffle.value1 == QuestionsShuffle.answers[QuestionsShuffle.questions[questionIndex1]]) QuestionsShuffle.score += 1;
                  if (QuestionsShuffle.value2 == QuestionsShuffle.answers[QuestionsShuffle.questions[questionIndex2]]) QuestionsShuffle.score += 1;
                  if (QuestionsShuffle.value3 == QuestionsShuffle.answers[QuestionsShuffle.questions[questionIndex3]]) QuestionsShuffle.score += 1;
                  if (QuestionsShuffle.score >= 3) {
                    await getSuccess(_controller);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpView()));
                  } else
                    getFlushbar(context, 'Please, Answer the questions correctly', _controller);

                  setState(() {
                    QuestionsShuffle.score = 0;
                  });
                }),
          )
        ]),
      ),
    );
  }
}
