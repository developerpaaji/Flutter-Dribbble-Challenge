import 'package:flutter/material.dart';
import 'package:payment/challenge3/screens/quiz_screen.dart';
import 'package:payment/challenge3/widgets/number_timer.dart';
import 'package:payment/challenge3/utils/default_gradient.dart';
import 'package:payment/challenge3/utils/networking.dart' as network;

class ChallengeThreeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_ChallengeThreeScreenState();

}

class _ChallengeThreeScreenState extends State<ChallengeThreeScreen>{
  bool loading = false;
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
                });
              })
            : QuizScreen(
                question: network.getQuestion(),
                onCompleted: () {
                  setState(() {
                    this.loading = true;
                  });
                },
              ),
      ),
    );
    // return Scaffold();
  }
  
}