import 'package:flutter/material.dart';
import 'package:matrioska/matrioska.dart';


class DetailListViewTest extends StatefulWidget {
  DetailListViewTest({Key? key}) : super(key: key);

  @override
  _DetailListViewTestState createState() => _DetailListViewTestState();
}

class _DetailListViewTestState extends State<DetailListViewTest> {

  List<Template> getData() {
    return [
      Template.preview("1", "名称", TemplateWidgetType.singleText, "111"),
      Template.edit("1", "名称", TemplateWidgetType.singleText, "111"),
      Template.edit("1", "名称", TemplateWidgetType.singleText, "111"),
      Template.edit("1", "名称", TemplateWidgetType.singleText, "111"),
      Template.edit("1", "名称", TemplateWidgetType.singleText, "111"),
    ];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('MenuGroupPage'),
      ),
      body: TemplateListView(
        templates: getData(),
      ),

    );
  }


}
