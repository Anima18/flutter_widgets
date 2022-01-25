import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:flutter_widgets/learning/draw/coordinate.dart';

class CanvasPage04 extends StatefulWidget {
  @override
  _CanvasPage04State createState() => _CanvasPage04State();
}

class _CanvasPage04State extends State<CanvasPage04> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: PaintPainter(),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}

class PaintPainter extends CustomPainter {

  Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    Coordinate().paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    _paint..color = Colors.blue;

    //center	矩形中心坐标点
    // width	矩形宽度
    // height	矩形高度
    Rect rect1 = Rect.fromCenter(center: Offset(0,0), width: 160, height: 160);
    canvas.drawRect(rect1, _paint);

    //left	左边相对于原点的偏移量
    // top	顶部相对于原点的偏移量
    // right	右边相对于原点的偏移量
    // bottom	底部相对于原点的偏移量
    Rect rect2 = Rect.fromLTRB(-120, -120, -80, -80);
    canvas.drawRect(rect2, _paint..color = Colors.red);

    //left	左边相对于原点的偏移量
    // top	顶部相对于原点的偏移量
    // width	矩形的宽度
    // height	矩形高度
    Rect rectFromLTWH = Rect.fromLTWH(80, -120, 40, 40);
    canvas.drawRect(rectFromLTWH, _paint..color=Colors.orange);

    //center	矩形中心坐标点
    // radius 半径
    Rect rectFromCircle = Rect.fromCircle(center: Offset(100, 100),radius: 20);
    canvas.drawRect(rectFromCircle, _paint..color=Colors.green);

    Rect rectFromPoints= Rect.fromPoints(Offset(-120 , 80),Offset(-80 , 120));
    canvas.drawRect(rectFromPoints, _paint..color=Colors.purple);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
