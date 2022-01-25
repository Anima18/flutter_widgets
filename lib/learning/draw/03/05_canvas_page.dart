import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:flutter_widgets/learning/draw/coordinate.dart';

class CanvasPage05 extends StatefulWidget {
  @override
  _CanvasPage05State createState() => _CanvasPage05State();
}

class _CanvasPage05State extends State<CanvasPage05> {
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

    canvas.drawCircle(Offset(0, 0), 60, _paint);

    var rect = Rect.fromCenter(center: Offset(150, 0), width: 100, height: 60);
    canvas.drawOval(rect, _paint);

    var rect2 = Rect.fromCenter(center: Offset(-150, 0), width: 100, height: 100);
    canvas.drawArc(rect2, 0, pi / 2 * 3, true, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
