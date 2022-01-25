import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matrioska/matrioska.dart';

class ExpansionPanelPage extends StatefulWidget {
  ExpansionPanelPage({Key? key}) : super(key: key);

  @override
  _ExpansionPanelPageState createState() => _ExpansionPanelPageState();
}

class _ExpansionPanelPageState extends State<ExpansionPanelPage> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: AppBar(
        title: Text('ExpansionPanelPage'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: _buildPanel(),
        ),
      ),
    );
  }

  Widget _buildPanel() {
    List<ListItem> dataList = [];
    dataList.add(ListItem("1", "11111111111111"));
    dataList.add(ListItem("2", "22222222222222"));
    dataList.add(ListItem("3", "33333333333333"));
    dataList.add(ListItem("4", "44444444444444"));
    dataList.add(ListItem("5", "55555555555555"));
    dataList.add(ListItem("5", "55555555555555"));
    dataList.add(ListItem("5", "55555555555555"));
    dataList.add(ListItem("5", "55555555555555"));
    dataList.add(ListItem("5", "55555555555555"));
    dataList.add(ListItem("5", "55555555555555"));
    dataList.add(ListItem("5", "55555555555555"));
    dataList.add(ListItem("5", "55555555555555"));
    dataList.add(ListItem("5", "55555555555555"));
    dataList.add(ListItem("5", "55555555555555"));
    dataList.add(ListItem("5", "55555555555555"));
    dataList.add(ListItem("5", "55555555555555"));
    dataList.add(ListItem("5", "55555555555555"));
    dataList.add(ListItem("5", "55555555555555"));

    return SearchBar(
      height: 48,
      activeColor: Colors.orange,
      children: [
        InputMenuItem.defaultValue("name", "名称", "简建鸿"),
        DateIntervalMenuItem("date", "时间", DateFormatValue.yyyyMMddHHmmss),
        TreeMenuItem("user", "人员", (callback) {

          List<TreeData> dataList = [];
          TreeData firstTree = TreeData("1", "11111111", "111111", expanded: true);
          TreeData secondTree = TreeData("2", "222222222", "222222", expanded: true);
          TreeData cccc = TreeData("2", "44444444", "222222", expanded: true);
          dataList.add(firstTree);
          dataList.add(secondTree);
          dataList.add(cccc);
          initDat(firstTree, 2);
          initDat(secondTree, 2);
          callback.onSuccess(dataList);
        }),
        ListMenuItem.static("type", "类型", dataList),
      ],
      onSearch: (menuItems) {
        print(menuItems);
      },
    );
  }

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

