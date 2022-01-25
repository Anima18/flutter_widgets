
import 'package:flutter/material.dart';

class FormMain extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Widget"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: OutlineButton(
                child: Text("Input",),
                onPressed: () {
                  Navigator.pushNamed(context, "input_widget");
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlineButton(
                child: Text("Checkbox",),
                onPressed: () {
                  Navigator.pushNamed(context, "checkbox_widget");
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlineButton(
                child: Text("Button",),
                onPressed: () {
                  Navigator.pushNamed(context, "button_widget");
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlineButton(
                child: Text("Text",),
                onPressed: () {
                  Navigator.pushNamed(context, "text_widget");
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlineButton(
                child: Text("Radio",),
                onPressed: () {
                  Navigator.pushNamed(context, "radio_widget");
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlineButton(
                child: Text("Slider",),
                onPressed: () {},
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlineButton(
                child: Text("Switch",),
                onPressed: () {
                  Navigator.pushNamed(context, "switch_widget");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}