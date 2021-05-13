import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/views/auth/questions.dart';

class CustomQuestion extends StatelessWidget {
  final String answer;
  final Function onChanged;
  final int questionIndex;

  const CustomQuestion({
    Key key,
    this.questionIndex,
    this.answer,
    this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getDeviceType(context, 275, 350, 450, 650),
      decoration: CustomStyle.box,
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(QuestionsShuffle.questions[questionIndex], textAlign: TextAlign.justify, style: CustomStyle.getSubtitle(context)),
          DropdownButton(
            isExpanded: true,
            hint: Text(answer == null ? 'Choose the Right answer' : answer,
                style: CustomStyle.getTitle(context).copyWith(
                  color:
                      answer == null ? getColor(context, Colors.grey[600], Colors.grey[500]) : getColor(context, Colors.grey[900], Colors.grey[100]),
                )),
            items: [
              getMenuItem(context, '0', questionIndex, 0),
              getMenuItem(context, '1', questionIndex, 1),
              getMenuItem(context, '2', questionIndex, 2),
              getMenuItem(context, '3', questionIndex, 3),
              getMenuItem(context, '4', questionIndex, 4),
              getMenuItem(context, '5', questionIndex, 5),
            ],
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

DropdownMenuItem<String> getMenuItem(BuildContext context, String value, int questionIndex, int index) {
  return DropdownMenuItem<String>(
    value: value,
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        QuestionsShuffle.choices[QuestionsShuffle.questions[questionIndex]][index],
        textDirection: TextDirection.ltr,
        style: CustomStyle.getSubtitle(context),
      ),
    ),
  );
}
