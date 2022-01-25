
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//api: https://www.jianshu.com/p/b64dccaf8499
class InputWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("TextField"),
    ),
      body:
      SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("基础输入框"),
                TextField( ),
                Text("文本域"),
                Container(
                  //设置 child 居中
                  alignment: Alignment(0, 0),
                  height: 100,
                  width: double.infinity,
                  padding: EdgeInsets.all(6),
                  //边框设置
                  decoration: new BoxDecoration(
                    //背景
                    color: Colors.white,
                    //设置四周圆角 角度
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    //设置四周边框
                    border: new Border.all(width: 1, color: Colors.grey),
                  ),
                  child: TextField(
                    maxLines: 5,
                    decoration: InputDecoration.collapsed(hintText: "Enter your text here"),
                  ),
                ),

                Text("Material输入框"),
                TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    icon: Icon(Icons.access_alarm),
                    labelText: "姓名",
                    helperText: "请输入你的真实姓名",
                  ),
                  onChanged: _textValueChange,
                  onSubmitted: _textValueSubmit,
                ),

                SizedBox(
                  width: 400,
                  height: 130,
                  child: Container(
                    color: Colors.white24,
                    ///距离顶部
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.all(10),
                    ///Alignment 用来对齐 Widget
                    alignment: Alignment(0, 0),
                    ///文本输入框
                    child: TextField(

                      ///用来配置 TextField 的样式风格
                      decoration: InputDecoration(
                        ///设置输入文本框的提示文字
                        ///输入框获取焦点时 并且没有输入文字时
                        hintText: "请输入用户名",
                        ///设置输入文本框的提示文字的样式
                        hintStyle: TextStyle(color: Colors.grey,textBaseline: TextBaseline.ideographic,),
                        ///输入框内的提示 输入框没有获取焦点时显示
                        labelText: "用户名",
                        labelStyle: TextStyle(color: Colors.blue),
                        ///显示在输入框下面的文字
                        helperText: "这里是帮助提示语",
                        helperStyle: TextStyle(color: Colors.green),

                        ///显示在输入框下面的文字
                        ///会覆盖了 helperText 内容
                        errorText: "这里是错误文本提示",
                        errorStyle: TextStyle(color: Colors.red),

                        ///输入框获取焦点时才会显示出来 输入文本的前面
                        prefixText: "prefix",
                        prefixStyle: TextStyle(color: Colors.deepPurple),
                        ///输入框获取焦点时才会显示出来 输入文本的后面
                        suffixText: "suf ",
                        suffixStyle: TextStyle(color: Colors.black),

                        ///文本输入框右下角显示的文本
                        ///文字计数器默认使用
                        counterText: "count",
                        counterStyle:TextStyle(color: Colors.deepPurple[800]),

                        ///输入文字前的小图标
                        prefixIcon: Icon(Icons.phone),
                        ///输入文字后面的小图标
                        suffixIcon: Icon(Icons.close),

                        ///与 prefixText 不能同时设置
//                prefix: Text("A") ,
                        /// 与 suffixText 不能同时设置
//                suffix:  Text("B") ,
                        ///设置边框
                        ///   InputBorder.none 无下划线
                        ///   OutlineInputBorder 上下左右 都有边框
                        ///   UnderlineInputBorder 只有下边框  默认使用的就是下边框
                        border: OutlineInputBorder(
                          ///设置边框四个角的弧度
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          ///用来配置边框的样式
                          borderSide: BorderSide(
                            ///设置边框的颜色
                            color: Colors.red,
                            ///设置边框的粗细
                            width: 2.0,
                          ),
                        ),
                        ///设置输入框可编辑时的边框样式
                        enabledBorder: OutlineInputBorder(
                          ///设置边框四个角的弧度
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          ///用来配置边框的样式
                          borderSide: BorderSide(
                            ///设置边框的颜色
                            color: Colors.blue,
                            ///设置边框的粗细
                            width: 2.0,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          ///设置边框四个角的弧度
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          ///用来配置边框的样式
                          borderSide: BorderSide(
                            ///设置边框的颜色
                            color: Colors.red,
                            ///设置边框的粗细
                            width: 2.0,
                          ),
                        ),
                        ///用来配置输入框获取焦点时的颜色
                        focusedBorder: OutlineInputBorder(
                          ///设置边框四个角的弧度
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          ///用来配置边框的样式
                          borderSide: BorderSide(
                            ///设置边框的颜色
                            color: Colors.green,
                            ///设置边框的粗细
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
      ),

    );
  }

  void _textValueChange(String value) {
    print("_textValueChange: $value");
  }

  void _textValueSubmit(String value) {
    print("_textValueSubmit: $value");
  }
}