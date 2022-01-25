import 'package:flutter/material.dart';

class AnimationPage2 extends StatefulWidget {
  @override
  _AnimationPage2State createState() => _AnimationPage2State();
}

class _AnimationPage2State extends State<AnimationPage2> {
  double _newValue = .4;
  Color _newColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Center(
              child: TweenAnimationBuilder(
                  tween: ColorTween(begin: Colors.white, end: _newColor),
                  duration: Duration(seconds: 1),
                  child: Image.asset('images/star.png'),
                  builder: (BuildContext context, Color? color, Widget? child) {
                    return ColorFiltered(
                      child: child,
                      colorFilter: ColorFilter.mode(color!, BlendMode.modulate),
                    );
                  }
              ),
            ),
            Slider.adaptive(
              value: _newValue,
              onChanged: (double value) {
                setState(() {
                  _newValue = value;
                  _newColor = Color.lerp(Colors.white, Colors.red, value)!;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}


