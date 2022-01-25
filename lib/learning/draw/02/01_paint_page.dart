
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaintPage01 extends StatefulWidget {
  @override
  _PaintPage01State createState() => _PaintPage01State();
}

class _PaintPage01State extends State<PaintPage01> {
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
        [ DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown
        ]);
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
    Paint paint = Paint();

    canvas.drawCircle(Offset(100, 100), 50, paint..color = Colors.blue ..strokeWidth = 5);
    canvas.drawCircle(Offset(100+100, 100), 50, paint..color = Colors.redAccent ..isAntiAlias = false);
    canvas.drawCircle(Offset(100, 220), 50, paint..color = Colors.blue ..strokeWidth = 10..style=PaintingStyle.stroke);
    canvas.drawCircle(Offset(100+120, 220), 50, paint..color = Colors.redAccent ..style=PaintingStyle.fill);

    Paint paint02 = Paint();
    paint02..style = PaintingStyle.stroke
    ..color = Colors.blue
    ..strokeWidth = 20;

    canvas.drawLine(Offset(450, 50), Offset(450, 150), paint02..strokeCap = StrokeCap.butt);
    canvas.drawLine(Offset(500, 50), Offset(500, 150), paint02..strokeCap = StrokeCap.round);
    canvas.drawLine(Offset(550, 50), Offset(550, 150), paint02..strokeCap = StrokeCap.square);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;

}