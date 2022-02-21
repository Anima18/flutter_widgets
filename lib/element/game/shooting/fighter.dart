import 'dart:async';

import 'package:flutter/material.dart';

import 'bullet.dart';

class Fighter extends StatefulWidget {
  final Size size;
  final Stream<DragUpdateDetails> dragUpdateStream;
  final List<Bullet> bullets;
  final StreamController<Bullet> bulletsController;
  final StreamController hitController;

  Fighter(
      {Key? key,
      required this.size,
      required this.dragUpdateStream,
      required this.bullets,
      required this.bulletsController,
      required this.hitController})
      : super(key: key);

  @override
  FighterState createState() => FighterState();
}

class FighterState extends State<Fighter> {
  late double top;
  late double left;
  late double width = 50.0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    top = widget.size.height - width;
    left = (widget.size.width - width) / 2;

    //移动战斗机
    widget.dragUpdateStream.listen((details) {
      setState(() {
        top += details.delta.dy;
        left += details.delta.dx;
        if (top < 0.0) {
          top = 0.0;
        }
        if (top > widget.size.height - width) {
          top = widget.size.height - width;
        }

        if (left < 0.0) {
          left = 0.0;
        }
        if (left > widget.size.width - width) {
          left = widget.size.width - width;
        }
      });
    });

    //发射子弹
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      List<Bullet> loadedBullets = widget.bullets
          .where((element) => element.status == BulletStatus.loaded)
          .toList();
      if (loadedBullets.length != 0) {
        loadedBullets[0].shooting();
      } else {
        widget.bulletsController.add(Bullet(fighterState: this));
      }

      widget.hitController.add(true);
      this.timer = timer;
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  String parserOffset(Offset offset) {
    return '(${offset.dx.toStringAsFixed(2)},${offset.dy.toStringAsFixed(2)})';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 10),
      top: top,
      left: left,
      child: Container(
        width: 50,
        height: 50,
        color: Colors.red,
      ),
    );
  }
}
