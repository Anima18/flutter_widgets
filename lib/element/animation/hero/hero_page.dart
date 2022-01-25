import 'package:flutter/material.dart';

class HeroPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("page1"),
      ),
      body: GestureDetector(
        onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (_)=>HeroPage2())),
        child: Hero(
          tag: "hero",
          child: Container(
            height: 100,
            width: 100,
            child: FlutterLogo(),
          ),
        ),
      ),
    );
  }
}

class HeroPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("page2"),
      ),
      body: Hero(
        tag: "hero",
        child: Center(
          child: Container(
            height: 400,
            width: 400,
            child: FlutterLogo(),
          ),
        ),
      ),
    );
  }
}