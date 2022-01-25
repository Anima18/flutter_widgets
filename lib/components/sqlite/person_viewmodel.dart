import 'package:flutter_widgets/main.dart';
import 'package:matrioska/matrioska.dart';

import 'person.dart';

class PersonViewModel extends ViewModel {
  StatefulData<List<Person>> personState = StatefulData.loading("请求中...");

  void getPersons() async {
    personState  = StatefulData.loading("请求中...");
    notifyListeners();

    personState = StatefulData.success(await personProvider.getPersons());
    notifyListeners();
  }

  Future savePerson(Person person) {
    showLoading("正在保存中");
    return personProvider.savePerson(person).whenComplete(() {
      dismissLoading();
    });
  }

  Future delete(Person person) {
    showLoading("正在删除中");
    return personProvider.delete(person).whenComplete(() {
      dismissLoading();
    });
  }
}