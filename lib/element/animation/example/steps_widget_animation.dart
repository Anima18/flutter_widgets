import 'package:flutter/material.dart';

class StepsAnimationPage extends StatefulWidget {
  @override
  _StepsAnimationPageState createState() => _StepsAnimationPageState();
}

class _StepsAnimationPageState extends State<StepsAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("交错动画"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SlideBox(controller: _controller,interval: Interval(0.0, 0.2),color: Colors.blue[100]!),
            SlideBox(controller: _controller,interval: Interval(0.2, 0.4),color: Colors.blue[300]!),
            SlideBox(controller: _controller,interval: Interval(0.4, 0.6),color: Colors.blue[500]!),
            SlideBox(controller: _controller,interval: Interval(0.6, 0.8),color: Colors.blue[700]!),
            SlideBox(controller: _controller,interval: Interval(0.8, 1.0),color: Colors.blue[900]!),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.repeat(reverse: true);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class SlideBox extends StatelessWidget {
  final AnimationController controller;
  final Color color;
  final Interval interval;

  SlideBox(
      {required this.controller, required this.interval, required this.color});

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween(begin: Offset.zero, end: Offset(0.1, 0))
          .chain(CurveTween(curve: interval))
          .animate(controller),
      child: Container(
        height: 48,
        width: 200,
        color: color,
      ),
    );
  }
}
