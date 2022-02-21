import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widgets/element/game/shooting/fighter.dart';

enum BulletStatus {
  loaded, //上膛
  shooting, //射击中
  hit, //命中目标
  lose, //丢失
}

class Bullet extends StatefulWidget {
  BulletStatus status = BulletStatus.loaded;
  final FighterState fighterState;

  final _BulletState bulletState = _BulletState();

  Bullet({Key? key, required this.fighterState})
      : super(key: key);

  void shooting() {
    bulletState.reset();
  }

  @override
  _BulletState createState() => bulletState;
}

class _BulletState extends State<Bullet> with SingleTickerProviderStateMixin {
  late double top;
  late double left;
  late AnimationController controller;
  late double width = 10.0;

  void reset() {
    widget.status = BulletStatus.shooting;
    top = widget.fighterState.top;
    left = widget.fighterState.left + widget.fighterState.width / 2 - width/2;

    controller.forward(from: 0.0);
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    reset();
    controller.addListener(() {
      if (controller.status == AnimationStatus.completed) {
        widget.status = BulletStatus.loaded;
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
          top: top - top*controller.value,
          left: left,
          child: Container(
            width: width,
            height: width,
            child: Image(
              image: AssetImage("images/bullet.png"),
            ),
          ),
        );
      },
    );
  }
}