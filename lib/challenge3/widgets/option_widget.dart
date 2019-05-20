import 'package:flutter/material.dart';
import 'package:payment/challenge3/utils/default_gradient.dart';
import 'package:payment/challenge3/widgets/bouncing_widget.dart';

class OptionWidget extends StatefulWidget {
  final Color background, color;
  final Function onClicked;
  final double progress;
  final bool showProgress;
  final String label;
  const OptionWidget(
      {Key key,
      @required this.label,
      this.color = Colors.black,
      this.background = Colors.white,
      this.onClicked,
      this.progress = 1.0,
      this.showProgress = false})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {
  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      child: _buildOption(),
      duration: Duration(seconds: 2),
    );
  }

  bool clicked = false;
  Widget _buildOption() {
    return LayoutBuilder(
      builder: (context, contraints) {
        double width = contraints.maxWidth;
        return GestureDetector(
          onTap: () {
            if (widget.onClicked != null)
              setState(() {
                clicked = true;
                widget.onClicked();
              });
          },
          child: AnimatedContainer(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
            height: 72.0,
            alignment: Alignment.centerLeft,
            width: width * (widget.showProgress ? widget.progress : 1.0),
            padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
            decoration: BoxDecoration(
              color: clicked ? null : widget.background,
              border: widget.background != Colors.white
                  ? null
                  : Border.all(
                      color: Colors.black45,
                      width: 1.2,
                    ),
              borderRadius: BorderRadius.circular(72.0),
              gradient: clicked ? DefaultGradient.defaultGradient : null,
            ),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Container(
                width: width-45.0,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildText(widget.label),
                    !widget.showProgress
                        ? _buildText("${widget.progress * 100}%")
                        : Container(
                            width: 0.0,
                            height: 0.0,
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildText(String text) {
    return Text(text,
        style: TextStyle(
            color: clicked ? Colors.white : widget.color,
            fontSize: 20.0,
            fontWeight: FontWeight.w600),overflow: TextOverflow.clip,);
  }
}
