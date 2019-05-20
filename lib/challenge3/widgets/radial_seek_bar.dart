import 'dart:math';

import 'package:flutter/material.dart';

class RadialSeekBar extends StatefulWidget {
  final double trackWidth;
  final Color trackColor;
  final double progressWidth;
  final Color progressColor;
  final double progressPercent;
  final Widget child;

  const RadialSeekBar(
      {Key key,
      this.trackWidth = 10.0,
      this.trackColor = Colors.grey,
      this.progressWidth = 10.0,
      this.progressColor = Colors.black,
      this.progressPercent = 0.2,
      @required this.child})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _RadialSeekBarState();
}

class _RadialSeekBarState extends State<RadialSeekBar> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RadialSeekBarPainter(
        progressColor: widget.progressColor,
        progressPercent: widget.progressPercent,
        progressWidth: widget.progressWidth,
        trackColor: widget.trackColor,
        trackWidth: widget.trackWidth,
      ),
      child:Padding(
        padding: EdgeInsets.all(max(widget.trackWidth,widget.progressWidth)),
        child: widget.child,
      ),
    );
  }
}

class RadialSeekBarPainter extends CustomPainter {
  final Paint trackPaint;
  final double trackWidth;
  final Color trackColor;
  final double progressWidth;
  final Color progressColor;
  final double progressPercent;
  final Paint progressPaint;

  RadialSeekBarPainter(
      {@required this.trackWidth,
      @required this.trackColor,
      @required this.progressWidth,
      @required this.progressColor,
      @required this.progressPercent})
      : trackPaint = Paint()
          ..color = trackColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = trackWidth,
        progressPaint = Paint()
          ..color = progressColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = progressWidth
          ..strokeCap = StrokeCap.round;
  @override
  void paint(Canvas canvas, Size size) {
    final outerThickness=max(trackWidth, progressWidth);
     Size constrainedSize=Size(
      size.width-outerThickness,
      size.height-outerThickness
    );
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(constrainedSize.width / 2, constrainedSize.height / 2);
   

    canvas.drawCircle(
      center, 
      radius, 
      trackPaint);
    //Progress
    double sweepAngle=-2*pi*progressPercent;
    canvas.drawArc(new Rect.fromCircle(
      center: center,radius: radius
    ), -pi/2, -sweepAngle, false, progressPaint);  
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
