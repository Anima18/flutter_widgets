import 'dart:math';

import 'package:flutter/material.dart';

class AnimationFooPage extends StatefulWidget {
  @override
  _AnimationIconState createState() => _AnimationIconState();
}

class _AnimationIconState extends State<AnimationFooPage>  {
  bool _bigger = false;

  @override Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        AnimatedContainer(
          width: _bigger ? 100 : 300,
          height: _bigger ? 100 : 300,
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  colors: [Colors.red, Colors.transparent],
                  stops: [ _bigger ? 0.2 : 0.5, 1.0])
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset("images/star.png"),
          ),
          duration: Duration(seconds: 1),
          curve: Curves.easeInOutQuart,
          // curve: SineCurve(),
        ),
        ElevatedButton(
          onPressed: () =>
              setState(() {
                _bigger = !_bigger;
              }),
          child: Icon(Icons.star),
        ),
      ],
    );
  }


}
class SineCurve extends Curve {
  final double count;

  SineCurve({this.count = 1});

  @override
  double transformInternal(double t) {
    return sin(count * 2 * pi * t) * 0.5 + 0.5;
  }
}
