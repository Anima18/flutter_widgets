import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_widgets/components/sqlite/person.dart';
import 'package:flutter_widgets/components/sqlite/person_detail_page.dart';
import 'package:matrioska/matrioska.dart';
import 'package:provider/provider.dart';

import 'person_viewmodel.dart';

class PersonListPage extends StatefulWidget {
  @override
  _PersonListPageState createState() => _PersonListPageState();
}

class _PersonListPageState extends State<PersonListPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PersonViewModel()..getPersons(),
      builder: (ctx, _) {
        return Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text("Person List Page"),
          ),
          body: Selector<PersonViewModel, StatefulData<List<Person>>>(
            builder: (cotx, state, child) {
              return StateView(
                builder: (ctx, child) {
                  return ListView.separated(
                    itemCount: state.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Person person = state.data![index];
                      return listItem(ctx, person);
                    },
                    separatorBuilder:
                        (BuildContext context, int index) => Divider(
                      height: 1.0,
                    ),
                  );
                },
                errorMessage: state.errorMessage,
                viewState: state.state!,
                onRetry: () => context.read<PersonViewModel>().getPersons(),
              );
            },
            selector: (ctx, viewModel) => viewModel.personState,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              toDetailPage(ctx, null);
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.pink,
          ),
        );
      },
    );
  }

  Widget listItem(BuildContext ctx, Person person) {
    return Slidable(
      actionPane: SlidableScrollActionPane(),
      showAllActionsThreshold: 0.2,
      actions: [
        IconSlideAction(
          caption: "分享",
          color: Colors.blue,
          icon: Icons.share,
          onTap: () => EasyLoading.showToast("暂未实现"),
        ),
        IconSlideAction(
          caption: "保存",
          color: Colors.yellow,
          icon: Icons.save,
          onTap: () => EasyLoading.showToast("暂未实现"),
        ),
        IconSlideAction(
          caption: "删除",
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            PersonViewModel viewModel = ctx.read<PersonViewModel>();
            viewModel.delete(person).then((value) {
              viewModel.getPersons();
              EasyLoading.showSuccess("删除成功");
            }).catchError((err) {
              EasyLoading.showError(err.toString());
            });
          },
        ),
        IconSlideAction(
          caption: "关闭",
          color: Colors.white,
          icon: Icons.close,
          onTap: () => print("close"),
        ),
      ],
      actionExtentRatio: 1/4,
      child: ListTile(
        title: Text(person.name!),
        subtitle: Text(person.phone!.toString()),
        onTap: () {
          toDetailPage(ctx, person);
        },
      ),
    );

  }

  void toDetailPage(BuildContext ctx, Person? data) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (context) => PersonDetailPage(),
        // Pass the arguments as part of the RouteSettings. The
        // ExtractArgumentScreen reads the arguments from these
        // settings.
        settings: RouteSettings(
          arguments: {"data": data},
        ),
      ),
    ).then((data) {
      // 判断是否刷新
      if (data == "refresh") {
        ctx.read<PersonViewModel>().getPersons();
      }
    });
  }
}
