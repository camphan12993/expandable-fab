import 'dart:math';

import 'package:flutter/material.dart';

class FloatButton extends StatefulWidget {
  @override
  _FloatButtonState createState() => _FloatButtonState();
}

class _FloatButtonState extends State<FloatButton>
    with TickerProviderStateMixin {
  AnimationController _menuButtonController;
  Animation<double> _rotateAnimation;

  AnimationController _moveController;
  Animation<double> _moveAnimation;
  Animation<Color> _animateColor;

  @override
  void initState() {
    super.initState();

    _menuButtonController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _rotateAnimation =
        Tween<double>(begin: 0.0, end: 0.5 * pi).animate(_menuButtonController);

    _moveController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });
    _moveAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_moveController);

    _animateColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _menuButtonController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.easeOut,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      children: <Widget>[
        AnimatedBuilder(
          animation: _moveAnimation,
          child: Transform.scale(
            scale: _moveAnimation.value,
            child: FloatingActionButton(
              backgroundColor: Colors.blueAccent,
              onPressed: () => {},
              child: Icon(Icons.school),
            ),
          ),
          builder: (BuildContext context, Widget child) {
            return Transform.translate(
                child: child, offset: Offset(-80 * _moveAnimation.value, 0));
          },
        ),
        AnimatedBuilder(
          animation: _moveAnimation,
          child: Transform.scale(
            scale: _moveAnimation.value,
            child: FloatingActionButton(
              backgroundColor: Colors.blueAccent,
              onPressed: () => {},
              child: Icon(Icons.school),
            ),
          ),
          builder: (BuildContext context, Widget child) {
            return Transform.translate(
                child: child,
                offset: Offset(
                    -40 * _moveAnimation.value, 60 * _moveAnimation.value));
          },
        ),
        AnimatedBuilder(
          animation: _moveAnimation,
          child: Transform.scale(
            scale: _moveAnimation.value,
            child: FloatingActionButton(
              backgroundColor: Colors.blueAccent,
              onPressed: () => {},
              child: Icon(Icons.school),
            ),
          ),
          builder: (BuildContext context, Widget child) {
            return Transform.translate(
                child: child,
                offset: Offset(
                    -40 * _moveAnimation.value, -60 * _moveAnimation.value));
          },
        ),
        AnimatedBuilder(
            animation: _rotateAnimation,
            child: FloatingActionButton(
                backgroundColor: _animateColor.value,
                onPressed: () => {
                      if (_menuButtonController.isDismissed)
                        {
                          _menuButtonController.forward(),
                          _moveController.forward()
                        }
                      else
                        {
                          _menuButtonController.reverse(),
                          _moveController.reverse()
                        }
                    },
                child: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: _menuButtonController,
                )),
            builder: (BuildContext context, Widget child) {
              return Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.rotationZ(_rotateAnimation.value),
                child: child,
              );
            }),
      ],
    ));
  }
}
