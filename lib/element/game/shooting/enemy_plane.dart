import 'dart:math';

import 'package:flutter/material.dart';

const double enemyPlaneWidth = 40.0;
class EnemyPlane extends StatefulWidget {
  final Size size;
  final _EnemyPlaneState planeState = _EnemyPlaneState();

  EnemyPlane(this.size);

  void beHit() {
    planeState.reset();
  }

  @override
  _EnemyPlaneState createState() => planeState;
}

class _EnemyPlaneState extends State<EnemyPlane> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late double left;

  void reset() {
    left = Random().nextDouble() * (widget.size.width - enemyPlaneWidth);
    controller.forward(from: 0.0);
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(seconds: 10));
    reset();

    controller.addListener(() {
      if (controller.status == AnimationStatus.completed) {
        reset();
      }
    });
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Positioned(
          top: widget.size.height*controller.value + enemyPlaneWidth,
          left: left,
          child: Container(
            width: enemyPlaneWidth,
            height: enemyPlaneWidth,
            child: Image(
              image: AssetImage("images/enemy_plane.png"),
            ),
          ),
        );
      },
    );
  }
}
