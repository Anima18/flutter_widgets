import 'dart:async';

import 'package:flutter/material.dart';

class PanDemo extends StatefulWidget {
  const PanDemo({Key? key}) : super(key: key);

  @override
  _PanDemoState createState() => _PanDemoState();
}

class _PanDemoState extends State<PanDemo> {
  late StreamController<DragUpdateDetails> _streamController;
  late StreamController<Bullet> _bulletController;

  List<Bullet> bulltts = [];

  @override
  void initState() {
    super.initState();
    _streamController = StreamController.broadcast();
    _bulletController = StreamController();

    _bulletController.stream.listen((bullet) {
      setState(() {
        bulltts.add(bullet);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
    _bulletController.close();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onPanUpdate: _onPanUpdate,
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Fighter(
                size: size,
                dragUpdateStream: _streamController.stream,
                bulltts: bulltts,
                bullttsController: _bulletController,
              ),
              ...bulltts
            ],
          ),
        ));
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _streamController.add(details);
  }
}

class Fighter extends StatefulWidget {
  final Size size;
  final Stream<DragUpdateDetails> dragUpdateStream;
  final List<Bullet> bulltts;
  final StreamController<Bullet> bullttsController;

  Fighter({Key? key, required this.size, required this.dragUpdateStream, required this.bulltts, required this.bullttsController})
      : super(key: key);

  @override
  _FighterState createState() => _FighterState();
}

class _FighterState extends State<Fighter> {
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
      List<Bullet> loadedBullets = widget.bulltts.where((element) => element.status==BulletStatus.loaded).toList();
      if(loadedBullets.length != 0) {
        loadedBullets[0].shooting();
        print("=======reset=========");
      }else {
        widget.bullttsController.add(Bullet(fighterState: this));
        print("=======create=========");
      }

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

enum BulletStatus {
  loaded, //上膛
  shooting, //射击中
  hit, //命中目标
  lose, //丢失
}

class Bullet extends StatefulWidget {
  BulletStatus status = BulletStatus.loaded;
  final _FighterState fighterState;

  final _BulletState bulletState = _BulletState();

  Bullet({Key? key, required this.fighterState})
      : super(key: key);

  void shooting() {
    bulletState.shooting();
  }

  @override
  _BulletState createState() => bulletState;
}

class _BulletState extends State<Bullet> with SingleTickerProviderStateMixin {
  late double top;
  late double left;
  late AnimationController controller;
  late double width = 10.0;

  void shooting() {
    widget.status = BulletStatus.shooting;
    top = widget.fighterState.top;
    left = widget.fighterState.left + widget.fighterState.width / 2 - width/2;

    controller.forward();
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    shooting();
    controller.addListener(() {
      if (controller.status == AnimationStatus.completed) {
        print("=======completed=========");
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
            color: Colors.black,
          ),
        );
      },
    );
  }
}
