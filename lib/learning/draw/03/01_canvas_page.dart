import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CanvasPage01 extends StatefulWidget {
  @override
  _CanvasPage01State createState() => _CanvasPage01State();
}

class _CanvasPage01State extends State<CanvasPage01> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: PaintPainter01(),
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

class PaintPainter01 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.translate(size.width / 2, size.height / 2);

    canvas.drawCircle(Offset(0, 0), 100, paint);

    canvas.drawLine(
        Offset(30, 30),
        Offset(100, 100),
        Paint()
          ..style = PaintingStyle.stroke
          ..color = Colors.redAccent
          ..strokeWidth = 8);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
