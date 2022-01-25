import 'package:flutter/material.dart';

class AnimatedLogo extends AnimatedWidget {
  //AnimatedWidget 需要在初始化时传入 animation 对象
  AnimatedLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    // 取出动画对象
    final Animation<double> animation = listenable as Animation<double>;
    return Center(
        child: Container(
          height: animation.value,// 根据动画对象的当前状态更新宽高
          width: animation.value,
          child: FlutterLogo(),
        ));
  }
}