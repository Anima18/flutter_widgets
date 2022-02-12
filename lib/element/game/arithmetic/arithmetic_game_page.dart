import 'package:flutter/material.dart';
import 'package:flutter_widgets/element/game/arithmetic/arithmetic_expression.dart';
import 'package:flutter_widgets/element/game/arithmetic/arithmetic_play_page.dart';

class ArithmeticGamePage extends StatelessWidget {
  const ArithmeticGamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("游戏"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: OutlinedButton(
                child: Text(
                  "简单加法",
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ArithmeticPlayPage(
                          ArithmeticStrategyFactory.getSimpleAddStrategy())));
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlinedButton(
                child: Text(
                  "简单减法",
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ArithmeticPlayPage(
                          ArithmeticStrategyFactory.getSimpleReduceStrategy())));
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlinedButton(
                child: Text(
                  "简单加减法",
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ArithmeticPlayPage(
                          ArithmeticStrategyFactory.getSimpleAddAndReduceStrategy())));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
