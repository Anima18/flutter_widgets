import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widgets/element/game/shooting/enemy_plane.dart';

import 'bullet.dart';
import 'fighter.dart';

class ShootPlayPage extends StatefulWidget {
  final Size size;
  const ShootPlayPage({Key? key, required this.size}) : super(key: key);

  @override
  _ShootPlayPageState createState() => _ShootPlayPageState();
}

class _ShootPlayPageState extends State<ShootPlayPage> {
  late StreamController<DragUpdateDetails> _streamController;
  late StreamController<Bullet> _bulletController;
  late StreamController _hitController;
  late Timer hitTimer;

  List<Bullet> bullets = [];
  List<EnemyPlane> enemyPlanes = [];

  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _streamController = StreamController.broadcast();
    _bulletController = StreamController();
    _hitController = StreamController();

    _bulletController.stream.listen((bullet) {
      setState(() {
        print("=========create=============");
        bullets.add(bullet);
      });
    });
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      enemyPlanes.forEach((enemyPlane) {
        RenderBox enemyRenderBox =
        enemyPlane.planeState.context.findRenderObject() as RenderBox;
        var enemyOffset = enemyRenderBox.localToGlobal(Offset.zero);
        bullets.forEach((bullet) {
          if(bullet.status == BulletStatus.shooting) {
            RenderBox bulletRenderBox =
            bullet.bulletState.context.findRenderObject() as RenderBox;
            var bulletOffset = bulletRenderBox.localToGlobal(Offset.zero);
            if ((enemyOffset.dy <= bulletOffset.dy &&
                bulletOffset.dy <= enemyOffset.dy + enemyPlaneWidth) &&
                (enemyOffset.dx <= bulletOffset.dx &&
                    bulletOffset.dx <= enemyOffset.dx + enemyPlaneWidth)) {
              bullet.shooting();
              enemyPlane.beHit();
            }
          }
        });
      });
      hitTimer = timer;
    });
    enemyPlanes.add(EnemyPlane(widget.size));
    enemyPlanes.add(EnemyPlane(widget.size));
    enemyPlanes.add(EnemyPlane(widget.size));

    WidgetsBinding.instance?.addPostFrameCallback((_) async{
      player = await AudioCache().loop("backgroudMusic.wav");
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
    _bulletController.close();
    _hitController.close();
    hitTimer.cancel();
    player.stop();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
          onPanUpdate: _onPanUpdate,
          child: Container(
            /*decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF96E3FF),
                  Color(0xFF9EECFF),
                  Color(0xFF9FEBFF),
                  Color(0xFF9FEEFF),
                  Color(0xFF9FECFF),
                ],
              ),
              image: DecorationImage(
                image: AssetImage('images/battleground.jpg'),
                alignment: Alignment.bottomCenter,
              ),
            ),*/
            color: Colors.white,
            child: Stack(
              children: [
                Fighter(
                  size: widget.size,
                  dragUpdateStream: _streamController.stream,
                  bullets: bullets,
                  bulletsController: _bulletController,
                  hitController: _hitController,
                ),
                ...bullets,
                ...enemyPlanes,
                /* EnemyPlane(widget.size),
                EnemyPlane(widget.size),
                EnemyPlane(widget.size),*/
              ],
            ),
          )),
    );
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _streamController.add(details);
  }
}

