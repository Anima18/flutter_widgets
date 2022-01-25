import 'dart:math';

import 'package:flutter/material.dart';

class ExplicitAnimationPage extends StatefulWidget {
  @override
  _AnimationIconState createState() => _AnimationIconState();
}

class _AnimationIconState extends State<ExplicitAnimationPage>  with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 5000));
    _controller.repeat();
  }

  @override Widget build(BuildContext context) {
    return RotationTransition(turns: _controller, child:  Image.asset('images/star.png'),);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }
}
