import 'package:flutter/material.dart';
import 'package:matrioska/matrioska.dart';

class MenuGroupPage extends StatefulWidget {
  MenuGroupPage({Key? key}) : super(key: key);

  @override
  _MenuGroupPageState createState() => _MenuGroupPageState();
}

class _MenuGroupPageState extends State<MenuGroupPage> {

  List<GroupItem> getData() {
    GroupItem group = GroupItem("ccc",Text("图形服务"),Icon(Icons.event, color: Colors.red, size: 36,) );
    group.children = [
      GroupItem("ccc", Text("图形版本"), Icon(Icons.event, color: Colors.red, size: 36,),),
      GroupItem("ccc",Text("已审批图形"), Icon(Icons.copy, color: Colors.purple, size: 36,), ),
      GroupItem("ccc",Text("未审批图形"), Icon(Icons.code, color: Colors.green, size: 36,), ),
      GroupItem("ccc",Text("已发布流程"), Icon(Icons.print, color: Colors.blue, size: 36,), ),
      GroupItem("ccc",Text("流转中流程"), Icon(Icons.details, color: Colors.red, size: 36,), ),
    ];
    return [
      group
    ];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('MenuGroupPage'),
      ),
      body: Container(
        child: MenuGroupView(
          data: getData(),
          crossAxisCount: 3,
          onItemTap: (item) {},
        ),
      ),
    );
  }


}
