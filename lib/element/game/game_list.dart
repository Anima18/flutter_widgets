
import 'package:flutter/material.dart';
import 'package:flutter_widgets/element/game/color_sorted_page2.dart';

import 'arithmetic_game_page.dart';
import 'color_sorted_page.dart';

class GameListPage extends StatelessWidget {

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
                child: Text("色块排序游戏",),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ColorSortedPage()));
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlinedButton(
                child: Text("色块排序游戏2",),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ColorSortedPage2()));
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlinedButton(
                child: Text("算术游戏",),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ArithmeticGamePage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}