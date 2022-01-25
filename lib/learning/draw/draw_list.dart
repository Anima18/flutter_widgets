import 'package:flutter/material.dart';

class DrawListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Draw List"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '01:使用CustomPaint组件',
                style: TextStyle(fontSize: 14),
              ),
              itemView(context, "CustomPaint", "custom_paint_test"),

              SizedBox(height: 24,),
              Text(
                '02:画笔属性',
                style: TextStyle(fontSize: 14),
              ),
              itemView(context, "Paint01", "01_paint_page"),

              SizedBox(height: 24,),
              Text(
                '03:画布绘制基础',
                style: TextStyle(fontSize: 14),
              ),
              itemView(context, "Canvas01", "01_canvas_page"),
              itemView(context, "Canvas02", "02_canvas_page"),
              itemView(context, "Canvas03", "03_canvas_page"),
              itemView(context, "Canvas04", "04_canvas_page"),
              itemView(context, "Canvas05", "05_canvas_page"),

              SizedBox(height: 24,),
              Text(
                '04:画布绘制图片和文字',
                style: TextStyle(fontSize: 14),
              ),
              itemView(context, "Canvas06", "06_canvas_page"),
              itemView(context, "Canvas07", "07_canvas_page"),


              SizedBox(height: 24,),
              Text(
                '05:画布绘制路径',
                style: TextStyle(fontSize: 14),
              ),
              itemView(context, "Path01", "01_path_page"),
              itemView(context, "Path02", "02_path_page"),


            ],
          ),
        ),
      ),
    );
  }

  Widget itemView(BuildContext context, String title, String pageRoute) {
    return Container(
      width: double.infinity,
      child: OutlineButton(
        child: Text(title),
        onPressed: () {
          if(pageRoute.isNotEmpty) {
            Navigator.pushNamed(context, pageRoute);
          }
        },
      ),
    );
  }
}
