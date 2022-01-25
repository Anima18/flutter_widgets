import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class CanvasPage02 extends StatefulWidget {
  @override
  _CanvasPage02State createState() => _CanvasPage02State();
}

class _CanvasPage02State extends State<CanvasPage02> {
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
  final double step = 20;
  final Paint _gridPaint = Paint()
    ..color = Colors.grey
    ..style = PaintingStyle.stroke
    ..strokeWidth = 0.5;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.translate(size.width / 2, size.height / 2);

    _drawBottomRight(canvas, size);
    canvas.save();
    canvas.scale(1, -1); //沿x轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, 1); //沿y轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, -1); //沿原点镜像
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.drawCircle(Offset(0, 0), 50, paint);

    canvas.drawLine(
        Offset(20, 20),
        Offset(50, 50),
        Paint()
          ..style = PaintingStyle.stroke
          ..color = Colors.redAccent
          ..strokeWidth = 8);

    _drawDot(canvas, paint);
  }

  void _drawDot(Canvas canvas, Paint paint) {
    final int count = 12;
    paint
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    canvas.save();
    for(int i = 0; i < count; i++) {
      var step = 2 * pi / count;
      canvas.drawLine(Offset(0, 70), Offset(0, 90), paint);
      canvas.rotate(step);
    }
    canvas.restore();
  }

  void _drawBottomRight(Canvas canvas, Size size) {
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(size.width / 2, 0), _gridPaint);
      canvas.translate(0, step);
    }
    canvas.restore();

    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(0, size.height / 2), _gridPaint);
      canvas.translate(step, 0);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
