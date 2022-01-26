import 'dart:math';

import 'package:flutter/material.dart';

class SnowmanAnimatedPage extends StatefulWidget {
  @override
  _SnowmanAnimatedPageState createState() => _SnowmanAnimatedPageState();
}

class _SnowmanAnimatedPageState extends State<SnowmanAnimatedPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Snowflake> snowflakes;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void snow() {
    if (_controller.isAnimating) {
      _controller.stop();
    }
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    snowflakes =
        List.generate(100, (index) => Snowflake(size.width, size.height));
    return Scaffold(
      appBar: AppBar(
        title: Text("对雪人啦"),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                child: Text("小雪"),
                value: '1',
              ),
              PopupMenuItem<String>(
                child: Text("中雪"),
                value: '2',
              ),
              PopupMenuItem<String>(
                child: Text("大雪"),
                value: '3',
              ),
            ],
            onSelected: (String action) {
              // 点击选项的时候
              switch (action) {
                case '1':
                  snowflakes = List.generate(
                      100, (index) => Snowflake(size.width, size.height));
                  snow();
                  break;
                case '2':
                  snowflakes = List.generate(
                      1000, (index) => Snowflake(size.width, size.height));
                  snow();
                  break;
                case '3':
                  snowflakes = List.generate(
                      2000, (index) => Snowflake(size.width, size.height));
                  snow();
                  break;
              }
            },
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue[600],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[600]!, Colors.blue[100]!, Colors.white],
            stops: [0.4, 0.9, 1.0]
          )
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            snowflakes.forEach((element) => element.fall());
            return CustomPaint(
              painter: SnowmanPainter(snowflakes),
            );
          },
        ),
      ),
    );
  }
}

class SnowmanPainter extends CustomPainter {
  final List<Snowflake> _snowflakes;

  SnowmanPainter(this._snowflakes);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white;
    canvas.drawCircle(
        size.center(Offset(0, size.height / 8)), size.width / 8, paint);
    canvas.drawOval(
        Rect.fromCenter(
            center: size.center(Offset(0, size.height / 7 + size.height / 5)),
            width: size.width / 2,
            height: size.height / 3),
        paint);

    _snowflakes.forEach((element) {
      canvas.drawCircle(Offset(element.x, element.y), element.radius, paint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Snowflake {
  late double x;
  late double y;
  late double radius;

  final double width;
  final double height;

  Snowflake(this.width, this.height) {
    x = Random().nextDouble() * width;
    y = Random().nextDouble() * height;
    radius = Random().nextDouble() * 2 + 2;
  }

  void fall() {
    y += Random().nextDouble() * 4 + 2;
    if (y > height) {
      y = 0;
      x = Random().nextDouble() * width;
      radius = Random().nextDouble() * 2 + 2;
    }
  }
}
