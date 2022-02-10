import 'dart:math';

import 'package:flutter/material.dart';

class ColorSortedPage2 extends StatefulWidget {
  @override
  _ColorSortedPage2State createState() => _ColorSortedPage2State();
}

class _ColorSortedPage2State extends State<ColorSortedPage2> {
  MaterialColor baseColor =
      Colors.primaries[Random().nextInt(Colors.primaries.length)];
  late List<Color> _colors;

  late int currentDragIndex;
  late GlobalKey _globalKey = new GlobalKey();
  late double _offsetY;

  @override
  void initState() {
    super.initState();
    _colors = List.generate(8, (index) => baseColor[(index + 1) * 100]!);
    _colors.shuffle();
  }

  _checkResult() {
    List<double> lum = _colors.map((e) => e.computeLuminance()).toList();
    print(lum);
    var success = true;
    for (int i = 0; i < lum.length - 1; i++) {
      if (lum[i] < lum[i + 1]) {
        success = false;
      }
    }
    if (success) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("恭喜"),
            content: Text("完成目标,进入下一关!"),
            actions: [
              TextButton(onPressed: () {
                setState(() {
                  baseColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
                  _colors = List.generate(8, (index) => baseColor[(index + 1) * 100]!);
                  _colors.shuffle();
                });
                Navigator.of(context).pop();
              }, child: Text("确认")),
              TextButton(onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }, child: Text("退出")),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double left = (MediaQuery.of(context).size.width - Box.width) / 2;
    return Scaffold(
      appBar: AppBar(
        title: Text("色块排序"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("长按拖动从浅到深排序:"),
          Expanded(
            child: Listener(
              onPointerMove: (PointerMoveEvent event) {
                print("=======$event=====");
                double y = event.position.dy - _offsetY;
                if(y > (currentDragIndex +1)*Box.height) {
                  if(currentDragIndex == _colors.length-1) return;
                  setState(() {
                    var newColor = _colors[currentDragIndex];
                    _colors[currentDragIndex] = _colors[currentDragIndex+1];
                    _colors[currentDragIndex+1] = newColor;
                    currentDragIndex++;
                  });
                }else if(y < currentDragIndex*Box.height) {
                  if(currentDragIndex == 0) return;
                  setState(() {
                    var newColor = _colors[currentDragIndex];
                    _colors[currentDragIndex] = _colors[currentDragIndex-1];
                    _colors[currentDragIndex-1] = newColor;
                    currentDragIndex--;
                  });
                }
                _checkResult();
              },
              child: Stack(
                key: _globalKey,
                children: List.generate(
                    _colors.length,
                    (index) => Box(
                          key: ValueKey(_colors[index]),
                          color: _colors[index],
                          index: index,
                          x: left,
                          onDrag: (position) {
                            currentDragIndex = position;

                            final renderBox = _globalKey.currentContext?.findRenderObject() as RenderBox;
                            _offsetY = renderBox.localToGlobal(Offset.zero).dy;
                          },
                        )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Box extends StatelessWidget {
  final Color color;
  static const double width = 200.0;
  static const double height = 50.0;
  static const double margin = 2.0;
  final int index;
  final double x;

  final Function(int ) onDrag;

  Box(
      {Key? key,
      required this.color,
      required this.index,
      required this.onDrag,
      required this.x})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 200),
      top: (index) * height,
      left: x,
      child: Draggable(
        onDragStarted: () => onDrag(index),
        feedback: Container(
          height: height - margin * 2,
          width: width,
          color: color,
        ),
        child: Container(
          height: height - margin * 2,
          width: width,
          color: color,
        ),
        childWhenDragging: Container(
          height: height - margin * 2,
          width: width,
          color: Colors.white,
        ),
      ),
    );
  }
}
