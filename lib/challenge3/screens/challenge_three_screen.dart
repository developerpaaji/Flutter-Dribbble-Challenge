import 'package:flutter/material.dart';
import 'package:payment/challenge3/models/question.dart';
import 'package:payment/challenge3/screens/quiz_screen.dart';
import 'package:payment/challenge3/widgets/bouncing_widget.dart';
import 'package:payment/challenge3/widgets/number_timer.dart';
import 'package:payment/challenge3/utils/default_gradient.dart';
import 'package:payment/challenge3/utils/networking.dart' as network;

class ChallengeThreeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChallengeThreeScreenState();
}

class _ChallengeThreeScreenState extends State<ChallengeThreeScreen> {
  bool loading = true;
  int current = 0;
  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(gradient: DefaultGradient.defaultGradient),
        child: loading
            ? NumberTimer(onCompleted: () {
                setState(() {
                  this.loading = false;
                  current++;
                });
              })
            : current < questions.length
                ? QuizScreen(
                    question: questions[current],
                    onCompleted: () {
                      setState(() {
                        this.loading = true;
                      });
                    },
                  )
                : BouncingWidget(
                  duration: Duration(seconds: 2),
                  child:Text("End",style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.15,
                    color: Colors.white,
                    fontWeight: FontWeight.w900),)
                ),
      ),
    );
    // return Scaffold();
  }

  List<Question> questions = [];
  void refresh() {
    network.getQuestions().then((ques) {
      print(ques.length);
      if (mounted) {
        setState(() {
          questions.clear();
          questions.addAll(ques);
        });
      }
    });
  }
}
