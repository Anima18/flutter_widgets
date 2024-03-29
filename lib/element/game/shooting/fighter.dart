import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
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
  late double width = 70.0;
  late Timer timer;
  late AudioPlayer player;

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
      this.timer = timer;
    });
    WidgetsBinding.instance?.addPostFrameCallback((_) async{
      player = await AudioCache().loop("fighter_shooting.wav");
    });

  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    player.stop();
    player.dispose();
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
        width: width,
        height: width,
        child: Image(
          image: AssetImage("images/fighter.png"),
        ),
      ),
    );
  }
}
