import 'package:flutter/material.dart';
import 'package:matrioska/matrioska.dart';

// ignore: must_be_immutable
class StateViewTest extends StatefulWidget {


  @override
  State createState() {
    return StateViewState();
  }
}

class StateViewState extends State {
  DataState viewStatus = DataState.loading;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
            title: Text("StateView"),
            actions: <Widget>[
              FlatButton(
                child: Text("contnet"),
                onPressed: () {
                  setState(() {
                    viewStatus = DataState.success;
                  });
                },
              ),
              FlatButton(
                child: Text("loading"),
                onPressed: () {
                  setState(() {
                    viewStatus = DataState.loading;
                  });
                },
              ),
              FlatButton(
                child: Text("error"),
                onPressed: () {
                  setState(() {
                    viewStatus = DataState.error;
                    errorMessage = "网络请求失败";
                  });
                },
              ),
              FlatButton(
                child: Text("empty"),
                onPressed: () {
                  setState(() {
                    viewStatus = DataState.empty;
                  });
                },
              ),
            ]),
        body: StateView(
          viewState: viewStatus,
          errorMessage: errorMessage,
          onRetry: () {
            print("stateView retry");
            setState(() {
              viewStatus = DataState.loading;
            });
          }, builder: (BuildContext context, Widget? child) {
            return Center(
              child: Text("hello world"),
            );
        },
        )
    );
  }
}