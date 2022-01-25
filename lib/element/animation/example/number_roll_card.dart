// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

class NumberRollCard extends StatefulWidget {
  @override
  _NumberRollCardState createState() => _NumberRollCardState();
}

class _NumberRollCardState extends State<NumberRollCard> {

  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("翻滚数字卡片"),
      ),
      body: Center(
        child: Container(
          height: 120,
          width: 200,
          color: Colors.blue,
          child: AnimatedCounter(
            value: _count,
            duration: Duration(milliseconds: 500),
            fontSize: 100,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _count++;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AnimatedCounter extends StatelessWidget {
  final int value;
  final Duration duration;
  final double fontSize;

  AnimatedCounter(
      {required this.value, required this.duration, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: duration,
      tween: Tween(end: value.toDouble()),
      builder: (context, double value, child) {
        final whole = value ~/ 1;
        final decimal = value - whole;
        print("$whole ------------$decimal");
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
                top: -decimal * fontSize, //0 -> -100
                child: Opacity(
                  opacity: 1 - decimal,
                  child: Text(
                    "$whole",
                    style: TextStyle(fontSize: fontSize),
                  ),
                )),
            Positioned(
              top: (1 - decimal) * fontSize, // 100 ->0
              child: Opacity(
                opacity: decimal,
                child: Text(
                  "${whole + 1}",
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
