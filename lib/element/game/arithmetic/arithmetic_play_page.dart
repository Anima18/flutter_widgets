import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
import 'arithmetic_expression.dart';

// ignore: must_be_immutable
class ArithmeticPlayPage extends StatefulWidget {
  final ArithmeticStrategy strategy;

  ArithmeticPlayPage(this.strategy);

  @override
  _ArithmeticPlayPageState createState() => _ArithmeticPlayPageState();
}

class _ArithmeticPlayPageState extends State<ArithmeticPlayPage> {
  late StreamController<int> _inputController;
  late StreamController<int> _successController;
  late StreamController<int> _errorController;
  late StreamController<int> _completeController;
  late StreamController<int> _wrongAnswerController;

  int completePuzzleCount = 0;
  int wrongAnswerPuzzleCount = 0;
  final GlobalKey successTipKey = GlobalKey();
  final GlobalKey errorTipKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _inputController = StreamController.broadcast();
    _successController = StreamController.broadcast();
    _errorController = StreamController.broadcast();
    _completeController = StreamController();
    _wrongAnswerController = StreamController();

    _inputController.stream.listen((event) {
      wrongAnswerPuzzleCount = 0;
    });

    _wrongAnswerController.stream.listen((event) {
      wrongAnswerPuzzleCount += event;
      if (wrongAnswerPuzzleCount == widget.strategy.puzzleCount) {
        Vibration.vibrate();
      }
    });

    _completeController.stream.listen((event) {
      completePuzzleCount += event;
      if (completePuzzleCount == widget.strategy.puzzleCount) {
        _ScoreTipWidgetState successScoreState =
            successTipKey.currentState as _ScoreTipWidgetState;
        _ScoreTipWidgetState errorScoreState =
            errorTipKey.currentState as _ScoreTipWidgetState;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("完成"),
              content: Text(
                  "你答对了${successScoreState.count}题,答错了${errorScoreState.count}题"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text("完成"))
              ],
            );
          },
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _inputController.close();
    _successController.close();
    _errorController.close();
    _completeController.close();
    _wrongAnswerController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF96E3FF),
                Color(0xFF9EECFF),
                Color(0xFF9FEBFF),
                Color(0xFF9FEEFF),
                Color(0xFF9FECFF),
              ],
            ),
            image: DecorationImage(
              image: AssetImage('images/meditation.jpg'),
              alignment: Alignment.bottomCenter,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScoreTipWidget(
                  stream: _successController.stream,
                  iconData: Icons.done_all,
                  key: successTipKey,
                ),
                SizedBox(
                  height: 16,
                ),
                ScoreTipWidget(
                  stream: _errorController.stream,
                  iconData: Icons.close,
                  key: errorTipKey,
                ),
              ],
            ),
          ),
        ),
        ...List.generate(
            widget.strategy.puzzleCount,
            (index) => Puzzle(
                  inputStream: _inputController.stream,
                  successController: _successController,
                  errorController: _errorController,
                  completeController: _completeController,
                  wrongAnswerController: _wrongAnswerController,
                  strategy: widget.strategy,
                )).toList(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Keyboard(_inputController),
        )
      ],
    );
  }
}

class ScoreTipWidget extends StatefulWidget {
  final Stream<int> stream;
  final IconData iconData;

  ScoreTipWidget({Key? key, required this.stream, required this.iconData})
      : super(key: key);

  @override
  _ScoreTipWidgetState createState() => _ScoreTipWidgetState();
}

class _ScoreTipWidgetState extends State<ScoreTipWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(widget.iconData), Text("$count")],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.stream.listen((int event) {
      setState(() {
        count += event;
      });
    });
  }
}

class Puzzle extends StatefulWidget {
  final Stream<int> inputStream;
  //完成题目
  final StreamController<int> successController;
  //丢失题目
  final StreamController<int> errorController;
  //完成答题
  final StreamController<int> completeController;
  //错误回答
  final StreamController<int> wrongAnswerController;

