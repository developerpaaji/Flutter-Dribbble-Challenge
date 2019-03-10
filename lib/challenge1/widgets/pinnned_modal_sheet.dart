import 'package:flutter/material.dart';

class PinnedModalSheet extends StatefulWidget{
  final Widget header;
  final BottomSheet bottomSheet;
  final Function onExpanded;
  final bool initialExpanded;
  PinnedModalSheet({@required this.header,@required this.bottomSheet, this.onExpanded, this.initialExpanded=false}):assert(header!=null),assert(bottomSheet!=null);

  @override
  State<StatefulWidget> createState() =>_PinnedModalSheetState();
  
}
class _PinnedModalSheetState extends State<PinnedModalSheet> with SingleTickerProviderStateMixin<PinnedModalSheet>
{
  AnimationController _controller;
  double _kMinFlingVelocity = 700.0;
  double _kCloseProgressThreshold = 0.5;
  bool expanded=false;
  @override
  void initState() {
    super.initState();
     _controller=widget.bottomSheet.animationController??BottomSheet.createAnimationController(this);
     _controller.addListener((){
       if(_controller.value>_kCloseProgressThreshold&&!expanded)
         {
           expanded=true;
           widget.onExpanded();
         }
       if(_controller.value<=_kCloseProgressThreshold&&expanded)
         {
           expanded=false;
           widget.bottomSheet.onClosing();
         }
     });
     if(widget.initialExpanded)
    _controller.forward();
     
  }

  final GlobalKey _childKey = GlobalKey(debugLabel: 'BottomSheet child');
  
  double get _childHeight {
    final RenderBox renderBox = _childKey.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  bool get _dismissUnderway => _controller.status == AnimationStatus.reverse;
  void _handleDragEnd(DragEndDetails details) {

//    if (_dismissUnderway)
//      return;
    if (details.velocity.pixelsPerSecond.dy > _kMinFlingVelocity) {
      final double flingVelocity = -details.velocity.pixelsPerSecond.dy / _childHeight;
      if (_controller.value > 0.0)
        _controller.fling(velocity: flingVelocity);
      if (flingVelocity < 0.0)
        close();
    } else if (_controller.value < _kCloseProgressThreshold) {
      if (_controller.value > 0.0)
        _controller.fling(velocity: -1.0);
      close();
    } else {
      _controller.forward();
    }
  }
  void _handleDragUpdate(DragUpdateDetails details) {
//    if (_dismissUnderway)
//      return;
    _controller.value -= details.primaryDelta / (_childHeight ?? details.primaryDelta);
  }
  void close()
  {
    _controller.reverse();
    expanded=false;
    widget.bottomSheet.onClosing();
  }
  @override
  Widget build(BuildContext context) {
    Widget pinned=GestureDetector(
        onTap:()=> _controller.forward(),
        onVerticalDragEnd: _handleDragEnd,
        onVerticalDragUpdate: _handleDragUpdate,
        child: widget.header
    );
    Widget body=Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        pinned,
        AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget child) {
              return Align(
                  alignment: AlignmentDirectional.topStart,
                  heightFactor: _controller.value,
                  child: child
              );
            },
            child: Semantics(
               key: _childKey,
                container: true,
                onDismiss: () {
                  widget.bottomSheet.onClosing();
                },
                child: widget.bottomSheet
            )
        )
      ],
    );
    return  body;
  }
  @override
  void dispose() {
    if(widget.bottomSheet.animationController==null)
    _controller.dispose();
    super.dispose();
  }

}