import 'package:flutter/material.dart';
import 'package:matrioska/matrioska.dart';


class ActionBarPage extends StatefulWidget {
  ActionBarPage({Key? key}) : super(key: key);

  @override
  _MenuGroupPageState createState() => _MenuGroupPageState();
}

class _MenuGroupPageState extends State<ActionBarPage> {

  List<ActionItem> getData() {
    return [
      ActionItem("send", "选择厂区", Icons.send),
      ActionItem("cut","固化红图", Icons.cut),
      ActionItem("add","提交审批", Icons.add),
      ActionItem("delete","提交发布", Icons.delete),
    ];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('MenuGroupPage'),
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: ActionBar(
          data: getData(),
          itemLimit: 7,
          onActionTap: (item) {
            print(item.name);
          },
        ),
      ),
    );
  }


}
