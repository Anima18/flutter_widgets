import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widgets/learning/draw/coordinate.dart';

class PathPage02 extends StatefulWidget {
  @override
  _PathPage02State createState() => _PathPage02State();
}

class _PathPage02State extends State<PathPage02> {
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

//当想要画圆弧到某个点，用 arcToPoint 会非常方便
// 接受一个点位入参 Offset，是圆弧的终点，可指定圆弧半径radius、是否使用优弧、是否顺时针
// 左侧: 使用优弧: largeArc: true ,逆时针:clockwise: false
// 中间: 使用劣弧: largeArc: false ,顺时针:clockwise: true
// 右侧: 使用优弧: largeArc: true ,顺时针:clockwise: true
class PaintPainter extends CustomPainter {
  Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    Coordinate().paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    path.lineTo(80, -40);

//绘制中间
    path
      ..arcToPoint(
        Offset(40, 40),
        radius: Radius.circular(60),
        largeArc: false,
      )
      ..close();
    canvas.drawPath(path, paint);

    path.reset();
    canvas.translate(-150, 0);
//绘制左侧
    path.lineTo(80, -40);
    path
      ..arcToPoint(Offset(40, 40),
          radius: Radius.circular(60), largeArc: true, clockwise: false)
      ..close();
    canvas.drawPath(path, paint);

    path.reset();
    canvas.translate(150 + 150.0, 0);
//绘制右侧
    path.lineTo(80, -40);
    path
      ..arcToPoint(
        Offset(40, 40),
        radius: Radius.circular(60),
        largeArc: true,
      )
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
