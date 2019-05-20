import 'dart:async';

import 'package:flutter/material.dart';
import 'package:payment/challenge3/models/question.dart';
import 'package:payment/challenge3/utils/default_gradient.dart';
import 'package:payment/challenge3/widgets/alert_widget.dart';
import 'package:payment/challenge3/widgets/bouncing_widget.dart';
import 'package:payment/challenge3/widgets/question_widget.dart';
import 'package:payment/challenge3/widgets/quiz_timer.dart';
import 'package:payment/challenge3/utils/networking.dart' as network;

class QuizScreen extends StatefulWidget {
  final Question question;
  final Function onCompleted;
  const QuizScreen(
      {Key key, @required this.question, @required this.onCompleted})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool answerable = true;
  bool answered = false;
  bool correct = false;
  bool showAnswer = false;
  String answer = '';
  Question question;
  @override
  void initState() {
    super.initState();
    question = widget.question;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Center(
          child: BouncingWidget(
            duration: Duration(seconds: 1),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                buildTimer(),
                QuestionWidget(
                  answer: showAnswer ? answer : null,
                  onClicked: (answer) {
                    this.answer = answer;
                    if (this.answer == question.correctAnswer) {
                      correct = true;
                    }
                  },
                  answerable: answerable,
                  question: question,
                )
              ]),
            ),
          ),
        ));
  }

  Widget buildTimer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox.fromSize(
                size: Size(110.0, 25.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        size: 22.0,
                        color: Colors.black38,
                      ),
                      Text("1.5M",
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w800)),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.favorite_border,
                          size: 22.0,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox.fromSize(
                  size: Size(110.0, 25.0),
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text("HQ",
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900)),
                  )),
            ],
          ),
          !showAnswer
              ? QuizTimer(
                  onCompleted: () {
                    setState(() {
                      answerable = false;
                    });
                    if (correct == null) correct = false;
                    convertToAnswered();
                  },
                  duration: Duration(seconds: 6),
                )
              : (correct
                  ? AlertWidget(
                      iconData: Icons.check,
                      boxDecoration: BoxDecoration(color: Colors.green),
                      label: "Correct",
                    )
                  : AlertWidget(
                      iconData: Icons.clear,
                      boxDecoration: BoxDecoration(color: Colors.red),
                      label: "Wrong",
                    )),
        ],
      ),
    );
  }

  void convertToAnswered() {
    Future.delayed(Duration(seconds: 1,milliseconds: 500)).then((val) {
      showAnswer = true;
      if(mounted)
      setState(() {});
      Future.delayed(Duration(seconds: 2)).then((val) {
        widget.onCompleted();
      });
    });
  }
}
