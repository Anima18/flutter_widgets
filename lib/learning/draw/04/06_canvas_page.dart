import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widgets/learning/draw/coordinate.dart';

class CanvasPage06 extends StatefulWidget {
  @override
  _CanvasPage06State createState() => _CanvasPage06State();
}

class _CanvasPage06State extends State<CanvasPage06> {
  ui.Image? _image;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: PaintPainter(_image!),
      ),
    );
  }

  //读取 assets 中的图片
  Future<ui.Image> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    Uint8List bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return decodeImageFromList(bytes);
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

    loadImage();
  }

  void loadImage() async {
    _image = await loadImageFromAssets("images/leo.jpeg");
    setState(() {

    });
  }
}

class PaintPainter extends CustomPainter {
  final ui.Image _image;

  PaintPainter(this._image);

  @override
  void paint(Canvas canvas, Size size) {
    Coordinate().paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    //offset image在画布的开始位置
    canvas.drawImage(_image, Offset(-_image.width / 2, -_image.height / 2), Paint());

    canvas.drawImageRect(_image,
        Rect.fromCenter(center: Offset(_image.width/2+20, _image.height/2), width: 100, height: 100),
        Rect.fromLTWH(100, -150, 150, 150), Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
