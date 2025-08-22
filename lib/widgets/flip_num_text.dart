import 'dart:math';

import 'package:flutter/material.dart';

class FlipNumText extends StatefulWidget {
  final int num;
  final int maxNum;

  const FlipNumText(this.num, this.maxNum, {super.key});

  @override
  State<FlipNumText> createState() => _FlipNumTextState();
}

class _FlipNumTextState extends State<FlipNumText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  bool _isReversePhase = false;

  final double _zeroAngle = 0.0001;

  int _stateNum = 0;

  @override
  void initState() {
    super.initState();
    _stateNum = widget.num;

    ///动画控制器，正向执行一次后再反向执行一次每次时间为450ms。
    _controller = AnimationController(duration: Duration(milliseconds: 450), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          ///正向动画执行结束后，反向动画执行标志位设置true 进行反向动画执行
          _controller.reverse();
          _isReversePhase = true;
//          print("AnimationStatus.completed");
        }
        if (status == AnimationStatus.dismissed) {
          ///反向动画执行结束后，反向动画执行标志位false 将当前数值加一更改为动画后的值
          _isReversePhase = false;
          _calNum();
//          print("AnimationStatus.dismissed");
        }
      })
      ..addListener(() {
        setState(() {});
      });

    ///四分之一的圆弧长度
    _animation = Tween(begin: _zeroAngle, end: pi / 2).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    Color color = Colors.white;
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: <Widget>[
              ClipRectText(_nextNum(), Alignment.topCenter, color),

              ///动画正向执行翻转的组件
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.006)
                  ..rotateX(_isReversePhase ? pi / 2 : _animation.value),
                alignment: Alignment.bottomCenter,
                child: ClipRectText(_stateNum, Alignment.topCenter, color),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.0),
          ),
          Stack(
            children: [
              ClipRectText(_stateNum, Alignment.bottomCenter, color),

              ///动画反向执行翻转的组件
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.006)
                  ..rotateX(_isReversePhase ? -_animation.value : pi / 2),
                alignment: Alignment.topCenter,
                child: ClipRectText(_nextNum(), Alignment.bottomCenter, color),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(FlipNumText oldWidget) {
    if (widget.num != oldWidget.num) {
      _controller.forward();
      _stateNum = oldWidget.num;
    }
    super.didUpdateWidget(oldWidget);
  }

  _nextNum() {
    if (_stateNum == widget.maxNum) {
      return 0;
    } else {
      return _stateNum + 1;
    }
  }

  _calNum() {
    if (_stateNum == widget.maxNum) {
      _stateNum = 0;
    } else {
      _stateNum += 1;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class ClipRectText extends StatelessWidget {
  final int _value;
  final Alignment _alignment;
  final Color _color;

  const ClipRectText(this._value, this._alignment, this._color, {super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width / 5 + 10;
    return ClipRect(
      child: Align(
        alignment: _alignment,
        heightFactor: 0.5,
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          alignment: Alignment.center,
          width: width,
          decoration: BoxDecoration(
            color: Color.fromRGBO(41, 41, 41, 1.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Text(
            "$_value",
            style: TextStyle(
              fontFamily: "Din",
              fontSize: width - 30,
              color: _color,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.none,
            ),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
