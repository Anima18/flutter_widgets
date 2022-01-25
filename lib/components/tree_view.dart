import 'package:flutter/material.dart';
import 'package:matrioska/matrioska.dart';
class TreeWidgetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<TreeData> dataList = [];
    TreeData firstTree = TreeData("1", "11111111", "111111", expanded: true);
    TreeData secondTree = TreeData("2", "222222222", "222222", expanded: true);
    dataList.add(firstTree);
    dataList.add(secondTree);
    initDat(firstTree, 2);
    initDat(secondTree, 2);

    return Scaffold(
      appBar: AppBar(title: Text('Flutter Tree')),
      body: TreeView(
        data: dataList,
        leadingIcon: IconButton(
          icon: Image(
            image: AssetImage("icons/ic_folder.png"),
          ),
          iconSize: 10,
          onPressed: () {},
        ),
        childIcon: IconButton(
          icon: Image(
            image: AssetImage("icons/ic_launcher.png"),
          ),
          iconSize: 10,
          onPressed: () {},
        ),
        titleOnTap: (treeData) {
          print(treeData);
        },
        leadingOnTap: () {
          print('leading');
        },
        trailingOnTap: () {
          print('trailing');
        },
      ),
    );
  }

/*  List<TreeData> dataList = List();*/
  void initDat(TreeData? root, int level) {
    if(root == null) {
      return;
    }
    if(level >4) {
      return;
    }

    List<TreeData> children = [];
    root.children = children;
    TreeData? firstChild;
    for(int i = 0; i < level; i++) {
      if(i == 0) {
        firstChild = TreeData("code", "title${level}-${i}", "data", expanded: level < 3);
        children.add(firstChild);
      }else {
        children.add(TreeData("code", "title${level}-${i}", "data", expanded: level < 3));
      }
    }

    initDat(firstChild, ++level);

  }

}
