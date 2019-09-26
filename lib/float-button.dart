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

  @override
  void initState() {
    super.initState();

    _menuButtonController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _rotateAnimation =
        Tween<double>(begin: 0.0, end: 0.5 * pi).animate(_menuButtonController);

    _moveController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _moveAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_moveController);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      children: <Widget>[
        AnimatedBuilder(
          animation: _moveAnimation,
          child: FloatingActionButton(
            backgroundColor: Colors.black45,
            onPressed: () => {},
            child: Icon(Icons.lock),
          ),
          builder: (BuildContext context, Widget child) {
            return Transform(
                alignment: FractionalOffset.center,
                transform:
                    Matrix4.translationValues(-80 * _moveAnimation.value, 0, 0)
                      ..scale(_moveAnimation.value),
                child: child);
          },
        ),
        AnimatedBuilder(
          animation: _moveAnimation,
          child: FloatingActionButton(
            backgroundColor: Colors.black45,
            onPressed: () => {},
            child: Icon(Icons.arrow_back_ios),
          ),
          builder: (BuildContext context, Widget child) {
            return Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.translationValues(
                    -40 * _moveAnimation.value, 60 * _moveAnimation.value, 0)
                  ..scale(_moveAnimation.value),
                child: child);
          },
        ),
        AnimatedBuilder(
          animation: _moveAnimation,
          child: FloatingActionButton(
            backgroundColor: Colors.black45,
            onPressed: () => {},
            child: Icon(Icons.delete),
          ),
          builder: (BuildContext context, Widget child) {
            return Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.translationValues(
                    -40 * _moveAnimation.value, -60 * _moveAnimation.value, 0)
                  ..scale(_moveAnimation.value),
                child: child);
          },
        ),
        AnimatedBuilder(
            animation: _rotateAnimation,
            child: FloatingActionButton(
                backgroundColor: Colors.black45,
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
