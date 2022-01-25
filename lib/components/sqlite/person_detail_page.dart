import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_widgets/components/sqlite/person_viewmodel.dart';
import 'package:provider/provider.dart';

import 'person.dart';

class PersonDetailPage extends StatefulWidget {
  @override
  _PersonDetailPageState createState() => _PersonDetailPageState();
}

class _PersonDetailPageState extends State<PersonDetailPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    Person? person  = arguments["data"];
    if(person != null) {
      nameController.text = person.name!;
      phoneController.text = person.phone!.toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Person"),
      ),
      body: ChangeNotifierProvider(
        create: (ctx) => PersonViewModel(),
        builder: (ctx, _) {
          return Container(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Text("名称"),
                TextField(
                  controller: nameController,
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Text("手机号码"),
                TextField(
                  controller: phoneController,
                ),
                Padding(padding: EdgeInsets.only(top: 24)),
                ElevatedButton(
                  child: Text("保存"),
                  onPressed: () {
                    Person savedPerson = Person();
                    savedPerson.name = nameController.text;
                    savedPerson.phone = phoneController.text;
                    savedPerson.id = person?.id;
                    ctx.read<PersonViewModel>().savePerson(savedPerson).then((value) {
                      EasyLoading.showSuccess("保存成功");
                      Navigator.of(context).pop("refresh");
                    }).catchError((err) {
                      EasyLoading.showError(err.toString());
                      print(err.toString());
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
