import 'package:flutter/material.dart';

class AnimatedBuilderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnimatedBuilder"),
      ),
      body: AnimationIcon(),
    );
  }
}

class AnimationIcon extends StatefulWidget {
  @override
  _AnimationIconState createState() => _AnimationIconState();
}

class _AnimationIconState extends State<AnimationIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    _animation = Tween(begin: 50.0, end: 200.0)
        .chain(CurveTween(curve: Curves.elasticOut))
        .animate(_controller);
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        child: FlutterLogo(),
        builder: (context, child) => Container(
          width: _animation.value, // 使用动画的当前状态更新 UI
          height: _animation.value,
          child: child, //child 参数即 FlutterLogo()
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
