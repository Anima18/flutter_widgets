import 'package:flutter/material.dart';

import 'animated_logo.dart';

class AnimationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnimationWidget"),
      ),
      body: AnimationIcon(),
    );
  }
}

class AnimationIcon extends StatefulWidget {
  @override
  _AnimationIconState createState() => _AnimationIconState();
}

class _AnimationIconState extends State<AnimationIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 5000));
    final CurvedAnimation cure = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _animation = Tween(begin: 50.0, end: 200.0).animate(cure);
    // 启动动画
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedLogo(animation:_animation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}

