import 'package:flutter/material.dart';

class SvgTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Dialog Widget"),
        ),
        body: Builder(builder: (BuildContext context) {
          return Container(
              width:200,
              height:200,
              child:Text("hello"),
          );

        })
    );
  }
}
