import 'dart:async';

import 'package:flutter/material.dart';

class StatusWidget extends StatefulWidget{

  final int totalCount;
  final PageController pageController;
  final Duration duration;
  final double height;
  final double horizontalMargin;
  final Color primary,secondary;
  final double radius;
  const StatusWidget({Key key, this.totalCount=0,@required this.pageController,@required this.duration, this.height=6.0, this.horizontalMargin=2.0,@required this.primary,@required this.secondary, this.radius=4.0, }): super(key: key);
  @override
  State<StatefulWidget> createState() =>_StatusWidgetState();
  
}
class _StatusWidgetState extends State<StatusWidget>
{
  double currentWidth=0.0;
  double width=0.0;
  int current=-1;
  Timer _timer;

  @override
  void initState() {
    _timer=Timer(widget.duration, increement);
    super.initState();
    current=widget.pageController.initialPage-1;
    }
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width/widget.totalCount;
   return Row(
     children: List<Widget>.generate(widget.totalCount, (index)=>buildItem(index)),
   );
  }
  void increement()
  {
    if(mounted)
    setState(() {
      currentWidth=MediaQuery.of(context).size.width/widget.totalCount;
      if(widget.pageController.hasClients&&current<widget.totalCount)
        {
          ++current;
          widget.pageController.jumpToPage(current);
        }
      if(current<widget.totalCount-1)
      _timer=Timer(widget.duration, increement);
    });
  }
  Widget buildItem(int index)
  {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.horizontalMargin),
        child: Stack(
          children: <Widget>[
            Container(width: width,height: widget.height,decoration: BoxDecoration(color: index>=current?widget.secondary:widget.primary,borderRadius: BorderRadius.circular(widget.radius)),),
            AnimatedContainer(duration:widget.duration,width: index==current?width:0.0,height:widget.height,decoration: BoxDecoration(color: widget.primary,borderRadius: BorderRadius.circular(widget.radius)),)
          ],
        ),
      ),
    );
  }
}