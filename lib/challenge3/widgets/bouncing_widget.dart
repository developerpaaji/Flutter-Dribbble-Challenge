import 'package:flutter/material.dart';

class BouncingWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  const BouncingWidget({Key key,@required this.child,@required this.duration}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _BouncingWidgetState();
}

class _BouncingWidgetState extends State<BouncingWidget>
    with TickerProviderStateMixin<BouncingWidget> {
  AnimationController controller;
  Animation<double> scaleAnimation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    scaleAnimation = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(
            parent: controller,
            curve: Curves.ease,
            reverseCurve: Curves.bounceInOut));
    controller.animateTo(1.0,
        duration: widget.duration,
        curve: Curves.elasticOut);
    print("Boucing Int");
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          child: widget.child,
          scale: controller.value,
        );
      },
      child: Container(
        width: 0.0,
        height: 0.0,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
