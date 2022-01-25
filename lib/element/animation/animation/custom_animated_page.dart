import 'package:flutter/material.dart';

class AnimationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("自定义隐式动画"),
      ),
      //body: AnimationIcon(),
      body:  Center(
        child: TweenAnimationBuilder(
          tween: Tween(begin: 50.0, end: 200.0),
          duration: Duration(seconds: 2),
          builder: (BuildContext context, double value, Widget? child) {
            return Container(
              width: value,
              height: value,
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                      colors: [Colors.red, Colors.transparent],
                      stops: [ value/200, 1.0])
              ),
              child: Image.asset("images/star.png"),
            );
          }
        ),
      ),
    );
  }
}

