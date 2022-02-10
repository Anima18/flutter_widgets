import 'package:flutter/material.dart';

class BreatheAnimationPage extends StatefulWidget {
  @override
  _BreatheAnimationPageState createState() => _BreatheAnimationPageState();
}

class _BreatheAnimationPageState extends State<BreatheAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
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
        title: Text("478呼吸"),
      ),
      body: Center(
        child: BreatheTransition(
          controller: _controller,
          breathe: Breathe(
              name: "478",
              inhaleTime: 4,
              stopTime: 7,
              expirationTime: 8,),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_controller.isAnimating) {
            TickerFuture tickerFuture  = _controller.repeat();
            tickerFuture.timeout(Duration(seconds:  19 * 2), onTimeout:  () {
              //_animationController.forward(from: 0);
              if(_controller.isAnimating) {
                _controller.stop(canceled: true);
              }
              print("================");
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Breathe {
  final String name;
  final int inhaleTime;
  final int stopTime;
  final int expirationTime;

  Breathe(
      {required this.name,
      required this.inhaleTime,
      required this.stopTime,
      required this.expirationTime,});

  int get allTime => inhaleTime + stopTime + expirationTime;
}

class BreatheTransition extends StatefulWidget {
  final Breathe breathe;
  final AnimationController controller;
  BreatheTransition({required this.breathe, required this.controller}) {
    controller.duration = Duration(seconds: breathe.allTime);
  }

/*  void start() {
    if (!controller.isAnimating) {
      controller.repeat();
    }
  }

  void stop() {
    if (controller.isAnimating) {
      controller.stop();
    }
  }*/

  @override
  _BreatheTransitionState createState() => _BreatheTransitionState();
}

class _BreatheTransitionState extends State<BreatheTransition> {
  @override
  Widget build(BuildContext context) {
    Breathe breathe = widget.breathe;
    AnimationController _controller = widget.controller;
    final inhaleAnimate = Tween(begin: 0.0, end: 1.0)
        .chain(CurveTween(
            curve: Interval(0.0, breathe.inhaleTime / breathe.allTime)))
        .animate(_controller);

    final expirationAnimate = Tween(begin: 1.0, end: 0.0)
        .chain(CurveTween(
            curve: Interval(
                (breathe.inhaleTime + breathe.stopTime) / breathe.allTime, 1)))
        .animate(_controller);

    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        String textValue = "";
        if (_controller.value <= 0.2) {
          textValue = "吸气";
        } else if (_controller.value <= 0.55) {
          textValue = "屏住呼吸";
        } else {
          textValue = "呼气";
        }
        return Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [Colors.blue[600]!, Colors.blue[100]!],
              stops: _controller.value <= 0.2
                  ? [inhaleAnimate.value, inhaleAnimate.value + 0.1]
                  : [expirationAnimate.value, expirationAnimate.value + 0.1],
            ),
          ),
          child: Center(child: Text(textValue)),
        );
      },
    );
  }
}
