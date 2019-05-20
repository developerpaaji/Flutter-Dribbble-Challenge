import 'package:flutter/material.dart';
import 'package:payment/challenge3/models/answer.dart';
import 'package:payment/challenge3/models/question.dart';
import 'package:payment/challenge3/widgets/answer_widget.dart';
import 'package:payment/challenge3/widgets/option_widget.dart';

class QuestionWidget extends StatefulWidget {
  final Question question;
  final bool answerable;
  final Function onClicked;
  final String answer;
  const QuestionWidget(
      {Key key,
      this.question,
      this.answerable,
      @required this.onClicked,
      this.answer})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  bool clicked = false;
  List<Widget> options = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Question question = widget.question;
    List<Widget> widgets = [];

    widgets.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Text(
          question.title,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ),
    );
    if (widget.answer == null) {
      widget.question.options.forEach((option) {
        widgets.add(OptionWidget(
          label: option,
          showProgress: true,
          onClicked: !clicked && widget.answerable
              ? () {
                  widget.onClicked(option);
                  setState(() {
                    clicked = true;
                  });
                }
              : null,
        ));
      });
    } else {
      int count = 0;
      widget.question.options.forEach((option) {
        widgets.add(AnswerWidget(
          progress: getRatios()[count++],
          option: option,
          type: getAnswerType(option),
        ));
      });
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
    );
  }

  AnswerType getAnswerType(String option) {
    print(option);
    Question question = widget.question;
    if (question.correctAnswer == option) {
      print("Right");
      return AnswerType.Right;
    } else if (question.correctAnswer != widget.answer &&
        option == widget.answer) {
      print("Wrong");

      return AnswerType.Wrong;
    }
    return AnswerType.NotSelected;
  }

  List getRatios() {
    return [0.24, 0.45, 0.31];
  }
}
