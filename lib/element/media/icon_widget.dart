import 'package:flutter/material.dart';

import 'antdIcons.dart';

class IconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Icon Widget"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Text(
                "系统的图标",
                style: TextStyle(fontSize: 20),
              ),
              Icon(Icons.approval),

              Text(
                "自定义的图标",
                style: TextStyle(fontSize: 20),
              ),
              Icon(Antdicons.apply),

            ],
          ),
        ),
      ),
    );
  }
}