  final ArithmeticStrategy strategy;

  Puzzle(
      {required this.inputStream,
      required this.successController,
      required this.errorController,
      required this.strategy,
      required this.completeController,
      required this.wrongAnswerController});

  @override
  _PuzzleState createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Color _backgroundColor;
  late ArithmeticExpression expression;
  late double top;
  late double left;

  static AudioCache player = AudioCache();

  _reset() {
    expression = widget.strategy.expressions.removeLast();
    left = Random().nextDouble() * 300;
    _backgroundColor =
        Colors.primaries[Random().nextInt(Colors.primaries.length)][200]!;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: widget.strategy.duration));

    _reset();
    Future.delayed(Duration(milliseconds: 200 * Random().nextInt(10)), () {
      _controller.forward();
    });

    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        _controller.forward(from: 0.0);
        widget.errorController.add(1);
        //Vibration.vibrate();
        player.play("error.wav");
        if (widget.strategy.expressions.length > 0) {
          _reset();
        } else {
          _complete();
        }
      }
    });

    widget.inputStream.listen((int event) {
      if (_checkSuccess(event, expression)) {
        _controller.forward(from: 0.0);
        widget.successController.add(1);
        player.play('clear.wav');
        if (widget.strategy.expressions.length > 0) {
          _reset();
        } else {
          _complete();
        }
      } else {
        widget.wrongAnswerController.add(1);
      }
    });
  }

  bool _checkSuccess(int value, ArithmeticExpression expression) {
    if (expression.operator == Operator.add) {
      return value == (expression.a + expression.b);
    } else if (expression.operator == Operator.reduce) {
      return value == (expression.a - expression.b);
    } else {
      return false;
    }
  }

  void _complete() {
    _controller.stop();
    widget.completeController.add(1);
  }

  @override
  void dispose() {
    _controller.dispose();
    player.clearAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    top = MediaQuery.of(context).size.height -
        MediaQuery.of(context).size.width / 2;
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Positioned(
            top: top * _controller.value - 30,
            left: left,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  color: _backgroundColor.withOpacity(0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(16))),
              child: Text(
                "${expression.a} ${OperatorValue.getValue(expression.operator)} ${expression.b}",
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        });
  }
}

class Keyboard extends StatefulWidget {
  final StreamController controller;
  Keyboard(this.controller);
  @override
  _KeyboardState createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  final List<String> valueItems = [];
  String inputValue = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: HexColor.fromHex("#f2f3f6"),
      height: MediaQuery.of(context).size.width * 2 / 5 + 78,
      child: Column(
        children: [
          Container(
            height: 28,
            alignment: Alignment.center,
            child: Text("$inputValue"),
          ),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            childAspectRatio: 5 / 2,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            children: [
              ...List.generate(
                  9,
                  (index) => TextButton(
                        onPressed: () {
                          valueItems.add("${index + 1}");
                          _updateInputValue();
                        },
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      )).toList(),
              TextButton(
                  onPressed: () {
                    valueItems.add("-");
                    _updateInputValue();
                  },
                  child: Text("-",
                      style: TextStyle(color: Colors.black, fontSize: 20))),
              TextButton(
                  onPressed: () {
                    valueItems.add("0");
                    _updateInputValue();
                  },
                  child: Text("0",
                      style: TextStyle(color: Colors.black, fontSize: 20))),
              TextButton(
                  onPressed: () {
                    if (inputValue.isNotEmpty) {
                      widget.controller.add(int.parse(inputValue));
                      valueItems.clear();
                      _updateInputValue();
                    }
                  },
                  child: Icon(Icons.done)),
            ],
          ),
        ],
      ),
    );
  }

  void _updateInputValue() {
    setState(() {
      inputValue = "";
      valueItems.forEach((element) {
        inputValue += element;
      });
    });
  }
}
