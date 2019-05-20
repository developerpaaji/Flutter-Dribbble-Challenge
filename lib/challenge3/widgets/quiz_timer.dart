import 'dart:math';

import 'package:flutter/material.dart';
import 'package:payment/challenge3/utils/default_gradient.dart';
import 'package:payment/challenge3/widgets/alert_widget.dart';
import 'package:payment/challenge3/widgets/radial_seek_bar.dart';

class QuizTimer extends StatefulWidget {
  final Duration duration;
  final Function onCompleted;
  const QuizTimer({Key key, @required this.duration,@required this.onCompleted}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _QuizTimerState();
}

class _QuizTimerState extends State<QuizTimer>
    with TickerProviderStateMixin<QuizTimer> {
  AnimationController controller;
  Color progressColor = Color(0xff5eca84);
  int maxDuration = 5;
  static const double MIN_SIZE = 54.0;
  double size = MIN_SIZE;
  Animation<double> scaleAnimation;
  bool completed = false;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    controller.value = 1.0;
    controller.animateTo(0.0,
        duration: widget.duration, curve: Curves.easeInOut)
      ..then((f) {
        setState(() {
          widget.onCompleted();
          completed = true;
        });
      });
    controller.addListener(() {
      if (getValue() >= 4 && getValue() != 0) {
        // size = MIN_SIZE + (10.0 / getValue());
        progressColor = Colors.red;
      } else {
        progressColor = Color(0xff5eca84);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        !completed
            ? RadialSeekBar(
                progressWidth: 7.0,
                trackWidth: 5.0,
                progressPercent: controller.value,
                progressColor: progressColor,
                trackColor: Color(0xffeeeeee),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.bounceOut,
                  width: size,
                  height: size,
                ),
              )
            : AlertWidget(
              iconData: Icons.timer_off,
              boxDecoration: BoxDecoration(
                gradient: DefaultGradient.defaultGradient,
              ),
              label: "Time's up",
            ),
      ],
    );
  }

  int getValue() {
    return maxDuration - (controller.value * maxDuration).floor();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
