import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widgets/learning/draw/coordinate.dart';

class PathPage01 extends StatefulWidget {
  @override
  _PathPage01State createState() => _PathPage01State();
}

class _PathPage01State extends State<PathPage01> {
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

    _paint
      ..color = Colors.pinkAccent
      ..style = PaintingStyle.fill;

    Path _path = Path();
    _path.moveTo(0, 0);
    _path.lineTo(80, 80);
    _path.lineTo(80, 0);
    _path.lineTo(0, -80);
    _path.close();

    canvas.drawPath(_path, _paint);

    _path..moveTo(0, 0)
    ..relativeLineTo(-80, 80)
    ..relativeLineTo(0, -80)
    ..relativeLineTo(80, -80);

    canvas.drawPath(_path, _paint..style=PaintingStyle.stroke..strokeWidth=2);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
