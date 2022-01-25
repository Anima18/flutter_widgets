import 'package:flutter/material.dart';

class Coordinate {
  final double step;
  final double strokeWidth;
  final Color gridColor;
  final Paint _gridPaint = Paint();
  final Paint _axisPaint = Paint();

  Coordinate(
      {this.step = 20, this.strokeWidth = 0.5, this.gridColor = Colors.grey});

  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    _drawGrid(canvas, size);
    _drawAxis(canvas, size);
    canvas.restore();
  }

  void _drawAxis(Canvas canvas, Size size) {
    _axisPaint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 2;
    canvas.drawLine(Offset(-size.width/2, 0) , Offset(size.width/2, 0),_axisPaint);
    canvas.drawLine(Offset( 0,-size.height/2) , Offset( 0,size.height/2),_axisPaint);
    canvas.drawLine(Offset( 0,size.height/2) , Offset( 0-7.0,size.height/2-10),_axisPaint);
    canvas.drawLine(Offset( 0,size.height/2) , Offset( 0+7.0,size.height/2-10),_axisPaint);
    canvas.drawLine(Offset(size.width/2, 0) , Offset(size.width/2-10, 7),_axisPaint);
    canvas.drawLine(Offset(size.width/2, 0) , Offset(size.width/2-10, -7),_axisPaint);
  }

  void _drawGrid(Canvas canvas, Size size) {
    _gridPaint
      ..style = PaintingStyle.stroke
      ..color = gridColor
      ..strokeWidth = strokeWidth;

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
}
