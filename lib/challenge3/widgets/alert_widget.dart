import 'package:flutter/material.dart';
import 'package:payment/challenge3/widgets/bouncing_widget.dart';

class AlertWidget extends StatefulWidget {
  final BoxDecoration boxDecoration;
  final String label;
  final IconData iconData;
  const AlertWidget(
      {Key key, @required this.label, @required this.boxDecoration,@required this.iconData})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {
  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      duration: Duration(seconds: 2),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 32.0,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            gradient: widget.boxDecoration.gradient,
            color: widget.boxDecoration.color),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: Icon(widget.iconData,color: Colors.white,),
            ),
            Text(
              widget.label,
              style: TextStyle(
                  fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
