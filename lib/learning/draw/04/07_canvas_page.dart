import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widgets/learning/draw/coordinate.dart';

class CanvasPage07 extends StatefulWidget {
  @override
  _CanvasPage07State createState() => _CanvasPage07State();
}

class _CanvasPage07State extends State<CanvasPage07> {
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
    _drawTextWithParagraph(canvas, TextAlign.center);

    _drawTextPaint(canvas);
    _drawTextPaintShowSize(canvas);
  }

  void _drawTextWithParagraph(Canvas canvas,TextAlign textAlign) {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: textAlign,
      fontSize: 40,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    ));
    builder.pushStyle(
      ui.TextStyle(
          color: Colors.black87, textBaseline: ui.TextBaseline.alphabetic),
    );
    builder.addText("Flutter Unit");
    ui.Paragraph paragraph = builder.build();
    paragraph.layout( ui.ParagraphConstraints(width: 300));
    canvas.drawParagraph(paragraph, Offset(0, 0));
    canvas.drawRect(Rect.fromLTRB(0, 0, 300, 40 ),
        _paint..color = Colors.blue.withAlpha(33));
  }

  void _drawTextPaint(Canvas canvas) {
    var textPainter = TextPainter(
        text: TextSpan(
            text: 'Flutter Unit',
            style: TextStyle(fontSize: 40,color: Colors.black)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    textPainter.layout(); // 进行布局
    textPainter.paint(canvas, Offset(50, -50)); // 进行绘制
  }

  void _drawTextPaintShowSize(Canvas canvas) {
    TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: 'Flutter Unit',
            style: TextStyle(
                fontSize: 40,
                color: Colors.black)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    textPainter.layout(); // 进行布局
    Size size = textPainter.size; // 尺寸必须在布局后获取
    textPainter.paint(canvas, Offset(-size.width / 2, -size.height / 2));

    canvas.drawRect(
        Rect.fromLTRB(0, 0, size.width, size.height)
            .translate(-size.width / 2, -size.height / 2),
        _paint..color = Colors.blue.withAlpha(33));
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
