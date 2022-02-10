import 'dart:math';

import 'package:flutter/material.dart';

class ColorSortedPage extends StatefulWidget {
  @override
  _ColorSortedPageState createState() => _ColorSortedPageState();
}

class _ColorSortedPageState extends State<ColorSortedPage> {
  MaterialColor baseColor =
      Colors.primaries[Random().nextInt(Colors.primaries.length)];
  late List<Color> _colors;

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
    return Scaffold(
      appBar: AppBar(
        title: Text("色块排序"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("长按拖动从浅到深排序:"),
            Expanded(
              child: Container(
                width: 200,
                child: ReorderableListView(
                  onReorder: (int oldIndex, int newIndex) {
                    if (oldIndex < newIndex) {
                      newIndex--;
                    }
                    setState(() {
                      Color child = _colors.removeAt(oldIndex);
                      _colors.insert(newIndex, child);
                    });

                    //检查结果
                    _checkResult();
                  },
                  children: _colors
                      .map((e) => Box(
                            key: ValueKey(e),
                            color: e,
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Box extends StatelessWidget {
  final Color color;

  Box({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color,
      ),
    );
  }
}
